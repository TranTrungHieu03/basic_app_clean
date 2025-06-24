part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class GetProductDetailEvent extends ProductEvent {
  GetProductDetailParams params;

  GetProductDetailEvent(this.params);
}
