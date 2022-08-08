// To parse this JSON data, do
//
//     final currencyModel = currencyModelFromJson(jsonString);

import 'dart:convert';

CurrencyModel currencyModelFromJson(String str) => CurrencyModel.fromJson(json.decode(str));

String currencyModelToJson(CurrencyModel data) => json.encode(data.toJson());

class CurrencyModel {
  CurrencyModel({
    this.rates,
    this.pairs,
  });

  List<Rate>? rates;
  List<Pair>? pairs;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
    rates: List<Rate>.from(json["rates"].map((x) => Rate.fromJson(x))),
    pairs: List<Pair>.from(json["pairs"].map((x) => Pair.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "rates": List<dynamic>.from(rates!.map((x) => x.toJson())),
    "pairs": List<dynamic>.from(pairs!.map((x) => x.toJson())),
  };
}

class Pair {
  Pair({
    this.from,
    this.to,
  });

  String? from;
  String? to;

  factory Pair.fromJson(Map<String, dynamic> json) => Pair(
    from: json["from"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
  };
}

class Rate {
  Rate({
    this.from,
    this.to,
    this.rate,
  });

  String? from;
  String? to;
  String? rate;

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
    from: json["from"],
    to: json["to"],
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "rate": rate,
  };
}
