class CartItemModel {
  String id;
  String title;
  int quantity;
  double price;
  String image;

  CartItemModel({
    this.id,
    this.title,
    this.quantity,
    this.price,
    this.image,
  });

  CartItemModel.fromMap(Map<String, dynamic> data){
    id = data['id'];
    title = data['title'];
    quantity = data['quantity'];
    price = data['price'];
    image = data['image'];
  }

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    quantity = json['quantity'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['title'] = this.title;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['image'] = this.image;

    return data;
  }
}
