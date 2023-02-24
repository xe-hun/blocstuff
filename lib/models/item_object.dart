import 'package:flutter/material.dart';

class ItemObject {
  String? item;
  final TextEditingController quantityTEC = TextEditingController();
  final TextEditingController rateTEC = TextEditingController();

  double get total {
    return (double.tryParse(quantityTEC.text) ?? 0) *
        (double.tryParse(rateTEC.text) ?? 0);
  }
}
