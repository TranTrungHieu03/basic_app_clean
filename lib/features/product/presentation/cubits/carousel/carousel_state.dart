part of 'carousel_cubit.dart';

@immutable
class CarouselState extends Equatable {
  final int index;
  final int maxChoose;

  const CarouselState({required this.maxChoose, this.index = 0});

  factory CarouselState.init({required int maxChoose}) =>
      CarouselState(maxChoose: maxChoose, index: 0);

  CarouselState copyWith({int? index, int? maxChoose}) {
    return CarouselState(
      maxChoose: maxChoose ?? this.maxChoose,
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [index, maxChoose];
}

//
// final class CarouselInitial extends CarouselState {
//   final int index;
//   final int maxChoose;
//
//   CarouselInitial({required this.maxChoose, this.index = 0});
// }
//
// final class CarouselChanged extends CarouselState {
//   final int index;
//   final int maxChoose;
//
//   CarouselChanged({required this.maxChoose, required this.index});
// }
