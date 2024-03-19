import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todowithapi/View/add_task/add_task.dart';
import 'package:todowithapi/ViewModel/pi_view_model.dart';

import '../../../models/todo_model.dart';
import '../../../shared/appstyle.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.index,
  });

  final int index;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffD6D6D6), width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.watch<ApiViewModel>().allToDo[index].title,
              style: context.watch<ApiViewModel>().allToDo[index].isCompleted
                  ? appTextStyle(FontWeight.bold, 16)
                      .copyWith(decoration: TextDecoration.lineThrough)
                  : appTextStyle(FontWeight.bold, 16),
            ),
            Text(
              context.watch<ApiViewModel>().allToDo[index].description,
              style: appTextStyle(FontWeight.normal, 13),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.parse(
                    context.watch<ApiViewModel>().allToDo[index].createdAt!))),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        print(index);
                        print(context.read<ApiViewModel>().allToDo[index!].id!);

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddTasks(
                            isEdit: true,
                            index: index,
                          ),
                        ));
                      },
                      icon: const Icon(
                        Icons.edit_note,
                        color: Color(0xffDFBD43),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Delete Task',
                                  style: appTextStyle(FontWeight.bold, 14),
                                ),
                                content: Text(
                                    'Are you sure you want to delete this task?',
                                    style: appTextStyle(FontWeight.bold, 12)),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<ApiViewModel>().deleteTask(
                                          context
                                              .read<ApiViewModel>()
                                              .allToDo[index]
                                              .id!, (message) {
                                        if (message == "Task deleted ") {
                                          Navigator.of(context).pop();
                                        }
                                        return ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(message),
                                            backgroundColor:
                                            message == "Task deleted "
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        );
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,foregroundColor: Colors.black),
                                    child: const Text("Delete Task"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,foregroundColor: Colors.black),
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon:
                            const Icon(Icons.delete, color: Color(0xffDFBD43))),
                    Checkbox(
                      activeColor: const Color(0xffDFBD43),
                      value:   context.watch<ApiViewModel>().allToDo[index].isCompleted,
                      onChanged: (value) {
                        final toDoData = ToDoModel(
                          title:context.read<ApiViewModel>().allToDo[index].title ,
                          description: context.read<ApiViewModel>().allToDo[index].description,
                          isCompleted: value!,
                        );
                        context.read<ApiViewModel>().check(toDoData, context.read<ApiViewModel>().allToDo[index].id!);
                        print(  context.read<ApiViewModel>().allToDo[index].isCompleted,);
                        print(  context.read<ApiViewModel>().allToDo[index].title,);
                      },
                    )

                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
