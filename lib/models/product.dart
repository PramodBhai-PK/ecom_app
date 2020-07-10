class Product{
  int id;
  String name;
  String photo;
  double price;
  double discount;
  String detail;
  int quantity;

   toMap(){
    var map = Map<String, dynamic>();
    map['productId'] = id;
    map['productName'] = name;
    map['productPhoto'] = photo;
    map['productPrice'] = price;
    map['productDiscount'] = discount;
    map['productQuantity'] = quantity;
    return map;
  }

  fromMap(){
    
  }
}