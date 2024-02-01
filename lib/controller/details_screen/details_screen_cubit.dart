import 'package:flutter_bloc/flutter_bloc.dart';

import '/controller/details_screen/details_screen_states.dart';

class DetailsScreenCubit extends Cubit<DetailsScreenStates> {
  DetailsScreenCubit() : super(InitialDetailsScreenStates());

  static DetailsScreenCubit get(context) => BlocProvider.of(context);

  var itemsNumber = 0;

  void increment() {
    itemsNumber++;
    emit(IncrementItemsInCardState());
  }

  void decrement() {
    if (itemsNumber == 0) return;
    itemsNumber--;
    emit(DecrementItemsInCardState());
  }

  var sliderIndex = 0;
  void changeSliderIndex(int toIndex) {
    sliderIndex = toIndex;
    emit(ChangeSliderIndexState());
  }
}
