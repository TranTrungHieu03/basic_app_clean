import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store_demo/core/common/widgets/rounded_icon.dart';
import 'package:store_demo/core/common/widgets/rounded_image.dart';
import 'package:store_demo/core/utils/constants/sizes.dart';
import 'package:store_demo/features/product/presentation/cubits/carousel/carousel_cubit.dart';

class ImageList extends StatefulWidget {
  const ImageList({super.key, required this.images});

  final List<String> images;

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  late CarouselSliderController carouselController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarouselCubit>(
      create: (context) => CarouselCubit(3),
      child: BlocBuilder<CarouselCubit, CarouselState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(TSizes.sm),
            child: Stack(
              alignment: Alignment.center,
              children: [
                BlocBuilder<CarouselCubit, CarouselState>(
                  builder: (context, state) {
                    return CarouselSlider(
                      carouselController: carouselController,
                      options: CarouselOptions(
                        pageSnapping: true,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        scrollPhysics: const BouncingScrollPhysics(),
                        onPageChanged: (index, _) {
                          // setState(() {
                          //   _currentIndex = index;
                          // });
                        },
                        aspectRatio: 3 / 2,
                      ),
                      items:
                          [widget.images[0], widget.images[0], widget.images[0]]
                              .map(
                                (banner) => TRoundedImage(
                                  imageUrl: banner,
                                  applyImageRadius: false,
                                  isNetworkImage: true,
                                  fit: BoxFit.cover,
                                  onPressed: () => {},
                                  width: 1.sw,
                                  height: 1.sw,
                                ),
                              )
                              .toList(),
                    );
                  },
                ),
                Positioned(
                  left: 3,
                  top: 3,
                  child: TRoundedIcon(
                    icon: Iconsax.arrow_left,
                    onPressed: () => context.pop(),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                if (state.index > 0)
                  Positioned(
                    left: 0,
                    child: TRoundedIcon(
                      backgroundColor: Colors.transparent,
                      icon: Iconsax.arrow_left_2,
                      onPressed: () {
                        carouselController.previousPage();
                        context.read<CarouselCubit>().decrement();
                      },
                    ),
                  ),
                if (state.index < state.maxChoose - 1)
                  Positioned(
                    right: 0,
                    child: TRoundedIcon(
                      icon: Iconsax.arrow_right_34,
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        carouselController.nextPage();
                        context.read<CarouselCubit>().increment();
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    carouselController = CarouselSliderController();
  }
}
