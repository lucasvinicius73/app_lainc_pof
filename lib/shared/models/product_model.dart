import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final String code;
  final String name;
  final String category;
  final String? author;
  //SearchValueModel? value;
  String? description;

  Product({
    required this.code,
    required this.name,
    required this.category,
    this.author,
    this.description,
  });

  factory Product.fromJson(Map json) {
    return Product(
        code: json["code"],
        name: json["name"],
        category: json["category"],
        author: json["author"],
        description: json["description"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'category': category,
      'author': author,
      'description': description
    };
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [code,name];
}
