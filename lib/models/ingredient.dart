class Ingredient {
  final String item;
  final String quantity;

  Ingredient({required this.item, required this.quantity});

  // Factory constructor to create Ingredient from JSON
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    if (json['item'] == null || json['item'].toString().isEmpty) {
      throw ArgumentError('Invalid or missing "item" field in Ingredient');
    }
    if (json['quantity'] == null || json['quantity'].toString().isEmpty) {
      throw ArgumentError('Invalid or missing "quantity" field in Ingredient');
    }

    return Ingredient(
      item: json['item'],
      quantity: json['quantity'],
    );
  }

  // Convert Ingredient to JSON (useful for saving or sending data)
  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'quantity': quantity,
    };
  }
}
