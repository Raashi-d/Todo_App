// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;


  TodoTile({super.key,
    required this.taskName,
    required this.taskCompleted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: 
        Row(
          children: [
            // Checkbox
            Checkbox(
              value: taskCompleted,
              onChanged: onChanged,
              activeColor: Colors.black,
            ),

            // Task Name
            Text(taskName,
              style: TextStyle(decoration: taskCompleted? TextDecoration.lineThrough:TextDecoration.none),),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}