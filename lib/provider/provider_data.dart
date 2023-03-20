

import 'package:flutter/material.dart';

import '../model/Todo.dart';


class ProviderData extends ChangeNotifier {

    List<Todo>? bringTasks;

    Todo? task;

    void taskList(List<Todo> tasks){
      bringTasks = tasks;
      notifyListeners();
    }

    void singleTask(Todo task){
      task = task;
      notifyListeners();
    }

}