import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter_app/add_to_do_screen.dart';
import 'package:hive_flutter_app/to_do.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box toDoBox = Hive.box<ToDo>('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive Database'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: toDoBox.listenable(),
          builder: (context, Box box, widget) {
            if (box.isEmpty) {
              return Center(
                child: Text(
                  'No Todo Available',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return ListView.separated(
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ToDo toDo = box.getAt(index);
                  return Row(
                    children: [
                      Text(
                        '${toDo.title}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: toDo.isCompleted ? Colors.green : Colors.black,
                          decoration: toDo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      Spacer(),
                      Checkbox(
                        value: toDo.isCompleted,
                        onChanged: (isCompleted) {
                          ToDo newToDo =
                              ToDo(title: toDo.title, isCompleted: isCompleted!);
                          box.putAt(index, newToDo);
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          box.deleteAt(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('ToDo Deleted Successfully'),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: double.infinity,
                  thickness: 1.0,
                  color: Colors.grey[300],
                ),
                itemCount: box.length,
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddToDoScreen()));
        },
      ),
    );
  }
}
