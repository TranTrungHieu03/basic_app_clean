import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store_demo/core/common/widgets/rounded_icon.dart';
import 'package:store_demo/core/common/widgets/shimmer_effect.dart';
import 'package:store_demo/core/common/widgets/show_snackbar.dart';
import 'package:store_demo/core/services/logger.dart';
import 'package:store_demo/core/utils/constants/colors.dart';
import 'package:store_demo/core/utils/constants/env.dart';
import 'package:store_demo/core/utils/constants/env.dart';
import 'package:store_demo/core/utils/constants/images.dart';
import 'package:store_demo/core/utils/constants/router.dart';
import 'package:store_demo/core/utils/constants/sizes.dart';
import 'package:store_demo/features/product/domain/entities/product_entity.dart';
import 'package:store_demo/features/product/domain/usecases/get_list_product.dart';
import 'package:store_demo/features/product/domain/usecases/search_product_by_category.dart';
import 'package:store_demo/features/product/presentation/blocs/list_category/list_category_bloc.dart';
import 'package:store_demo/features/product/presentation/blocs/list_category/list_category_bloc.dart';
import 'package:store_demo/features/product/presentation/blocs/list_product/list_product_bloc.dart';
import 'package:store_demo/init_dependencies.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({super.key});

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListProductBloc>(
      create: (context) => sl<ListProductBloc>()
        ..add(
          GetListProductEvent(
            GetListProductDto(
              limit: int.parse(AppEnv.limitPagination),
              page: 1,
            ),
          ),
        ),

      child: Scaffold(
        body: SafeArea(
          child: MultiBlocListener(
            listeners: [
              BlocListener<ListProductBloc, ListProductState>(
                listener: (context, state) {
                  if (state is ListProductError) {
                    TSnackBar.errorSnackBar(context, message: state.message);
                  }
                },
              ),
              BlocListener<ListCategoryBloc, ListCategoryState>(
                listener: (context, state) {
                  if (state is ListCategoryError) {
                    TSnackBar.errorSnackBar(context, message: state.message);
                  }
                },
              ),
            ],
            child: Padding(
              padding: const EdgeInsetsGeometry.all(TSizes.sm),
              child: Column(
                children: [
                  CustomHeaderHome(),

                  const SizedBox(height: TSizes.md),
                  // listCategories(),
                  listCategories(),
                  const SizedBox(height: TSizes.md),
                  ListProducts(),
                  // Text("Hello, ${}")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder<ListCategoryBloc, ListCategoryState> listCategories() {
    var chooseCategory = 0;
    return BlocBuilder<ListCategoryBloc, ListCategoryState>(
      builder: (context, state) {
        if (state is ListCategoryLoaded) {
          final categories = state.categories;
          return SizedBox(
            height: 40,
            child: ListView.separated(
              key: Key("list-categories"),
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, indexCategory) {
                return GestureDetector(
                  onTap: () {
                    context.read<ListCategoryBloc>().add(
                      ChangeIndexCategoryEvent(indexCategory),
                    );

                    if (indexCategory != 0) {
                      context.read<ListProductBloc>().add(
                        SearchProductByCategoryEvent(
                          SearchProductByCategoryDto(
                            type: categories[indexCategory].slug,
                            page: 1,
                            limit: int.parse(AppEnv.limitPagination),
                          ),
                        ),
                      );
                    } else {
                      AppLogger.info(categories[indexCategory].slug);
                      context.read<ListProductBloc>().add(
                        GetListProductEvent(
                          GetListProductDto(
                            limit: int.parse(AppEnv.limitPagination),
                            page: 1,
                            isFirstRender: true,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: TSizes.sm),
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(TSizes.lg),
                      color: state.choose == indexCategory
                          ? TColors.primary
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 0.2,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                    height: TSizes.lg,
                    child: Text(
                      categories[indexCategory].name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: state.choose == indexCategory
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: TSizes.md),
              itemCount: categories.length,
            ),
          );
        }
        if (state is ListCategoryLoading) {
          return SizedBox(
            height: 40,
            child: ListView.separated(
              key: Key("list-categories-shimmer"),
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, indexCategory) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: TSizes.sm),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(TSizes.lg),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        blurRadius: 0.2,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                  height: TSizes.lg,
                  child: TShimmerEffect(
                    width: TSizes.shimmerLg,
                    height: TSizes.md,
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: TSizes.md),
              itemCount: 3,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  @override
  void initState() {
    context.read<ListCategoryBloc>().add(GetListCategoryEvent());
    super.initState();
  }

  Row CustomHeaderHome() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 0.3.sw,
          padding: const EdgeInsetsGeometry.all(TSizes.md),
          child: Center(child: Image(image: AssetImage(TImages.logo))),
        ),
        Row(
          children: [
            TRoundedIcon(
              icon: Iconsax.shopping_bag,
              size: TSizes.lg,
              onPressed: () => context.push(AppRouter.cart),
            ),
            const SizedBox(width: TSizes.sm),
            TRoundedIcon(icon: Iconsax.notification),
            const SizedBox(width: TSizes.sm),
            TRoundedIcon(icon: Iconsax.setting),
          ],
        ),
      ],
    );
  }
}

class ListProducts extends StatefulWidget {
  const ListProducts({super.key});

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  late ScrollController _scrollController;

  void _onScroll() {
    if (_scrollController.position.extentAfter < 200) {
      final currentState = context.read<ListProductBloc>().state;
      if (currentState is ListProductLoaded &&
          !currentState.isLoadingMore &&
          currentState.pagination.page <
              (currentState.pagination.totalPage).toInt()) {
        if (currentState.type != 'all') {
          context.read<ListProductBloc>().add(
            SearchProductByCategoryEvent(
              SearchProductByCategoryDto(
                type: currentState.type,
                limit: int.parse(AppEnv.limitPagination),
                page: currentState.pagination.page.toInt() + 1,
              ),
            ),
          );
        } else {
          context.read<ListProductBloc>().add(
            GetListProductEvent(
              GetListProductDto(
                limit: int.parse(AppEnv.limitPagination),
                page: currentState.pagination.page.toInt() + 1,
                isFirstRender: false,
              ),
            ),
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ListProductBloc, ListProductState>(
        builder: (context, state) {
          if (state is ListProductLoaded) {
            AppLogger.warning(state.pagination.totalPage.toInt());
            AppLogger.warning(state.pagination.total);
            final products = state.products;
            return GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 200,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                if (index >= products.length) {
                  return state.isLoadingMore
                      ? shimmerProductCard()
                      : const SizedBox();
                }
                final product = products[index];
                return cardProduct(product, context);
              },
              itemCount: products.length + 2,
            );
          }
          if (state is ListProductLoading) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 200,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return shimmerProductCard();
              },
              itemCount: 6,
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Container shimmerProductCard() {
    return Container(
      padding: EdgeInsetsGeometry.all(TSizes.xs),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 0.2,
            spreadRadius: 0.5,
          ),
        ],
      ),
      width: 0.4.sw,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TShimmerEffect(width: 0.38.sw, height: 0.38.sw),
          const SizedBox(height: TSizes.xs),
          TShimmerEffect(width: TSizes.shimmerMd, height: TSizes.md),
          const SizedBox(height: TSizes.xs),
          Row(
            children: [
              TShimmerEffect(width: TSizes.md * 5, height: TSizes.md),
              const SizedBox(width: TSizes.md),
              TShimmerEffect(width: TSizes.md * 3, height: TSizes.md),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardProduct(ProductEntity product, BuildContext context) {
    return GestureDetector(
      // onTap: () => context.pushNamed('/products/${product.id}'),
      onTap: () => context.pushNamed(
        AppRouter.productDetail,
        pathParameters: {'productId': product.id.toString()},
      ),
      child: Container(
        padding: EdgeInsetsGeometry.all(TSizes.xs),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              blurRadius: 0.2,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 0,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: product.thumbnail,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                              return TShimmerEffect(
                                width: 0.38.sw,
                                height: 0.38.sw,
                              );
                            },
                        width: 0.4.sw,
                        height: 0.4.sw,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  product.discountPercentage > 0
                      ? Positioned(
                          right: 4,
                          top: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [],
                              color: Colors.green,
                            ),

                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: TSizes.xs,
                            ),
                            child: Text(
                              "-${product.discountPercentage.toStringAsFixed(1)}\%",
                              style: Theme.of(context).textTheme.labelMedium!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            Text(
              product.title,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)!.textTheme.bodyLarge,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "\$${product.price} ",
                    style: Theme.of(context)!.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  TextSpan(
                    text:
                        "\$${(product.price * (100 - product.discountPercentage)).toStringAsFixed(2)} ",
                    style: Theme.of(context)!.textTheme.labelMedium!.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: TColors.primary,
                    ),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
