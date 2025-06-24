import 'package:store_demo/features/product/data/models/pagination_model.dart';

class ApiResponse<T> {
  ApiResponse._({this.data, this.message});

  T? data;
  String? message;

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse._(data: json as T?, message: json['message']);
  }
}
