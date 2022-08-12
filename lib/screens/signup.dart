import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:try_login_signup_nodejs/database/config.dart';
import 'package:try_login_signup_nodejs/models/accounts.models.dart';
import 'package:try_login_signup_nodejs/database/api_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AccountModel model = AccountModel();
  final formKey = GlobalKey<FormState>();
  String name = "";
  String username = "";
  String email = "";
  String mobileNumber = "";
  String password = "";
  String checkPassword = "";
  bool hidePass = true;
  bool hideSecondPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 60,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 25),
                    //Fullname textfield
                    TextFormField(
                      onChanged: (value) {
                        model.name = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter fullname';
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Fullname",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //Username textfield
                    TextFormField(
                      onChanged: (value) {
                        model.username = value;
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
                    //Email textfield
                    TextFormField(
                      onChanged: (value) {
                        model.email = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter email';
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //MobileNumber textfield
                    TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        model.mobileNumber = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter mobile number';
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Mobile Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //Password textfield
                    TextFormField(
                      onChanged: (value) {
                        model.password = value;
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
                    const SizedBox(height: 10),
                    //Check Password textfield
                    TextFormField(
                      onChanged: (value) {
                        checkPassword = value;
                      },
                      obscureText: hideSecondPass,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Re-enter password';
                        } else if (model.password != checkPassword) {
                          return 'Password do not match';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Re-enter password",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hideSecondPass = !hideSecondPass;
                            });
                          },
                          icon: Icon(hideSecondPass
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
                              APIService.saveProduct(model).then((response) {
                                if (response) {
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    Config.appName,
                                    "Registered Successfully",
                                    "Ok",
                                    () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                } else {
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    Config.appName,
                                    "Error Occured",
                                    "Ok",
                                    () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }
                              });
                            }
                          },
                          child: const Text("Sign-up"),
                        ),
                        const SizedBox(width: 10),
                        //Register
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(140, 40),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: const Text("Back to Login"),
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
