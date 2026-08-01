class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String category;
  final String thumbnail;
  final List<String> images;
  final double? discountPercentage;
  final int? stock;
  final String? brand;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.thumbnail,
    required this.images,
    this.discountPercentage,
    this.stock,
    this.brand,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      category: json['category'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : <String>[],
      discountPercentage: json['discountPercentage'] != null
          ? (json['discountPercentage']).toDouble()
          : null,
      stock: json['stock'],
      brand: json['brand'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'rating': rating,
      'category': category,
      'thumbnail': thumbnail,
      'images': images,
      'discountPercentage': discountPercentage,
      'stock': stock,
      'brand': brand,
    };
  }
}