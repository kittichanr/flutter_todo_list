part of 'todo_bloc.dart';

class TodoState extends Equatable {
  TodoState({
    List<Todo>? todoList,
    List<Todo>? tempTodoList,
  })  : todoList = todoList ??
            [
              Todo(done: true, todo: 'Go to Market'),
              Todo(done: false, todo: 'Meet Friends')
            ],
        tempTodoList = tempTodoList ??
            [
              Todo(done: true, todo: 'Go to Market'),
              Todo(done: false, todo: 'Meet Friends')
            ];

  final List<Todo> todoList;
  final List<Todo> tempTodoList;

  TodoState copyWith({List<Todo>? todoList, List<Todo>? tempTodoList}) {
    return TodoState(
      todoList: todoList,
      tempTodoList: tempTodoList,
    );
  }

  @override
  List<Object> get props => [todoList, tempTodoList];
}
