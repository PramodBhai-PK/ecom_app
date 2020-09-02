// import 'package:ecomapp/models/product.dart';
// import 'package:flutter/material.dart';

// import 'home_hot_product.dart';

// class HomeHotProducts extends StatefulWidget {
//   final List<Product> productList;
//   HomeHotProducts({this.productList});
//   @override
//   _HomeHotProductsState createState() => _HomeHotProductsState();
// }

// class _HomeHotProductsState extends State<HomeHotProducts> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//       height: 205,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: this.widget.productList.length,
//         itemBuilder: (context, index){
//           return HomeHotProduct(productName: widget.productList[index].name, productPhoto: widget.productList[index].photo, productPrice: widget.productList[index].price, productDiscount:widget.productList[index].discount, );
//         },
//       ),
//     );
//   }
// }

import 'package:ecomapp/models/product.dart';
import 'package:flutter/material.dart';

import 'home_hot_product.dart';

class HomeHotProducts extends StatefulWidget {
  final List<Product> productList;
  HomeHotProducts({this.productList});
  @override
  _HomeHotProductsState createState() => _HomeHotProductsState();
}

class _HomeHotProductsState extends State<HomeHotProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: this.widget.productList.length,
        itemBuilder: (context, index) {
          return HomeHotProduct(this.widget.productList[index]);
        },
      ),
    );
  }
}
