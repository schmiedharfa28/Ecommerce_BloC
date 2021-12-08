// To parse this JSON data, do
//
//     final resGetMeal = resGetMealFromJson(jsonString);

import 'dart:convert';

ResGetMeal resGetMealFromJson(String str) =>
    ResGetMeal.fromJson(json.decode(str));

String resGetMealToJson(ResGetMeal data) => json.encode(data.toJson());

class ResGetMeal {
  ResGetMeal({
    this.meals,
  });

  List<Meal>? meals;

  factory ResGetMeal.fromJson(Map<String, dynamic> json) => ResGetMeal(
        meals: json["meals"] == null
            ? null
            : List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": meals == null
            ? null
            : List<dynamic>.from(meals!.map((x) => x.toJson())),
      };
}

class Meal {
  Meal({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"] == null ? null : json["strMeal"],
        strMealThumb:
            json["strMealThumb"] == null ? null : json["strMealThumb"],
        idMeal: json["idMeal"] == null ? null : json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal == null ? null : strMeal,
        "strMealThumb": strMealThumb == null ? null : strMealThumb,
        "idMeal": idMeal == null ? null : idMeal,
      };
}
