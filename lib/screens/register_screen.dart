// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously

import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 75),
                Image.asset(kLogo, height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 75),
                Row(
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                CustomTextFormField(
                  hintText: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  hintText: 'Password',
                  onChanged: (data) {
                    password = data;
                  },
                  isPassword: true,
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        if (email == null || password == null) {
                          showSnackBar(
                            context,
                            'Email and password are required.',
                            Colors.red,
                          );
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }
                        await registerUser();
                        showSnackBar(
                          context,
                          'Success! User registered.',
                          Colors.green,
                        );
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        String message;
                        switch (e.code) {
                          case 'user-not-found':
                            message = 'No user found for this email.';
                            break;
                          case 'wrong-password':
                            message = 'Wrong password provided.';
                            break;
                          case 'weak-password':
                            message = 'The password is too weak.';
                            break;
                          case 'email-already-in-use':
                            message = 'This email is already in use.';
                            break;
                          case 'invalid-email':
                            message = 'The email address is invalid.';
                            break;
                          case 'operation-not-allowed':
                            message =
                                'Email/password accounts are not enabled.';
                            break;
                          case 'network-request-failed':
                            message =
                                'Network error. Please check your connection.';
                            break;
                          case 'too-many-requests':
                            message =
                                'Too many requests. Please try again later.';
                            break;
                          default:
                            message = e.message ?? 'An unknown error occurred.';
                        }
                        showSnackBar(context, message, Colors.red);
                      } catch (e) {
                        showSnackBar(
                          context,
                          'Something went wrong: $e',
                          Colors.red,
                        );
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, ChatScreen.id);
                      },
                      child: Text(
                        '  Login',
                        style: TextStyle(color: Color(0xffc7ede6)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
