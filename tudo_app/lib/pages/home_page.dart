// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tudo_app/util/dialog_box.dart';
import 'package:tudo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List toDoList = [
    ["Prepare to exam", false],
    ["Go to the gym", false],
  ];


  //check box tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      toDoList[index][1] = value!;
    });
  }

  //save new task
  void saveNewTask(){
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.pop(context);
  }

  //create new task
  void createNewTask(){
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller: _controller, // give access to the input of the dialog box
          onSaved: saveNewTask, // save the new task
          onCancel: () => Navigator.pop(context), // close the dialog box
        );
      },

    );
  }

  //delete task
  void deleteTask(int index){
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('To Do',),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),


      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder:(context, index){
          return TodoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) =>checkBoxChanged(value, index),
            //deleteFunction: (context) => deleteTask,
          );
        } ,
      ),
    );
  }
}