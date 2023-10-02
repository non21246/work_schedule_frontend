import 'dart:convert';
import 'package:work_schedule/register.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:work_schedule/work.dart';
import 'package:work_schedule/http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  Future<void> loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var loginBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(loginBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WorkPage()));
      }
      ;
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(0, 43, 1, 255),
                  Color.fromARGB(255, 0, 234, 255)
                ],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(150, 255, 255, 255),
                      hintText: "Email",
                      errorText: _isNotValidate ? "Enter proper info" : null,
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
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(150, 255, 255, 255),
                      hintText: "Password",
                      errorText: _isNotValidate ? "Enter proper info" : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.4),
                        ),
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
