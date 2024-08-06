import 'package:hive/hive.dart';

class ToDoDataBase {

  List toDoList = [];

  //reference to hive box
  final _myBox = Hive.box('myBox');
  
  //run this method if it the first time ever opening the app
  void createInitialData(){
    toDoList = [
      ["Make Tutorial", false],
      ["Go To Gym", false],
       
    ];
  }

  //load the data from the database
  void loadData(){
    toDoList = _myBox.get('TODOLIST');
  }

  //update the data in the database
  void updateData(){
    _myBox.put('TODOLIST', toDoList);
  }
}