import 'package:flutter/material.dart';

import '../widgets/CustomTextfield.dart';
import '../widgets/CustomeButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passwordController = TextEditingController();
  late bool isPasswordVisible = false;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppTextField(
                  title: 'Enter your Username',
                  inputType: TextInputType.emailAddress,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Your password",
                      hintStyle: TextStyle(color: Colors.black),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: Icon(
                          size: 15,
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    obscureText: !isPasswordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                ButtonWidget(title: "Login")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
