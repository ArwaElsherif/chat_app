// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   const CustomButton({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              width: double.infinity,
              height: 40,
              child: Center(child: Text(
                text,
              )),
             );
  }
}