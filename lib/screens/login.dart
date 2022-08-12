// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool hidePass = true;
  String username = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 200, horizontal: 50),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 60,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 25),
                    //Username textfield
                    TextFormField(
                      onChanged: (value) {
                        username = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter username';
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //Password textfield
                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: hidePass,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePass = !hidePass;
                            });
                          },
                          icon: Icon(hidePass
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Login Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(140, 40),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print(username + " " + password);
                            }
                          },
                          child: const Text("Login"),
                        ),
                        const SizedBox(width: 10),
                        //Register
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(140, 40),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/sign-up');
                          },
                          child: const Text("Register"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
