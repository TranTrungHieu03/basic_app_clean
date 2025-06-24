import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_demo/core/common/usecase/usecase.dart';
import 'package:store_demo/core/utils/constants/env.dart';
import 'package:store_demo/features/product/domain/entities/category_entity.dart';
import 'package:store_demo/features/product/domain/usecases/get_list_category.dart';

part 'list_category_event.dart';

part 'list_category_state.dart';

class ListCategoryBloc extends Bloc<ListCategoryEvent, ListCategoryState> {
  final GetListCategoryUseCase _getListCategoryUseCase;

  ListCategoryBloc({required GetListCategoryUseCase getListCategoryUseCase})
    : _getListCategoryUseCase = getListCategoryUseCase,
      super(ListCategoryInitial()) {
    on<GetListCategoryEvent>((event, emit) async {
      emit(ListCategoryLoading());
      final result = await _getListCategoryUseCase.call(NoParams());
      result.fold(
        (failure) => emit(ListCategoryError(message: failure.message)),
        (categories) => emit(
          ListCategoryLoaded(
            categories: [
              CategoryEntity(slug: AppEnv.allKey, name: 'All', url: ''),
              ...categories,
            ],
          ),
        ),
      );
    });
    on<ChangeIndexCategoryEvent>((event, emit) async {
      final currentState = state;
      if (currentState is ListCategoryLoaded) {
        emit(
          ListCategoryLoaded(
            categories: currentState.categories,
            choose: event.indexChoose,
          ),
        );
      }
    });
  }
}
