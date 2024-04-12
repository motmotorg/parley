import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:parley/constant.dart';
import 'package:parley/controllers/auth_controller.dart';
import 'package:parley/controllers/auth_ui_controller.dart';
import 'package:parley/screens/auth/login_view.dart';
import 'package:parley/screens/home/home_view.dart';


class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
    var theme = Theme.of(context);
    AuthUIController authUIController = Get.find<AuthUIController>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child:  Column(
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
                    'Sign Up',
                    style: kLoginTitleStyle(size),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Create Account',
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
                        /// username
                        TextFormField(
                          style: kTextFormFieldStyle(),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Username',
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

                        /// Email
                        TextFormField(
                          style: kTextFormFieldStyle(),
                          controller: emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            String pattern =
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                r"{0,253}[a-zA-Z0-9])?)*$";
                            RegExp regExp = RegExp(pattern);
                            if (value!.isEmpty) {
                              return 'Email is required';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Invalid Email';
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
                            obscureText: authUIController.isObscure.value,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_open),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  authUIController.isObscure.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  authUIController.isObscureActive();
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
                              } else if (value.length < 6) {
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

                        /// SignUp Button
                        signUpButton(theme),
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

                            authUIController.isObscure.value = true;
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account?',
                              style: kHaveAnAccountStyle(size),
                              children: [
                                TextSpan(
                                    text: " Login",
                                    style: kLoginOrSignUpTextStyle(size)),
                              ],
                            ),
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
          )),
    );
  }


  // SignUp Button
  Widget signUpButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () async {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            if ((await AuthController().signUp(
                username: nameController.text,
                email: emailController.text,
                password: passwordController.text))
            ) {
              Get.offAll(const HomeView());
            }
          }
        },
        child: const Text('Sign up',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
