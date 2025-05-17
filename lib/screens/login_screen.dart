import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF2B475E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Spacer(flex: 2,),
            Image.asset('assets/images/scholar.png'),
            Text(
              'Scholar Chat',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontFamily: 'pacifico',
              ),
            ),
            Spacer(flex: 2,),
            Row(
              children: [
                Text('LOGIN', style: TextStyle(fontSize: 24, color: Colors.white)),
              ],
            ),
            SizedBox(height: 15,),
            CustomTextField(hintText: 'Email',),
            SizedBox(height: 10,),
            CustomTextField(hintText: 'Password',),
            SizedBox(height: 20,), 
            CustomButton(text: 'LOGIN',),
            SizedBox(height: 10,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('don\'t have an account?',
                style: TextStyle(
                  color: Colors.white,
                ),
                ),
                GestureDetector(
                                    onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterScreen();
                        },
                      ),
                    );
                  },
                  child: Text('   Register',
                  style: TextStyle(
                    color: Color(0xffc7ede6),
                  ),
                  ),
                )
              ],
             ),
             Spacer(flex: 4,)
          ],
        ),
      ),
    );
  }
}
