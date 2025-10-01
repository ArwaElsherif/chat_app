// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously

import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  String? email;
  String? password;
  static String id = 'RegisterScreen';

  GlobalKey<FormState> formKey = GlobalKey();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushNamed(context, LoginScreen.id, arguments: state.email);
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errorMessage, Colors.red);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is RegisterLoading,
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
                          if (email == null || password == null) {
                            showSnackBar(
                              context,
                              'Email and password are required.',
                              Colors.red,
                            );
                          } else {
                            context.read<AuthCubit>().registerUser(
                              email: email!,
                              password: password!,
                            );
                          }
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
      },
    );
  }
}
