part of 'list_category_bloc.dart';

@immutable
sealed class ListCategoryState {}

final class ListCategoryInitial extends ListCategoryState {}

final class ListCategoryLoading extends ListCategoryState {}

final class ListCategoryLoaded extends ListCategoryState {
  final List<CategoryEntity> categories;
  final int choose;

  ListCategoryLoaded({required this.categories, this.choose = 0});

  ListCategoryLoaded copyWith({
    List<CategoryEntity>? categories,
    int? choose,
  }) => ListCategoryLoaded(
    categories: categories ?? this.categories,
    choose: choose ?? this.choose,
  );
}

final class ListCategoryError extends ListCategoryState {
  final String message;

  ListCategoryError({required this.message});
}
