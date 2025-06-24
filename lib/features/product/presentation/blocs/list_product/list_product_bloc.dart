import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/core/services/logger.dart';
import 'package:store_demo/features/product/data/models/pagination_model.dart';
import 'package:store_demo/features/product/domain/entities/product_entity.dart';
import 'package:store_demo/features/product/domain/usecases/get_list_product.dart';
import 'package:store_demo/features/product/domain/usecases/search_product_by_category.dart';

part 'list_product_event.dart';

part 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  final GetListProductUseCase _getListProductUseCase;
  final SearchProductByCategory _searchProductByCategory;

  ListProductBloc({
    required GetListProductUseCase getListProductUseCase,
    required SearchProductByCategory searchProductByCategory,
  }) : _getListProductUseCase = getListProductUseCase,
       _searchProductByCategory = searchProductByCategory,
       super(ListProductInitial()) {
    on<GetListProductEvent>((event, emit) async {
      final currentState = state;
      AppLogger.info(currentState);
      if (currentState is ListProductLoaded) {
        AppLogger.info(currentState.type);
      }
      if (currentState is ListProductInitial ||
          (currentState is ListProductLoaded && event.params.isFirstRender)) {
        emit(ListProductLoading());
        final result = await _getListProductUseCase.call(event.params);
        result.fold(
          (failure) => emit(ListProductError(message: failure.message)),
          (data) => emit(
            ListProductLoaded(
              products: data.products,
              isLoadingMore: false,
              pagination: data.pagination,
            ),
          ),
        );
      } else if (currentState is ListProductLoaded &&
          !event.params.isFirstRender) {
        emit(currentState.copyWith(isLoadingMore: true));
        final result = await _getListProductUseCase.call(event.params);
        result.fold(
          (failure) => emit(ListProductError(message: failure.message)),
          (result) => emit(
            ListProductLoaded(
              products: currentState.products + result.products,
              pagination: result.pagination,
              isLoadingMore: false,
            ),
          ),
        );
      }
    });
    on<SearchProductByCategoryEvent>((event, emit) async {
      final currentState = state;

      if (currentState is ListProductLoaded &&
          event.params.type != currentState.type) {
        emit(ListProductLoading());
        final result = await searchProductByCategory.call(event.params);
        result.fold(
          (failure) => emit(ListProductError(message: failure.message)),
          (data) => emit(
            ListProductLoaded(
              products: data.products,
              isLoadingMore: false,
              pagination: data.pagination,
              type: event.params.type,
            ),
          ),
        );
      } else if (currentState is ListProductLoaded &&
          event.params.type == currentState.type) {
        emit(currentState.copyWith(isLoadingMore: true));
        final result = await searchProductByCategory.call(event.params);
        result.fold(
          (failure) => emit(ListProductError(message: failure.message)),
          (result) => emit(
            ListProductLoaded(
              products: currentState.products + result.products,
              pagination: result.pagination,
              isLoadingMore: false,
              type: event.params.type,
            ),
          ),
        );
      }
    });
  }
}
