import 'dart:async';
import 'dart:convert';

import 'package:ecomapp/models/order.dart';
import 'package:ecomapp/models/payment.dart';
import 'package:ecomapp/models/product.dart';
import 'package:ecomapp/screens/home_screen.dart';
import 'package:ecomapp/screens/payment_screen.dart';
import 'package:ecomapp/services/cart_service.dart';
import 'package:ecomapp/services/payment_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoosePaymentOption extends StatefulWidget {
  final List<Product> cartItems;
  ChoosePaymentOption({this.cartItems});
  @override
  _ChoosePaymentOptionState createState() => _ChoosePaymentOptionState();
}

class _ChoosePaymentOptionState extends State<ChoosePaymentOption> {
  var _selectPaymentOption = 'Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Choose Payment Options'),
        backgroundColor: Colors.redAccent,
        leading: Text(''),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 28.0, bottom: 14, right: 28, left: 28),
            child: Text(
              'Choose Payment Option',
              style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'cursive',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Divider(
            height: 5,
            color: Colors.black,
          ),
          Card(
            child: RadioListTile(
                title: Text('Credit / Debit Card'),
                value: 'Card',
                groupValue: _selectPaymentOption,
                onChanged: (param) {
                  setState(() {
                    _selectPaymentOption = param;
                  });
                }),
          ),
          Card(
            child: RadioListTile(
                title: Text('Cash on Delivery'),
                value: 'Cash on Delivery',
                groupValue: _selectPaymentOption,
                onChanged: (param) {
                  setState(() {
                    _selectPaymentOption = param;
                  });
                }),
          ),
          ButtonTheme(
            minWidth: 320.0,
            height: 45.0,
            child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                color: Colors.redAccent,
                onPressed: () async {
                  if (_selectPaymentOption == 'Card') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                                  paymentType: _selectPaymentOption,
                                  cartItems: this.widget.cartItems,
                                )));
                  } else {
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    var payment = Payment();
                    payment.userId = _prefs.getInt('userId');
                    payment.cartItems = this.widget.cartItems;
                    payment.order = Order();
                    payment.order.paymentType = _selectPaymentOption;
                    _makePayment(context, payment);
                  }
                },
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  void _makePayment(BuildContext context, Payment payment) async {
    PaymentService _paymentService = PaymentService();
    var paymentData = await _paymentService.makePayment(payment);
    var result = json.decode(paymentData.body);
    print(paymentData);
    CartService _cartService = CartService();
    this.widget.cartItems.forEach((cartItem) {
      _cartService.makeTheCartEmpty();
    });
    if (result['result'] == true) {
      _showPaymentSuccessMessage(context);
      Timer(Duration(seconds: 4), () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
  }

  _showPaymentSuccessMessage(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            content: Container(
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/a2.jpg'),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Order Successfully received !',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
