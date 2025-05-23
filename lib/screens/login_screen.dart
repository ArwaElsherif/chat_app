// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously

import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      'Login',
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
                  text: 'Login',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
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
                      try {
                        await loginUser();
                        Navigator.pushNamed(
                          context,
                          ChatScreen.id,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (e) {
                          print('Error code: ${e.code}');  
                        String message;
                        switch (e.code) {
                          case 'user-not-found':
                            message = 'No user found for this email.';
                            break;
                          case 'wrong-password':
                          
                            message = 'Wrong password provided.';
                            break;
                          case 'invalid-email':
                            message = 'The email address is invalid.';
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
                           print('Error code: ${e.code}'); 
                            message = 'email or password may be wrong, try again.';
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
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text(
                        ' Register',
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

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
