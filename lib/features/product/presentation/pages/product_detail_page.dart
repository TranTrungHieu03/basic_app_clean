import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store_demo/core/common/widgets/show_snackbar.dart';
import 'package:store_demo/core/utils/constants/colors.dart';
import 'package:store_demo/core/utils/constants/sizes.dart';
import 'package:store_demo/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:store_demo/features/cart/domain/usecases/add_to_cart.dart';
import 'package:store_demo/features/cart/presentation/blocs/cart/cart_bloc.dart';
import 'package:store_demo/features/product/domain/entities/product_entity.dart';
import 'package:store_demo/features/product/domain/usecases/get_product_detail.dart';
import 'package:store_demo/features/product/presentation/blocs/product/product_bloc.dart';
import 'package:store_demo/features/product/presentation/widgets/image_list.dart';
import 'package:store_demo/init_dependencies.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (context) =>
          sl<ProductBloc>()
            ..add(GetProductDetailEvent(GetProductDetailParams(productId))),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  final product = state.product;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageList(images: product.images),

                      ProductInformation(product, context),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoaded) {
              final product = state.product;
              return BottomProductBar(product, context);
            }

            return SizedBox();
          },
        ),
      ),
    );
  }

  Widget BottomProductBar(ProductEntity product, BuildContext context) {
    final authState = context.read<AuthBloc>().state as AuthLoaded;
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartLoaded) {
          TSnackBar.successSnackBar(context, message: 'Add to cart success');
        }
        if (state is CartError) {
          TSnackBar.errorSnackBar(context, message: state.message);
        }
      },
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          vertical: TSizes.lg,
          horizontal: TSizes.sm,
        ),

        child: Container(
          color: Colors.white70,
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${product.price} ",
                    style: Theme.of(context)!.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: TColors.darkerGrey,
                    ),
                  ),

                  Text(
                    "\$${(product.price * (100 - product.discountPercentage) / 100).toStringAsFixed(2)} ",
                    style: Theme.of(context)!.textTheme.labelMedium!.copyWith(
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w400,
                      color: TColors.primary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(TSizes.sm),
                      border: BoxBorder.all(color: TColors.primary),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(TSizes.sm),
                          child: Icon(
                            Iconsax.heart,
                            color: TColors.primary,
                            size: 25,
                          ),
                        ),

                        VerticalDivider(
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                          color: TColors.primary,
                        ),
                        GestureDetector(
                          onTap: () => context.read<CartBloc>().add(
                            AddToCartEvent(
                              AddToCartDto(
                                userId: authState.user.id.toString(),
                                products: [
                                  ProductCartDto(quantity: 1, id: product.id),
                                ],
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(TSizes.sm),
                            child: Icon(
                              Iconsax.shopping_bag,
                              color: TColors.primary,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: TSizes.sm),
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Buy now"),
                        const SizedBox(width: TSizes.sm),
                        Icon(Iconsax.arrow_right_1, size: 20, weight: 90),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding ProductInformation(ProductEntity product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                product.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: TSizes.sm),
              Container(
                padding: EdgeInsets.symmetric(horizontal: TSizes.sm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(TSizes.md),
                  color: TColors.primary,
                ),
                child: Text(
                  product.availabilityStatus,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "\$${product.price} ",
                      style: Theme.of(context)!.textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),

                    TextSpan(
                      text:
                          "\$${(product.price * (100 - product.discountPercentage) / 100).toStringAsFixed(2)} ",
                      style: Theme.of(context)!.textTheme.labelMedium!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w400,
                        color: TColors.primary,
                      ),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
              product.discountPercentage > 0
                  ? Container(
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
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium!.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: TSizes.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingBarIndicator(
                rating: product.rating,
                itemBuilder: (context, index) =>
                    Icon(Icons.star, color: Colors.orange),
                itemCount: 5,
                itemSize: 23.0,
                unratedColor: Colors.orange.withAlpha(50),
                direction: Axis.horizontal,
              ),
              const SizedBox(width: TSizes.xs),
              Text('${product.rating}/5'),
              const SizedBox(width: TSizes.xs),
              Text(
                '(${product.reviews.length})',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: TSizes.sm),
          Divider(color: TColors.grey, thickness: 0.5, indent: 0, endIndent: 0),
          const SizedBox(height: TSizes.sm),
          Text(
            "${product.weight}ml",
            style: Theme.of(
              context,
            )!.textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: TSizes.sm),
          Text(product.description),
          const Text("More information:"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("- ${product.warrantyInformation}"),
                Text("- ${product.shippingInformation}"),
                Text("- ${product.returnPolicy}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
