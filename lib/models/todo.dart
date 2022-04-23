class Todo {
  bool? done;
  String? todo;

  Todo({required this.done, required this.todo});

  Todo.fromJson(Map<String, dynamic> json) {
    done = json['done'] ?? '';
    todo = json['todo'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['done'] = this.done;
    data['todo'] = this.todo;
    return data;
  }
}
