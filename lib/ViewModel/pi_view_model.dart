import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todowithapi/models/todo_model.dart';
import 'package:todowithapi/services/api_handler.dart';

class ApiViewModel extends ChangeNotifier {
  List<ToDoModel> _allToDo = [];
  bool isLoading =true;

  List<ToDoModel> get allToDo => _allToDo;

  Future<void> postData(
    ToDoModel toDoModel,
    Function(String message) showMessage,
  ) async {
    try {
      await ApiHandler.postData(toDoModel: toDoModel, showMessage: showMessage);
      _allToDo = await ApiHandler.getData();
      notifyListeners();
    } catch (e) {
      log('Failed to post data. Error: $e');
    }
  }
  Future<void> updateData(
      ToDoModel toDoModel,
      String id,
      Function(String message) showMessage,
      ) async {
    try {
      await ApiHandler.updateData(toDoModel: toDoModel, showMessage: showMessage, id: id);
      _allToDo = await ApiHandler.getData();
      notifyListeners();
    } catch (e) {
      log('Failed to update data. Error: $e');
    }
  }

   getData() async {
    try {
      _allToDo = await ApiHandler.getData();
      notifyListeners();
      isLoading=false;
      print(_allToDo.length);
    } catch (e) {
      log('Failed to get data. Error: $e');
    }
  }

  Future<void> deleteTask(
      String id,
      Function(String message) showMessage,
      ) async {
    try {
      await ApiHandler.delete(showMessage: showMessage, id: id);
      _allToDo = await ApiHandler.getData();
      notifyListeners();
    } catch (e) {
      log('Failed to delete data. Error: $e');
    }
  }

  Future<void> check(
      ToDoModel toDoModel,
      String id,
      ) async {
    try {
      await ApiHandler.check(toDoModel: toDoModel, id: id);
      _allToDo = await ApiHandler.getData();
      notifyListeners();
    } catch (e) {
      log('Failed to update data. Error: $e');
    }
  }


}
