import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:parley/constant.dart';
import 'package:parley/controllers/simple_ui_controller.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SimpleUIController simpleUIController = Get.find<SimpleUIController>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
            MainAxisAlignment.start,
            children: [
              Lottie.asset(
                'assets/wave.json',
                height: size.height * 0.2,
                width: size.width,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Login',
                  style: kLoginTitleStyle(size),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Welcome Back Catchy',
                  style: kLoginSubtitleStyle(size),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /// username or Gmail
                      TextFormField(
                        style: kTextFormFieldStyle(),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Username or Gmail',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        controller: nameController,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
                          } else if (value.length < 4) {
                            return 'at least enter 4 characters';
                          } else if (value.length > 13) {
                            return 'maximum character is 13';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// password
                      Obx(
                            () => TextFormField(
                          style: kTextFormFieldStyle(),
                          controller: passwordController,
                          obscureText: simpleUIController.isObscure.value,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_open),
                            suffixIcon: IconButton(
                              icon: Icon(
                                simpleUIController.isObscure.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                simpleUIController.isObscureActive();
                              },
                            ),
                            hintText: 'Password',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else if (value.length < 7) {
                              return 'at least enter 6 characters';
                            } else if (value.length > 13) {
                              return 'maximum character is 13';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                        style: kLoginTermsAndPrivacyStyle(size),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),

                      /// Login Button
                      loginButton(),
                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      /// Navigate To Login Screen
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          nameController.clear();
                          emailController.clear();
                          passwordController.clear();
                          _formKey.currentState?.reset();
                          simpleUIController.isObscure.value = true;
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: kHaveAnAccountStyle(size),
                            children: [
                              TextSpan(
                                text: " Sign up",
                                style: kLoginOrSignUpTextStyle(
                                  size,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  // Login Button
  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          textStyle: MaterialStateProperty.all(const TextStyle(
            color: Colors.white
          )),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            // ... Navigate To your Home Page
          }
        },
        child: const Text('Login',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
