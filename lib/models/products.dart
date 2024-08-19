

class Products {
  final int? id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  Products({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
        id: json['id'],
        title: json['title'],
        price: json['price'].toDouble(),
        description: json['description'],
        category: json['category'],
        image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category
    };
  }
}



