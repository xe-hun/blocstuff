import 'package:bloc/bloc.dart';
import 'package:blocstuff/bloc/ui_event.dart';
import 'package:blocstuff/bloc/ui_state.dart';
import 'package:blocstuff/models/item_object.dart';

class UiBloc extends Bloc<UiEvent, UiState> {
  UiBloc() : super(UiInitial(items: [ItemObject()])) {
    on<UiEvent>((event, emit) {
      if (event is AddItem) {
        final s = state as UiInitial;
        final newItem = List<ItemObject>.from(s.items)..add(ItemObject());
        // a new copy must always be created for the state to rebuild the ui.
        emit(s.copyWith(items: newItem));
      }

      if (event is RemoveItem) {
        final s = state as UiInitial;
        if (s.items.length == 1) {
          return;
        }
        final newItem = List<ItemObject>.from(s.items)..removeAt(event.index);
        emit(s.copyWith(items: newItem));
      }
    });
  }
}
