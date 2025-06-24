import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store_demo/core/common/widgets/rounded_icon.dart';
import 'package:store_demo/core/common/widgets/shimmer_effect.dart';
import 'package:store_demo/core/utils/constants/colors.dart';
import 'package:store_demo/core/utils/constants/sizes.dart';
import 'package:store_demo/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:store_demo/features/cart/domain/entities/cart_product_entity.dart';
import 'package:store_demo/features/cart/domain/usecases/get_cart_by_user.dart';
import 'package:store_demo/features/cart/presentation/blocs/cart/cart_bloc.dart';
import 'package:store_demo/features/cart/presentation/widgets/shipping_information.dart';
import 'package:store_demo/init_dependencies.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state as AuthLoaded;
    context.read<CartBloc>().add(
      GetCartByUserEvent(
        GetCartByUserDto(userId: authState.user.id.toString()),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(TSizes.sm),
        child: Column(
          children: [
            ShippingInformation(address: "125 Ram Hoai"),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ProductCart(productCart: state.cart.products[index]),
                          Divider(
                            thickness: 0.5,
                            color: Colors.grey.shade300,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ],
                      );
                    },
                    itemCount: state.cart.products.length,
                  );
                } else if (state is CartLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCart extends StatelessWidget {
  final CartProductEntity productCart;

  const ProductCart({super.key, required this.productCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(TSizes.xs),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        imageUrl:
                            "https://cdn.dummyjson.com/products/images/womens-bags/Prada%20Women%20Bag/thumbnail.png",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                              return TShimmerEffect(
                                width: 0.25.sw,
                                height: 0.25.sw,
                              );
                            },
                        width: 0.25.sw,
                        height: 0.25.sw,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: TSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product A",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: TSizes.xs),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text.rich(
                              softWrap: true,

                              TextSpan(
                                children: [
                                  TextSpan(
                                    // text: "\$${product.price} ",
                                    text: "1000",
                                    style: Theme.of(context)!
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),

                                  TextSpan(
                                    text: "1000",
                                    // "\$${(product.price * (100 - product.discountPercentage) / 100).toStringAsFixed(2)} ",
                                    style: Theme.of(context)!
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontWeight: FontWeight.w400,
                                          color: TColors.primary,
                                        ),
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                            // product.discountPercentage > 0
                            true
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
                                      // "-${product.discountPercentage.toStringAsFixed(1)}\%",
                                      "10%",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: Colors.white),
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
                              // rating: product.rating,
                              rating: 4.3,
                              itemBuilder: (context, index) =>
                                  Icon(Icons.star, color: Colors.orange),
                              itemCount: 5,
                              itemSize: 20.0,
                              unratedColor: Colors.orange.withAlpha(50),
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(width: TSizes.xs),
                            // Text('${product.rating}/5'),
                            Text('3/5'),
                            const SizedBox(width: TSizes.xs),
                            Text(
                              // '(${product.reviews.length})',
                              '(5)',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 25,

                          child: Row(
                            children: [
                              Text(
                                'Quantity: 1',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: TColors.darkerGrey),
                              ),
                              VerticalDivider(
                                color: Colors.grey,
                                thickness: 0.5,
                                indent: 3,
                                endIndent: 3,
                              ),
                              Text(
                                'Size: ',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: TColors.darkerGrey),
                              ),
                              Text(
                                "200ml",
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: TColors.darkerGrey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.delete, color: TColors.darkGrey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
