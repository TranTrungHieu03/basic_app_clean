import 'package:equatable/equatable.dart';

class PaginationEntity extends Equatable {
  final double page;
  final double totalPage;
  final double total;

  const PaginationEntity({
    required this.page,
    required this.totalPage,
    required this.total,
  });

  @override
  List<Object?> get props => [page];
}
