import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harvest_delivery/common/views/components/farmerCustomerSelector.dart';
import 'package:harvest_delivery/customerSide/view/pages/main_page.dart';
import 'package:harvest_delivery/common/views/pages/signup_page.dart';

import 'package:sign_in_button/sign_in_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.spaceAround,

              children: [

                // Title
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 30.0),
                SingleUserSelector(),

                const SizedBox(height: 30.0),

                // Email
                TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF1F4FF),
                    labelText: 'E-mail',
                  ),
                ),

                const SizedBox(height: 16),

                // Password
                TextFormField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF1F4FF),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        }),
                  ),
                ),

                const SizedBox(height: 16),

                // forgot password
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        //TODO: implement forgot password page
                        print("Forgot Password");
                      },
                      child: const Text(
                        'Forgot Password?',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Button
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => MainPage());
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Text
                RichText(
                    text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                        children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to the Sign In screen
                            Get.to(() => SignUpPage());
                          },
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
