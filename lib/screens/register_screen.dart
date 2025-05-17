import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF2B475E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Spacer(flex: 2),
            Image.asset('assets/images/scholar.png'),
            Text(
              'Scholar Chat',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'pacifico',
              ),
            ),
            Spacer(flex: 2),
            Row(
              children: [
                Text(
                  'Register',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 15),
            CustomTextField(hintText: 'Email'),
            SizedBox(height: 10),
            CustomTextField(hintText: 'Password'),
            SizedBox(height: 20),
            CustomButton(text: 'Register'),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'already have an account? ',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '  Login',
                  style: TextStyle(color: Color(0xffc7ede6)),
                ),
              ],
            ),
            Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}
