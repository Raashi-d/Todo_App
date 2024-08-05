// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tudo_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  
  final controller;
  VoidCallback onSaved;
  VoidCallback onCancel;

  DialogBox({
    super.key, 
    required this.controller,
    required this.onSaved,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: 
      Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //to get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add A New Task"
              ),
            ),

            //buttons => save & cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
              // save button
              MyButton(
                text: "Save",
                onPressed: onSaved,
              ),
              // cancel button
              MyButton(
                text: "Cancel",
                onPressed: onCancel,
              ),
            ],

            )
        ],),
      )
    );
  }
}