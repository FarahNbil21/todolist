import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/data/database.dart';
import 'package:todolist/utils/dialogbox.dart';
import 'package:todolist/utils/todotile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ToDoDatabase db = ToDoDatabase();
  // reference the hive box
  final _todobox = Hive.box("todobox");
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // if this is the first time ever opening this app
    if (_todobox.get("TODOLIST") == null) {
      db.createInitalData();
      db.updateDataBase();
    } else {
      db.loadData();
    }
  }

  // to make it cabable
  void checkboxchanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
    });
    db.updateDataBase();
  }

  void createtask() {
    setState(() {
      db.todolist.add([_controller.text, false]);
      _controller.clear();
    });

    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //creating a new task
  void createnewtask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogeBox(
          controller: _controller,
          onSave: createtask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
    db.updateDataBase();
  }

  void combeletedtasks(int index) {
    setState(() {
      db.todolist.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.large(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        onPressed: createnewtask,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Mission Controler"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 162, 83, 215),
        elevation: 0.0,
      ),
      body: db.todolist.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 80, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    "Your to-do list is napping. Wake it up with the + button!",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: db.todolist.length,
              itemBuilder: (context, index) {
                return Todotile(
                  taskName: db.todolist[index][0],
                  combeletedTask: db.todolist[index][1],
                  onChanged: (value) => checkboxchanged(value, index),
                  deletetask: (context) {
                    combeletedtasks(index);
                  },
                );
              },
            ),
    );
  }
}
