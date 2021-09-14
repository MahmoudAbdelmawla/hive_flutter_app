import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter_app/to_do.dart';

class AddToDoScreen extends StatelessWidget {
  AddToDoScreen({Key? key}) : super(key: key);
  TextEditingController titleController = TextEditingController();
  Box todoBox = Hive.box<ToDo>('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Add Title',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 48.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if(titleController.text != ''){
                    ToDo newToDo = ToDo(title: titleController.text, isCompleted: false);
                    todoBox.add(newToDo);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Add ToDo',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
