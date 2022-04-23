part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetTodoList extends TodoEvent {}

class AddTodo extends TodoEvent {
  const AddTodo({required this.todo});

  final String todo;

  @override
  List<Object> get props => [todo];
}

class RemoveTodo extends TodoEvent {
  const RemoveTodo({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}

class UpdateTodoList extends TodoEvent {}

class DiscardUpdateTodoList extends TodoEvent {}

class CheckedTodoList extends TodoEvent {
  const CheckedTodoList({required this.value, required this.index});

  final bool? value;
  final int index;

  @override
  List<Object> get props => [value ?? false, index];
}
