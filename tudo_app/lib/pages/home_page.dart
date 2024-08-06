// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tudo_app/data/database.dart';
import 'package:tudo_app/util/dialog_box.dart';
import 'package:tudo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // reference the hive box
  final _myBox = Hive.box('myBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {

  //if this is the first time ever opening the app then create default data
  if(_myBox.get('TODOLIST') == null){
    db.createInitialData();
  }else{ //if there already data in the database then load it
    db.loadData();

  }

    super.initState();
  }

  //controller for the dialog box
  final _controller = TextEditingController();



  //check box tapped
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  //save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.pop(context);
    db.updateData();
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
      db.toDoList.removeAt(index);
    });
    db.updateData();
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
        itemCount: db.toDoList.length,
        itemBuilder:(context, index){
          return TodoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) =>checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        } ,
      ),
    );
  }
}