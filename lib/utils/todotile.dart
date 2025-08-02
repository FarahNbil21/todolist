import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Todotile extends StatelessWidget {
  final String taskName;
  final bool combeletedTask;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deletetask;
  const Todotile({
    super.key,
    required this.taskName,
    required this.combeletedTask,
    required this.onChanged,
    required this.deletetask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deletetask,
              icon: Icons.delete,
              backgroundColor: const Color.fromARGB(255, 229, 19, 4),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 186, 243),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Row(
            children: [
              Checkbox(
                value: combeletedTask,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Text(
                taskName,
                style: TextStyle(
                  decoration: combeletedTask
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
