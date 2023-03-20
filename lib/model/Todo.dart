class Todo {
  String id;
  String title;
  String description;



  Todo(
      this.id,
      this.title,
      this.description,
      );


  factory Todo.fromJson(Map<String,dynamic> json){
    return Todo(
      json["id"] as String,
      json["title"] as String,
      json["description"] as String,
    );
  }



}