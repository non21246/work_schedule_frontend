import 'dart:convert';
import 'package:work_schedule/register.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:work_schedule/dashboard.dart';
import 'package:work_schedule/http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _emailIsNotValidate = false;
  bool _passwordIsNotValidate = false;
  bool _isPasswordVisible = false;

  Future<void> loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var loginBody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      try {
        var response = await http.post(Uri.parse(login),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(loginBody));
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status']) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DashboardPage()));
        } else {
          throw ("Login failed");
        }
      } catch (error) {
        throw error;
      }
    } else if (emailController.text.isEmpty) {
      setState(() {
        _emailIsNotValidate = true;
      });
    } else if (passwordController.text.isEmpty) {
      setState(() {
        _passwordIsNotValidate = true;
      });
    }
  }

  void passwordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(243, 223, 192, 1),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(150, 255, 255, 255),
                      hintText: "Email",
                      errorText: _emailIsNotValidate ? "Email is Empty" : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.4),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(150, 255, 255, 255),
                      hintText: "Password",
                      errorText:
                          _passwordIsNotValidate ? "Password is Empty" : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.4),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: passwordVisibility,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        loginUser();
                      },
                      child: HStack([
                        VxBox(
                                child: "Sign in"
                                    .text
                                    .white
                                    .makeCentered()
                                    .px16()
                                    .py8())
                            .blue500
                            .roundedLg
                            .make()
                            .py16()
                      ])),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: HStack([
                      "Create a new account? ".text.make(),
                      "Sign up".text.make()
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
