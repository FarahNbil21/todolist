import 'package:hive/hive.dart';

class ToDoDatabase {
  List todolist = [];

  //run this method if this the 1f time to open this app
  void createInitalData() {
    todolist = [
      ["make a tutorial", true],
      ["Take a shower", false],
    ];
  }

  void loadData() {
    final todobox = Hive.box("todobox");
    todolist = todobox.get("TODOLISt", defaultValue: []);
  }

  void updateDataBase() {
    final todobox = Hive.box("todobox");
    todobox.put("TODOLIST", todolist);
  }
}
