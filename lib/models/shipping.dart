class Shipping {
  int id;
  String name;
  String email;
  String address;

  toJson(){
    return {
      'id' : id.toString(),
      'name' : name.toString(),
      'email' : email,
      'address' : address
    };
  }
}