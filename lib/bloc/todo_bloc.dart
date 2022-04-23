import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/models/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState()) {
    on<AddTodo>(_addTodo);
    on<RemoveTodo>(_removeTodo);
    on<UpdateTodoList>(_updateTodo);
    on<DiscardUpdateTodoList>(_discardUpdateTodo);
    on<CheckedTodoList>(_checkedTodo);
  }

  void _addTodo(AddTodo event, Emitter<TodoState> emit) {
    emit(TodoState(todoList: [
      ...state.todoList,
      Todo(done: false, todo: event.todo)
    ], tempTodoList: [
      ...state.tempTodoList,
      Todo(done: false, todo: event.todo),
    ]));
  }

  void _removeTodo(RemoveTodo event, Emitter<TodoState> emit) {
    emit(TodoState(
        tempTodoList: state.tempTodoList
            .where((element) =>
                element.todo != state.tempTodoList[event.index].todo)
            .toList(),
        todoList: state.todoList));
  }

  void _updateTodo(UpdateTodoList event, Emitter<TodoState> emit) {
    emit(TodoState().copyWith(
        todoList: state.tempTodoList, tempTodoList: state.tempTodoList));
  }

  void _discardUpdateTodo(
      DiscardUpdateTodoList event, Emitter<TodoState> emit) {
    emit(TodoState()
        .copyWith(tempTodoList: state.todoList, todoList: state.todoList));
  }

  void _checkedTodo(CheckedTodoList event, Emitter<TodoState> emit) {
    emit(TodoState(
        tempTodoList: state.tempTodoList.asMap().entries.map((entry) {
          int idx = entry.key;
          Todo val = entry.value;
          if (event.index == idx) {
            return Todo(done: event.value, todo: val.todo);
          }
          return Todo(done: val.done, todo: val.todo);
        }).toList(),
        todoList: state.todoList.asMap().entries.map((entry) {
          int idx = entry.key;
          Todo val = entry.value;
          if (event.index == idx) {
            return Todo(done: event.value, todo: val.todo);
          }
          return Todo(done: val.done, todo: val.todo);
        }).toList()));
  }
}
