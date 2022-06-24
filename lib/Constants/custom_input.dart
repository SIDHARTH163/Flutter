// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/constants.dart';
class input extends StatelessWidget {
  final String hinttext;
   
   final Function(String) Onchanged;
   
    final TextInputAction textInputAction;
     final bool isPasswordField;
  // ignore: use_key_in_widget_constructors
   const input({ required this.hinttext, required this.Onchanged, required this.textInputAction, required this.isPasswordField,}) ;

  @override
  Widget build(BuildContext context) {
    bool _isPasswordFeild=isPasswordField ;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 12.0 ,
        horizontal: 24.0
      ),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue, width: 2.0),
       ),
      child: TextField(
        obscureText: _isPasswordFeild,
        onChanged: Onchanged,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hinttext ,
     contentPadding: const EdgeInsets.symmetric(vertical: 18.0 , horizontal: 24.0)
        ),
        style: constants.regulartext,
       
      ),
      
    );
  }
}