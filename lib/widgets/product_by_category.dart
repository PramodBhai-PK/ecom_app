import 'package:ecomapp/models/product.dart';
import 'package:ecomapp/screens/product_detail.dart';
import 'package:flutter/material.dart';

class ProductByCategory extends StatefulWidget {
  final Product product;
  ProductByCategory(this.product);
  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 190,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail(this.widget.product),
            ),
          );
        },
        child: Card(
          child: Column(children: <Widget>[
            Text(
              this.widget.product.name,
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            Image.network(widget.product.photo,
                width: 190, height: 145, fit: BoxFit.contain),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                        "Price: ${this.widget.product.price - this.widget.product.discount}"),
                    Flexible(
                      child: Text(
                        "${this.widget.product.price}",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.redAccent,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
