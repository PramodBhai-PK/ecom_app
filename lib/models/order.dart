import 'package:ecomapp/models/product.dart';

class Order{
  int id;
  int quantity;
  double amount;
  int productId;
  String paymentType;
  String orderDate;
  Product product = Product();
}