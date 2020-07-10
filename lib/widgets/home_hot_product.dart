import 'package:ecomapp/models/product.dart';
import 'package:ecomapp/screens/product_detail.dart';
import 'package:flutter/material.dart';

class HomeHotProduct extends StatefulWidget {
  final Product product;
  HomeHotProduct(this.product);
  @override
  _HomeHotProductState createState() => _HomeHotProductState();
}

class _HomeHotProductState extends State<HomeHotProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190.0,
      height: 260.0,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>ProductDetail(
            this.widget.product),
            ),
            );
        },
              child: Card(
          child: Column(
            children: <Widget>[
             Text(this.widget.product.name),
              Image.network(widget.product.photo, width: 190.0, height: 160.0,),
              Expanded(
                   child: Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:2.0,left: 5),
                    child: Text('Price: ${this.widget.product.price - this.widget.product.discount}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  ),
                  Flexible(
                    child: Padding(
                    padding: const EdgeInsets.only(bottom:2.0,left: 5,right: 1),
                    child: Text('${this.widget.product.price}',style: TextStyle(decoration:TextDecoration.lineThrough,color: Colors.redAccent,fontWeight: FontWeight.bold,fontSize: 16),),
                  )),
                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}