// To parse this JSON data, do
//
//     final newProduct = newProductFromJson(jsonString);

import 'dart:convert';

NewProduct newProductFromJson(String str) =>
    NewProduct.fromJson(json.decode(str));

String newProductToJson(NewProduct data) => json.encode(data.toJson());

class NewProduct {
  List<String>? images;
  Ratings? ratings;
  String? price;
  String? name;
  String? description;
  String? id;
  String? category;
  String? stock;
  bool split;

  NewProduct(
      {this.images,
      this.ratings,
      this.price,
      this.name,
      this.description,
      this.id,
      this.category,
      this.stock,
      this.split = false});

  factory NewProduct.fromJson(Map<String, dynamic> json) => NewProduct(
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        ratings:
            json["ratings"] == null ? null : Ratings.fromJson(json["ratings"]),
        price: json["price"],
        name: json["name"],
        description: json["description"],
        id: json["id"],
        category: json["category"],
        stock: json["stock"],
        split: json["split"]??false,
      );

  Map<String, dynamic> toJson() => {
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "ratings": ratings?.toJson(),
        "price": price,
        "name": name,
        "description": description,
        "id": id,
        "category": category,
        "stock": stock,
        "split": split
      };
}

class Ratings {
  String? average;
  List<Review>? reviews;

  Ratings({
    this.average,
    this.reviews,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        average: json["average"],
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "average": average,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
      };
}

class Review {
  String? fullname;
  String? rating;
  String? comment;
  String? userId;
  String? timestamp;

  Review(
      {this.rating, this.comment, this.userId, this.timestamp, this.fullname});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: json["rating"],
        comment: json["comment"],
        userId: json["userId"],
        timestamp: json["timestamp"],
        fullname: json["fullname"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
        "userId": userId,
        "timestamp": timestamp,
        "fullname": fullname
      };
}
