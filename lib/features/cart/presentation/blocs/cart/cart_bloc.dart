import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:store_demo/features/cart/domain/entities/cart_entity.dart';
import 'package:store_demo/features/cart/domain/usecases/add_to_cart.dart';
import 'package:store_demo/features/cart/domain/usecases/get_cart_by_user.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartByUserUseCase _getCartByUserUseCase;
  final AddToCartUseCase _addToCartUseCase;

  CartBloc({
    required AddToCartUseCase addToCartUseCase,
    required GetCartByUserUseCase getCartByUserUseCase,
  }) : _addToCartUseCase = addToCartUseCase,
       _getCartByUserUseCase = getCartByUserUseCase,
       super(CartInitial()) {
    on<GetCartByUserEvent>((event, emit) async {
      emit(CartLoading());
      final result = await _getCartByUserUseCase.call(event.params);
      result.fold(
        (failure) => emit(CartError(message: failure.message)),
        (cart) => emit(CartLoaded(cart: cart)),
      );
    });
    on<AddToCartEvent>((event, emit) async {
      emit(CartLoading());
      final result = await _addToCartUseCase.call(event.params);
      result.fold(
        (failure) => emit(CartError(message: failure.message)),
        (cart) => emit(CartLoaded(cart: cart)),
      );
    });
  }
}
