import 'dart:convert';
import 'package:ecomapp/models/category.dart';
import 'package:ecomapp/models/product.dart';
import 'package:ecomapp/screens/cart_screen.dart';
import 'package:ecomapp/services/cart_service.dart';
import 'package:ecomapp/services/category_service.dart';
import 'package:ecomapp/services/product_service.dart';
import 'package:ecomapp/services/slider_service.dart';
import 'package:ecomapp/widgets/carousel_slider.dart';
import 'package:ecomapp/widgets/home_hot_products.dart';
import 'package:ecomapp/widgets/home_new_arrival_products.dart';
import 'package:ecomapp/widgets/home_product_categories.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  SliderService _sliderService = SliderService();
  CategoryService _categoryService = CategoryService();
  ProductService _productService = ProductService();

  var items = [];
  List<Category> _categoryList = List<Category>();
  List<Product> _productList = List<Product>();
  List<Product> _newArrivalproductList = List<Product>();
  CartService _cartService = CartService();
  List<Product> _cartItems;

  @override
  void initState() {
    super.initState();
    _getAllSliders();
    _getAllCategories();
    _getAllHotProducts();
    _getAllNewArrivalProducts();
    _getCartItems();
  }

  _getAllSliders() async {
    var sliders = await _sliderService.getSliders();
    print(sliders.body);
    var result = json.decode(sliders.body);

    result['data'].forEach((data){
      setState(() {
      items.add(
        NetworkImage(data['sliderImage']),
        );
//       items.add(
//         FadeInImage.assetNetwork(
//         placeholder: 'images/loader.gif',
//         image: data['sliderImage'],
// ),);
    });
    });
    //print(result);
    
  }
  _getCartItems() async {
    _cartItems = List<Product>();
    var cartItems = await _cartService.getCartItems();
    cartItems.forEach((data){
      var product = Product();
      product.id = data['productId'];
      product.name = data['productName'];
      product.photo= data['productPhoto'];
      product.price = data['productPrice'].toDouble();
      product.discount = data['productDiscount'].toDouble();
      product.detail = data['productDetail'] ?? "No Details are available for this product.";
      product.quantity = data['productQuantity'];

      setState(() {
        _cartItems.add(product);
      });
    });
  }
  _getAllCategories() async {
    var categories = await _categoryService.getCategories();
    var result = json.decode(categories.body);
    print(categories.body);
    result['data'].forEach((data){
      var model = Category();
      model.id = data["id"];
      model.name = data["categoryName"];
      model.icon = data["categoryIcon"];
      setState(() {
      _categoryList.add(model);
    });
    });
    //print(result);
    
  }

  _getAllHotProducts() async {
    var hotProducts = await _productService.getHotProducts();
    print(hotProducts.body);
    var result = json.decode(hotProducts.body);
    result['data'].forEach((data){
      var model = Product();
      model.id = data["id"];
      model.name = data["productName"];
      model.photo = data["productImage"];
      model.price = data["productPrice"].toDouble(); 
      model.discount = data["productDiscount"].toDouble();
      model.detail = data["productDetail"];

      setState(() {
        _productList.add(model);
      });
    });
  }
  _getAllNewArrivalProducts() async {
    var newArrivalProducts = await _productService.getNewArrivalProducts();
    print(newArrivalProducts.body);
    var result = json.decode(newArrivalProducts.body);
    result['data'].forEach((data){
      var model = Product();
      model.id = data["id"];
      model.name = data["productName"];
      model.photo = data["productImage"];
      model.price = data["productPrice"].toDouble(); 
      model.discount = data["productDiscount"].toDouble();
      model.detail = data["productDetail"];

      setState(() {
        _newArrivalproductList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Ecom-App"),
        elevation: 0.0,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen(_cartItems)));
            },
                      child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height:150,
                width:30,
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.shopping_cart), 
                      onPressed: (){}),
                    Positioned(
                      
                      child: Stack(
                        children: <Widget>[
                          Icon(Icons.brightness_1,size:25,color:Colors.black),
                          Positioned(
                            top: 4,
                            right: 8,
                            child: Text(_cartItems.length.toString()),
                            )
                    ],
                    ),
                    )
                ],)
                ),
            ),
          )
        ]
      ),
      body: Container(
        child:ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
                              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: carouselSlider(items)),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.all(10.0),
            //   child: Text("Product Categories", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            //   ),
              HomeProductCategories(categoryList: _categoryList,),
              Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Hot Products", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              HomeHotProducts(productList: _productList,),
              Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("New Arrival Products", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              HomeNewArrivalProducts(productList: _newArrivalproductList,),
          ],
        ),
      ),
    );
  }
}