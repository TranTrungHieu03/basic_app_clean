part of 'init_dependencies.dart';

final sl = GetIt.instance;

void initDependencies() {
  sl.registerFactory<TLocalStorage>(() => TLocalStorage());
  sl.registerFactory<DioApiServices>(
    () => DioApiServices(
      baseUrl: AppEnv.baseUrl,
      localStorage: sl<TLocalStorage>(),
    ),
  );

  setUpAuth();
  setUpProduct();
  setUpCart();
}

void setUpAuth() {
  sl
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl<DioApiServices>()),
    )
    ..registerFactory<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl<TLocalStorage>()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        sl<AuthRemoteDataSource>(),
        sl<AuthLocalDataSource>(),
      ),
    )
    ..registerFactory<LoginUseCase>(() => LoginUseCase(sl<AuthRepository>()))
    ..registerFactory<GetUserLocalUseCase>(
      () => GetUserLocalUseCase(sl<AuthRepository>()),
    )
    ..registerFactory<GetTokenLocalUseCase>(
      () => GetTokenLocalUseCase(sl<AuthRepository>()),
    )
    ..registerFactory<GetUserInformationUseCase>(
      () => GetUserInformationUseCase(sl<AuthRepository>()),
    )
    ..registerFactory<RefreshTokenUseCase>(
      () => RefreshTokenUseCase(sl<AuthRepository>()),
    )
    ..registerFactory<PasswordCubit>(() => PasswordCubit())
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUseCase: sl(),
        getTokenLocalUseCase: sl(),
        getUserLocalUseCase: sl(),
        refreshTokenUseCase: sl(),
        getUserInformationUseCase: sl(),
      ),
    );
}

void setUpProduct() {
  sl
    ..registerFactory<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl<DioApiServices>()),
    )
    ..registerFactory<ProductRepository>(
      () => ProductRepositoryImpl(sl<ProductRemoteDataSource>()),
    )
    ..registerFactory<GetListProductUseCase>(
      () => GetListProductUseCase(sl<ProductRepository>()),
    )
    ..registerFactory<SearchProductByCategory>(
      () => SearchProductByCategory(sl<ProductRepository>()),
    )
    ..registerFactory<ListProductBloc>(
      () => ListProductBloc(
        getListProductUseCase: sl(),
        searchProductByCategory: sl(),
      ),
    )
    ..registerFactory<GetListCategoryUseCase>(
      () => GetListCategoryUseCase(sl<ProductRepository>()),
    )
    ..registerFactory<ListCategoryBloc>(
      () => ListCategoryBloc(getListCategoryUseCase: sl()),
    )
    ..registerFactory<CarouselCubit>(() => sl<CarouselCubit>())
    ..registerFactory<GetProductDetail>(
      () => GetProductDetail(sl<ProductRepository>()),
    )
    ..registerFactory<ProductBloc>(() => ProductBloc(getProductDetail: sl()));
}

void setUpCart() {
  sl
    ..registerFactory<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(sl<DioApiServices>()),
    )
    ..registerFactory<CartRepository>(
      () => CartRepositoryImpl(sl<CartRemoteDataSource>()),
    )
    ..registerFactory<GetCartByUserUseCase>(() => GetCartByUserUseCase(sl()))
    ..registerFactory<AddToCartUseCase>(() => AddToCartUseCase(sl()))
    ..registerFactory<CartBloc>(
      () => CartBloc(addToCartUseCase: sl(), getCartByUserUseCase: sl()),
    );
}
