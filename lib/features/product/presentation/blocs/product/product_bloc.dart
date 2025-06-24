import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_demo/features/product/domain/entities/product_entity.dart';
import 'package:store_demo/features/product/domain/usecases/get_product_detail.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductDetail _getProductDetail;

  ProductBloc({required GetProductDetail getProductDetail})
    : _getProductDetail = getProductDetail,
      super(ProductInitial()) {
    on<GetProductDetailEvent>((event, emit) async {
      emit(ProductLoading());
      final result = await _getProductDetail.call(event.params);
      result.fold(
        (failure) => emit(ProductError(message: failure.message)),
        (product) => emit(ProductLoaded(product: product)),
      );
    });
  }
}
