part of 'list_product_bloc.dart';

@immutable
sealed class ListProductState {}

final class ListProductInitial extends ListProductState {}

final class ListProductLoading extends ListProductState {}

final class ListProductLoaded extends ListProductState {
  final List<ProductEntity> products;
  final bool isLoadingMore;
  final PaginationModel pagination;
  final String type;

  ListProductLoaded({
    required this.products,
    this.isLoadingMore = false,
    required this.pagination,
    this.type = 'all',
  });

  ListProductLoaded copyWith({
    List<ProductEntity>? products,
    PaginationModel? pagination,
    bool? isLoadingMore,
    String? type,
  }) {
    return ListProductLoaded(
      products: products ?? this.products,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      type: type ?? this.type,
    );
  }
}

final class ListProductByCategoryLoaded extends ListProductState {
  final List<ProductEntity> products;
  final bool isLoadingMore;
  final PaginationModel pagination;

  ListProductByCategoryLoaded({
    required this.products,
    this.isLoadingMore = false,
    required this.pagination,
  });

  ListProductByCategoryLoaded copyWith({
    List<ProductEntity>? products,
    PaginationModel? pagination,
    bool? isLoadingMore,
  }) {
    return ListProductByCategoryLoaded(
      products: products ?? this.products,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final class ListProductError extends ListProductState {
  final String message;

  ListProductError({required this.message});
}
