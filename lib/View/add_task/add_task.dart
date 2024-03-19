import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todowithapi/ViewModel/pi_view_model.dart';
import 'package:todowithapi/models/todo_model.dart';
import 'package:todowithapi/shared/appstyle.dart';

class AddTasks extends StatefulWidget {
  AddTasks({Key? key, required this.isEdit, this.index}) : super(key: key);
  bool isEdit = false;
  int? index;

  @override
  State<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  @override
  void initState() {
    if (widget.isEdit == true) {
      titleController.text =
          context.read<ApiViewModel>().allToDo[widget.index!].title;
      desController.text =
          context.read<ApiViewModel>().allToDo[widget.index!].description;
    }
    super.initState();
  }

  final TextEditingController titleController = TextEditingController();

  final TextEditingController desController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: const Color(0xffDFBD43),
        title: Text(
          widget.isEdit ? "Update Task " : "New Task",
          style:
              appTextStyle(FontWeight.bold, 18).copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.title,
                  ),
                  label: Text(
                    "Name your new task",
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: desController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.description,
                  ),
                  label: Text(
                    "Describe it",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffDFBD43),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final toDoData = ToDoModel(
                        title: titleController.text,
                        description: desController.text,
                        isCompleted: false,
                      );
                      widget.isEdit == true
                          ? await context.read<ApiViewModel>().updateData(
                              toDoData,
                              context
                                  .read<ApiViewModel>()
                                  .allToDo[widget.index!]
                                  .id!, (message) {
                              if (message == "Task updated successfully") {
                                Navigator.of(context).pop();
                              }
                              return ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                  backgroundColor:
                                      message == "Task updated successfully"
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              );
                            })
                          : await context
                              .read<ApiViewModel>()
                              .postData(toDoData, (message) {
                              if (message == "Task created successfully") {
                                Navigator.of(context).pop();
                              }
                              return ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                  backgroundColor:
                                      message == "Task created successfully"
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              );
                            });
                    },
                    child: Text(
                      widget.isEdit == true ? "Update Task" : "Create Task",
                      style: appTextStyle(
                        FontWeight.bold,
                        16,
                      ).copyWith(color: Colors.black),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
