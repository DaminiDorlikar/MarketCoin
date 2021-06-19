import 'package:flutter/material.dart';

class Coin {
  Coin(
      {@required this.name,
      @required this.symbol,
      @required this.imagUurl,
      @required this.price,
      @required this.change,
      @required this.changePercentage});

  final name;
  final symbol;
  final imagUurl;
  final price;
  final change;
  final changePercentage;

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'],
      symbol: json['symbol'],
      imagUurl: json['image'],
      price: json['current_price'],
      change: json['price_change_24h'],
      changePercentage: json['price_change_percentage_24h'],
    );
  }
}

List<Coin> coinList = [];
