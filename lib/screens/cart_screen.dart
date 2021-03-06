import 'package:ecomapp/models/product.dart';
import 'package:ecomapp/screens/checkout_screen.dart';
import 'package:ecomapp/screens/login_screen.dart';
import 'package:ecomapp/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cartItems;
  CartScreen(this.cartItems);
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _total;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    _getTotal();
  }

  _getTotal() {
    _total = 0.0;
    this.widget.cartItems.forEach((item) {
      setState(() {
        _total += (item.price - item.discount) * item.quantity;
      });
    });
  }

  void _checkOut(List<Product> cartItems) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int _userId = _prefs.getInt('userId');
    if (_userId != null && _userId > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutScreen(cartItems: cartItems),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(cartItems: cartItems),
        ),
      );
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
          leading: Text(""),
          title: Text("Items in Cart"),
          backgroundColor: Colors.blueAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]),
      body: ListView.builder(
        itemCount: this.widget.cartItems.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(this.widget.cartItems[index].id.toString()),
            onDismissed: (param) {
              _deleteCartItem(index, this.widget.cartItems[index].id);
            },
            background: Container(
              color: Colors.redAccent,
            ),
            child: Card(
              child: ListTile(
                leading: Image.network(this.widget.cartItems[index].photo),
                title: Text(this.widget.cartItems[index].name),
                subtitle: Row(children: <Widget>[
                  Text(
                    '\₹${this.widget.cartItems[index].price - this.widget.cartItems[index].discount}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'X',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    this.widget.cartItems[index].quantity.toString(),
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '=',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\₹${(this.widget.cartItems[index].price - this.widget.cartItems[index].discount) * this.widget.cartItems[index].quantity}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ]),
                trailing: Column(children: <Widget>[
                  InkWell(
                      onTap: () {
                        setState(() {
                          _total += this.widget.cartItems[index].price -
                              this.widget.cartItems[index].discount;
                          this.widget.cartItems[index].quantity++;
                        });
                      },
                      child: Icon(
                        Icons.arrow_drop_up,
                        size: 21,
                      )),
                  Text(
                    '${this.widget.cartItems[index].quantity}',
                    style: TextStyle(fontSize: 12),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          if (this.widget.cartItems[index].quantity > 1) {
                            _total -= this.widget.cartItems[index].price -
                                this.widget.cartItems[index].discount;
                            this.widget.cartItems[index].quantity--;
                          }
                        });
                      },
                      child: Icon(
                        Icons.arrow_drop_down,
                        size: 21,
                      ))
                ]),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Total: \₹$_total",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 21),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      _checkOut(this.widget.cartItems);
                    },
                    color: Colors.redAccent,
                    child: Text("CheckOut"),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void _deleteCartItem(int index, int id) async {
    setState(() {
      this.widget.cartItems.removeAt(index);
    });
    // delete item by id from local database
    var result = await _cartService.makeTheCartEmpty();
    if (result > 0) {
      _showSnackMessage(Text(
        'One item deleted from cart',
        style: TextStyle(color: Colors.red),
      ));
    } else {
      _showSnackMessage(Text(
        'Cart items can not be deleted!',
        style: TextStyle(color: Colors.yellow),
      ));
    }
  }
}
