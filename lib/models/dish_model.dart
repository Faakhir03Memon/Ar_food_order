class DishModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final String modelUrl; // GLB file URL
  final double rating;
  final int calories;

  DishModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.modelUrl,
    this.rating = 4.5,
    this.calories = 250,
  });

  factory DishModel.fromFirestore(Map<String, dynamic> data, String id) {
    return DishModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      category: data['category'] ?? 'General',
      imageUrl: data['image_url'] ?? '',
      modelUrl: data['model_url'] ?? '',
      rating: (data['rating'] ?? 4.5).toDouble(),
      calories: data['calories'] ?? 250,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'image_url': imageUrl,
      'model_url': modelUrl,
      'rating': rating,
      'calories': calories,
    };
  }
}
