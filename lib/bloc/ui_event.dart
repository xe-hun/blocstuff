// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class UiEvent {}

class AddItem extends UiEvent {
  AddItem();
}

class RemoveItem extends UiEvent {
  RemoveItem({required this.index});
  final int index;
}
