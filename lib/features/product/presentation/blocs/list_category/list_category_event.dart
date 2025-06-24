part of 'list_category_bloc.dart';

@immutable
sealed class ListCategoryEvent {}

final class GetListCategoryEvent extends ListCategoryEvent {}

final class ChangeIndexCategoryEvent extends ListCategoryEvent {
  final int indexChoose;

  ChangeIndexCategoryEvent(this.indexChoose);
}
