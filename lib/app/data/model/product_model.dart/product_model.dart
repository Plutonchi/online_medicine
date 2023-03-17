class CategoryWithProduct {
  final String idCategory;
  final String image;
  final String category;
  final String status;

  CategoryWithProduct({
    required this.idCategory,
    required this.image,
    required this.category,
    required this.status,
  });
  factory CategoryWithProduct.fromJson(Map<dynamic, dynamic> data) {
    return CategoryWithProduct(
      idCategory: data['idCategory'],
      image: data['image'],
      category: data['category'],
      status: data['status'],
    );
  }
}

class ProductModel {
  final String idProduct;
  final String idCategory;
  final String nameProduct;
  final String description;
  final String imageProduct;
  final String price;
  final String status;
  final String createdAt;

  ProductModel({
    required this.idProduct,
    required this.idCategory,
    required this.nameProduct,
    required this.description,
    required this.imageProduct,
    required this.price,
    required this.status,
    required this.createdAt,
  });
  factory ProductModel.fromJson(Map<dynamic, dynamic> data) {
    return ProductModel(
      idProduct: data['idProduct'],
      idCategory: data['idCategory'],
      nameProduct: data['nameProduct'],
      description: data['description'],
      imageProduct: data['imageProduct'],
      price: data['price'],
      status: data['status'],
      createdAt: data['createdAt'],
    );
  }
}
