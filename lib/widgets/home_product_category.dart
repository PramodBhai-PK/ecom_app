import 'package:ecomapp/screens/products_by_category_screen.dart';
import 'package:flutter/material.dart';

class HomeProductCategory extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final String categoryIcon;
  HomeProductCategory({this.categoryName, this.categoryIcon,this.categoryId});
  @override
  _HomeProductCategoryState createState() => _HomeProductCategoryState();
}

class _HomeProductCategoryState extends State<HomeProductCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 140,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsByCategoryScreen(categoryName: widget.categoryName, categoryId: widget.categoryId)));
        },
              child: Card(
          child:Column(
            children: <Widget>[
              Image.network(widget.categoryIcon, width:190, height:160,fit: BoxFit.cover, ),
              Padding(padding: EdgeInsets.all(8.0),
              child: Text(widget.categoryName),),
            ],)
        ),
      ),
    );
  }
}