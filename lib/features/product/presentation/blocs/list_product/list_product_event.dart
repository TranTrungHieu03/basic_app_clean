part of 'list_product_bloc.dart';

@immutable
sealed class ListProductEvent {}

final class GetListProductEvent extends ListProductEvent {
  final GetListProductDto params;

  GetListProductEvent(this.params);
}

final class SearchProductByCategoryEvent extends ListProductEvent {
  final SearchProductByCategoryDto params;

  SearchProductByCategoryEvent(this.params);
}
