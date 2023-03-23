class CartModel {
  final String idCart;
  final String quantity;
  final String name;
  final String price;
  final String image;

  CartModel({
    required this.idCart,
    required this.quantity,
    required this.name,
    required this.price,
    required this.image,
  });
  factory CartModel.fromJson(json) {
    return CartModel(
      idCart: json['id_cart'],
      image: json['image'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
