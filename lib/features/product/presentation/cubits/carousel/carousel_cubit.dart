import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'carousel_state.dart';

class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit(int maxChoose)
    : super(CarouselState.init(maxChoose: maxChoose));

  void increment() {
    emit(state.copyWith(maxChoose: state.maxChoose, index: state.index + 1));
  }

  void decrement() {
    emit(state.copyWith(maxChoose: state.maxChoose, index: state.index - 1));
  }
}
