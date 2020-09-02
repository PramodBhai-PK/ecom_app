import 'package:ecomapp/models/product.dart';
import 'package:ecomapp/screens/product_detail.dart';
import 'package:flutter/material.dart';

class HomeNewArrivalProduct extends StatefulWidget {
  final Product product;
  HomeNewArrivalProduct(this.product);
  @override
  _HomeNewArrivalProductState createState() => _HomeNewArrivalProductState();
}

class _HomeNewArrivalProductState extends State<HomeNewArrivalProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190.0,
      height: 260.0,
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
          child: Column(
            children: <Widget>[
              Text(this.widget.product.name),
              Image.network(
                widget.product.photo,
                width: 190.0,
                height: 160.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 5.0, left: 15, right: 5),
                      child: Text(
                        '₹:${this.widget.product.price - this.widget.product.discount}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 5.0, left: 5, right: 10),
                      child: Text(
                        '₹:${this.widget.product.price}',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
