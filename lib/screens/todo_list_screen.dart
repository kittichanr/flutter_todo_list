import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo_bloc.dart';
import 'package:todo_list/models/custom_popup_menu.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todo_list_widget.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  TextEditingController _textFieldController = TextEditingController();

  List<CustomPopupMenu> choices = <CustomPopupMenu>[
    CustomPopupMenu(
      title: 'Edit',
      icon: Icons.edit,
    ),
  ];

  bool editMode = false;

  void _select(CustomPopupMenu choice) {
    setState(() {
      if (choice.title == 'Edit') {
        editMode = true;
      }
    });
  }

  displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('New Your TODO'),
          content: TextField(
            controller: _textFieldController,
            textInputAction: TextInputAction.go,
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(hintText: "Enter your TODO"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                BlocProvider.of<TodoBloc>(context)
                    .add(AddTodo(todo: _textFieldController.text));
                _textFieldController.clear();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation: editMode == false
              ? FloatingActionButtonLocation.endFloat
              : FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: editMode == false
                ? FloatingActionButton(
                    onPressed: () {
                      displayDialog(context);
                    },
                    backgroundColor: Colors.tealAccent.shade400,
                    child: Icon(Icons.add, size: 36),
                  )
                : Row(
                    children: [
                      Container(
                        child: FloatingActionButton(
                          onPressed: () {
                            BlocProvider.of<TodoBloc>(context)
                                .add(DiscardUpdateTodoList());
                            setState(() {
                              editMode = false;
                            });
                          },
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red.shade700,
                        ),
                      ),
                      Spacer(),
                      FloatingActionButton(
                        onPressed: () {
                          BlocProvider.of<TodoBloc>(context)
                              .add(UpdateTodoList());
                          setState(() {
                            editMode = false;
                          });
                        },
                        backgroundColor: Colors.yellowAccent.shade700,
                        child: Icon(Icons.save, size: 36),
                      ),
                    ],
                  ),
          ),
          body: Container(
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      decoration: BoxDecoration(
                          color: Colors.yellowAccent.shade100,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(150),
                            bottomRight: Radius.circular(150),
                          )),
                    )),
                Positioned(
                  top: 48,
                  left: 32,
                  right: 32,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back),
                            iconSize: 32),
                        PopupMenuButton<CustomPopupMenu>(
                          child: const Icon(
                            Icons.more_vert,
                            size: 32,
                          ),
                          elevation: 3.2,
                          onCanceled: () {
                            print('You have not chossed anything');
                          },
                          tooltip: 'This is tooltip',
                          onSelected: _select,
                          itemBuilder: (BuildContext context) {
                            return choices.map((CustomPopupMenu choice) {
                              return PopupMenuItem<CustomPopupMenu>(
                                value: choice,
                                child: Text(choice.title ?? ''),
                              );
                            }).toList();
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 180,
                  left: 32,
                  right: 32,
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset('assets/images/boy.png',
                                width: 80, height: 80),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('8 Tasks',
                                        style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    const Text('Personal',
                                        style: TextStyle(
                                            height: 1,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 36)),
                                  ]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TodoListWidget(
                          editMode: editMode,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
