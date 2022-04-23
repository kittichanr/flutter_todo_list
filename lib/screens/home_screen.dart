import 'package:flutter/material.dart';
import 'package:todo_list/widgets/category_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.yellowAccent.shade100,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(150),
                      bottomRight: Radius.circular(150),
                    )),
              )),
          Positioned(
            top: 50,
            left: 24,
            right: 24,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.menu_outlined, size: 32),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Hello Kittchan',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Today tou have 4 tasks',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ]),
                      Image.asset('assets/images/boy.png',
                          height: 100, width: 100),
                    ],
                  ),
                  SizedBox(height: 32),
                  CategoryListWidget()
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
