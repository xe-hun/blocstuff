// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:blocstuff/models/item_object.dart';

abstract class UiState extends Equatable {}

class UiInitial extends UiState {
  UiInitial({
    required this.items,
  });
  final List<ItemObject> items;

  @override
  List<Object?> get props => [items];

  UiInitial copyWith({
    List<ItemObject>? items,
  }) {
    return UiInitial(
      items: items ?? this.items,
    );
  }
}
