
import 'package:afsgo_case_study/model/Todo.dart';

class Todos {

  late List<Todo> todo_list;
  Todos(this.todo_list);

  factory Todos.fromJson(Map<String, dynamic> json){
    var jsonArray = json["tasks"] as List;
    List<Todo> todo_list = jsonArray.map((jsonList) => Todo.fromJson(jsonList)).toList();
    return Todos(todo_list);
  }

}