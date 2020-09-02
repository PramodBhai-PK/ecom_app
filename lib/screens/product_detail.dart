import 'package:ecomapp/models/product.dart';
import 'package:ecomapp/screens/cart_screen.dart';
import 'package:ecomapp/services/cart_service.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  ProductDetail(this.product);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CartService _cartService = CartService();
  List<Product> _cartItems;

  @override
  void initState() {
    super.initState();
    _getCartItems();
  }

  _getCartItems() async {
    _cartItems = List<Product>();
    var cartItems = await _cartService.getCartItems();
    cartItems.forEach((data) {
      var product = Product();
      product.id = data['productId'];
      product.name = data['productName'];
      product.photo = data['productPhoto'];
      product.price = data['productPrice'].toDouble();
      product.discount = data['productDiscount'].toDouble();
      product.detail =
          data['productDetail'] ?? "No Details are available for this product.";
      product.quantity = data['productQuantity'];

      setState(() {
        _cartItems.add(product);
      });
    });
  }

  _addToCart(BuildContext context, Product product) async {
    var result = await _cartService.addToCart(product);
    if (result > 0) {
      _getCartItems();
      print(result);
      setState(() {
        _cartItems.length.toString();
      });
      _showSnackMessage(Text(
        'Item added to cart successfully!',
        style: TextStyle(color: Colors.green),
      ));
    } else {
      _showSnackMessage(Text(
        'Failed to add to cart!',
        style: TextStyle(color: Colors.red),
      ));
    }
  }

  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(this.widget.product.name),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen(_cartItems)));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: 150,
                  width: 30,
                  child: Stack(
                    children: <Widget>[
                      IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.shopping_cart),
                          onPressed: () {}),
                      Positioned(
                        child: Stack(
                          children: <Widget>[
                            Icon(Icons.brightness_1,
                                size: 25, color: Colors.black),
                            Positioned(
                              top: 4,
                              right: 8,
                              child: Text(
                                _cartItems.length.toString(),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
      body: ListView(children: <Widget>[
        Container(
          height: 300,
          child: GridTile(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 38),
                child: Image.network(this.widget.product.photo),
              ),
            ),
            footer: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                  child: ListTile(
                leading: Text(this.widget.product.name,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                title: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        "${this.widget.product.price - this.widget.product.discount}",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                      Expanded(
                          child: Text("${this.widget.product.price}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough))),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 8),
                        child: Text("save:(${this.widget.product.discount})",
                            style: TextStyle(
                              color: Colors.green,
                              fontStyle: FontStyle.italic,
                            )),
                      ),
                    ],
                  ),
                ),
              )),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
              onPressed: () {},
              textColor: Colors.redAccent,
              child: Row(
                children: <Widget>[
                  Text('Add to Cart'),
                  IconButton(
                      icon: Icon(Icons.shopping_cart),
                      onPressed: () {
                        _addToCart(context, this.widget.product);
                      }),
                ],
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.redAccent,
                  size:25,
                ),
                onPressed: () {}),
          ],
        ),
        Divider(),
        ListTile(
            title: Text(
              "Product Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              this.widget.product.detail,
              style: TextStyle(fontSize: 18),
            ))
      ]),
    );
  }
}
