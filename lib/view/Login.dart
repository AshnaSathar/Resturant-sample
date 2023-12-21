import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_Constants.dart';

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
      backgroundColor: ColorsUsed.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsUsed.backgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Please Login To Your Account.",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 50, left: 50, bottom: 30),
                //   child: Text(
                //     "LOGIN",
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 18),
                //   ),
                // ),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 310,
                          decoration: BoxDecoration(
                              color: ColorsUsed.textFormFieldColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              fillColor: ColorsUsed.textFormFieldColor,
                              border: OutlineInputBorder(),
                              hintText: "Enter Your Username",
                              hintStyle: TextStyle(color: ColorsUsed.textColor),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 310,
                          decoration: BoxDecoration(
                              color: ColorsUsed.textFormFieldColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              fillColor: ColorsUsed.textFormFieldColor,
                              border: OutlineInputBorder(),
                              hintText: "Enter Your password",
                              hintStyle: TextStyle(color: ColorsUsed.textColor),
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
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            obscureText: !isPasswordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 10, right: 10),
                        child: Container(
                            height: 70,
                            width: 250,
                            child: ButtonWidget(title: "Login")),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://static.vecteezy.com/system/resources/previews/013/760/951/non_2x/colourful-google-logo-in-dark-background-free-vector.jpg"),
                      ),
                      Text(
                        " Login With Google",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont Have An Account? \n\n",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      " SIGN UP\n\n",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
