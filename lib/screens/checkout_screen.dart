import 'dart:convert';
import 'package:ecomapp/models/product.dart';
import 'package:ecomapp/models/shipping.dart';
import 'package:ecomapp/screens/payment_screen.dart';
import 'package:ecomapp/services/shipping_service.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> cartItems;
  CheckoutScreen({this.cartItems});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final name = TextEditingController();

  final email = TextEditingController();

  final address = TextEditingController();

  void _addShipping(BuildContext context, Shipping shipping) async {
    var _shippingService = ShippingService();
    var shippingData = await _shippingService.addShipping(shipping);
    var result = json.decode(shippingData.body);
    print(result.body);
    if (result['result'] == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentScreen(
                    cartItems: this.widget.cartItems,
                  ),
                  ),
                  );
    } else {
      _showSnackMessage(Text('Failed to add shipping', style: TextStyle(color: Colors.red),));
      
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
        title: Text('Checkout'),
        leading: Text(''),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 28.0, right: 28.0, bottom: 14.0),
            child: Text('Shipping Address',
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: name,
              decoration: InputDecoration(hintText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: InputDecoration(hintText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, top: 14.0, right: 28.0, bottom: 14.0),
            child: TextField(
              controller: address,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Address',
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: ButtonTheme(
          minWidth: 320.0,
          height: 45.0,
          child: FlatButton(
            color: Colors.redAccent,
            onPressed: () {
              var shipping = Shipping();
              shipping.name = name.text;
              shipping.email = email.text;
              shipping.address = address.text;
              _addShipping(context, shipping);
            },
            child: Text('Continue to payment', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
