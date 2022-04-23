import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo_bloc.dart';

class TodoListWidget extends StatefulWidget {
  bool editMode;

  TodoListWidget({
    Key? key,
    this.editMode = false,
  }) : super(key: key);

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return Container(
            height: MediaQuery.of(context).size.height / 1.5,
            width: double.maxFinite,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0, left: 0, bottom: 0),
              itemCount: state.tempTodoList.length,
              itemBuilder: (_, index) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                  activeColor: Colors.blueGrey.shade100,
                                  value: state.tempTodoList[index].done,
                                  onChanged: (bool? value) {
                                    if (widget.editMode == false) {
                                      BlocProvider.of<TodoBloc>(context).add(
                                          CheckedTodoList(
                                              value: value, index: index));
                                    }
                                  }),
                            ),
                            Text(
                              state.tempTodoList[index].todo.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: state.tempTodoList[index].done!
                                      ? Colors.grey.shade500
                                      : Colors.black,
                                  decoration: state.tempTodoList[index].done!
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: widget.editMode == false
                              ? null
                              : IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red.shade600,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<TodoBloc>(context)
                                        .add(RemoveTodo(index: index));
                                  },
                                ))
                    ],
                  ),
                );
              },
            ));
      },
    );
  }
}
