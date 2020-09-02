import 'dart:convert';
import 'package:ecomapp/models/order.dart';
import 'package:ecomapp/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  List<Order> _orderList = List<Order>();

  _getOrderListByUserId() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int _userId = _prefs.getInt('userId');
    OrderService _orderService = OrderService();
    var result = await _orderService.getOrdersByUserId(_userId);
    var orders = json.decode(result.body);
    orders.forEach((order) {
      var model = Order();
      model.id = order['id'];
      model.quantity = order['quantity'];
      model.amount = order['amount'].toDouble();
      model.product.name = order['product']['name'];
      model.product.photo = order['product']['photo'];
      model.orderDate = order['order_date'];

      setState(() {
        _orderList.add(model);
      });
    });
    print(result.body);
  }

  @override
  void initState() {
    super.initState();
    _getOrderListByUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
          itemCount: _orderList.length,
          itemBuilder: (context, index) {
            if(_orderList.length != 0  ){
              return Card(
              child: ListTile(
                leading: Image.network(
                  _orderList[index].product.photo,
                  height: 80,
                  width: 80,
                ),
                title: Text(
                  _orderList[index].product.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Quantity: ${_orderList[index].quantity.toString()}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '=>',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "\₹=",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              _orderList[index].amount.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "Ordered on: ${_orderList[index].orderDate}",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )
                  ],
                ),
              ),
            );
            } return Center(child: CircularProgressIndicator());
            
          }),
    );
  }
}
