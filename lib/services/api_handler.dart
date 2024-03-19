import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todowithapi/models/todo_model.dart';

class ApiHandler extends ChangeNotifier {
  static Future<void> postData({required ToDoModel toDoModel, required void Function(String message) showMessage,}) async {
    final body = toDoModel.toJson();
    var url = Uri.parse("https://api.nstack.in/v1/todos");
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
    if (response.statusCode==201){
      showMessage("Task created successfully");

    }else {
      showMessage("Failed to create task");
    }
  }

  static Future<List<ToDoModel>> getData() async {
    var url = Uri.parse("https://api.nstack.in/v1/todos?page=1&limit=20");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var toDoData = jsonDecode(response.body);
      List<ToDoModel> allToDo = [];
      for (var item in toDoData['items']) {
        allToDo.add(ToDoModel.fromJson(item));
      }
      print(allToDo.length);
      return allToDo;
    } else {
      throw Exception("error");
    }
  }
  static Future<void> updateData({required ToDoModel toDoModel, required void Function(String message) showMessage, required String id}) async {
    final body = toDoModel.toJson();
    var url = Uri.parse("https://api.nstack.in/v1/todos/$id");
    var response = await http.put(url,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
    if (response.statusCode==200){
      showMessage("Task updated successfully");

    }else {
      showMessage("Failed to update task");
    }
  }
  static Future<void> delete({required void Function(String message) showMessage, required String id}) async {
    var url = Uri.parse("https://api.nstack.in/v1/todos/$id");
    var response = await http.delete(url);
    if (response.statusCode==200){
      showMessage("Task deleted ");

    }else {
      showMessage("Failed to delete task");
    }
  }

  static Future<void> check({required ToDoModel toDoModel, required String id}) async {
    final body = toDoModel.toJson();
    var url = Uri.parse("https://api.nstack.in/v1/todos/$id");
    var response = await http.put(url,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
    if (response.statusCode==200){
    print("object");

    }else {
      print("no object");

    }
  }
}
/*
  static Future<void> updateData(String id) async {
    var url = Uri.parse("//api.nstack.in/v1/todos/$id");
    var response = http.put(url,body: );

}
*/
