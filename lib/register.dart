import 'dart:convert';
import 'package:work_schedule/login.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:work_schedule/http.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  Future<void> registerUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text
      };

      try {
        var response = await http.post(
          Uri.parse(register),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse['status']) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          } else {
            print("Registration failed");
          }
        }
      } catch (e) {
        print("Error: $e");
      }
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
              end: FractionalOffset.bottomRight,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CREATE YOUR ACCOUNT',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(150, 255, 255, 255),
                      hintText: "Email",
                      errorText: _isNotValidate ? "Enter proper info" : null,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon:
                          IconButton(onPressed: () {}, icon: Icon(Icons.copy)),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.password),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(150, 255, 255, 255),
                      hintText: "Password",
                      errorText: _isNotValidate ? "Enter proper info" : null,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        registerUser();
                      },
                      child: HStack([
                        VxBox(
                                child: "Register"
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: HStack([
                      "Already Registered? ".text.make(),
                      "Sign in".text.make(),
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
