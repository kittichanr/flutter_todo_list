import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/models/category.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({Key? key}) : super(key: key);

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  List<Category> categoryList = [];

  Future<void> fetchCategoryList() async {
    final String response =
        await rootBundle.loadString('assets/mocks/categoryList.json');
    List<dynamic> data = await json.decode(response);
    setState(() {
      categoryList = data.map((e) => Category.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    fetchCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      width: double.maxFinite,
      child: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (_, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 24, top: 8, bottom: 8),
                child: Row(
                  children: [
                    Image.asset(categoryList[index].image.toString(),
                        width: 50, height: 50),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              categoryList[index].title ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Text(
                              '${categoryList[index].taskAmount ?? 0} Tasks',
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ]),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.more_vert,
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
