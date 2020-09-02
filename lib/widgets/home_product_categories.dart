import 'package:ecomapp/models/category.dart';
import 'package:ecomapp/widgets/home_product_category.dart';
import 'package:flutter/material.dart';

class HomeProductCategories extends StatefulWidget {
  final List<Category> categoryList;
  HomeProductCategories({this.categoryList});
  @override
  _HomeProductCategoriesState createState() => _HomeProductCategoriesState();
}

class _HomeProductCategoriesState extends State<HomeProductCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (context, index) {
          return HomeProductCategory(
            categoryName: widget.categoryList[index].name,
            categoryIcon: widget.categoryList[index].icon,
            categoryId: widget.categoryList[index].id,
          );
        },
      ),
    );
  }
}
