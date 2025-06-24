import 'package:store_demo/features/product/domain/entities/pagination.dart';

class PaginationModel extends PaginationEntity {
  const PaginationModel({
    required super.page,
    required super.totalPage,
    required super.total,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json['page']  ,
      totalPage: json['totalPage']  ,
      total: json['total '] ,
    );
  }

  factory PaginationModel.isEmpty() {
    return const PaginationModel(page: 0, totalPage: 0, total: 0);
  }

  PaginationEntity toEntity() =>
      PaginationEntity(page: page, totalPage: totalPage, total: total);
}
