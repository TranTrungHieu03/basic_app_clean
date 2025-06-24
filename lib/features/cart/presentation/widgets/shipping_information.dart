
import 'package:flutter/material.dart';
import 'package:store_demo/core/common/widgets/rounded_icon.dart';
import 'package:store_demo/core/utils/constants/colors.dart';
import 'package:store_demo/core/utils/constants/sizes.dart';

class ShippingInformation extends StatelessWidget {
  final String address;
  const ShippingInformation({
    super.key, required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(TSizes.sm),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(TSizes.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shipping Address', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: TColors.primary),),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(address),
              TRoundedIcon(
                icon: Icons.edit,
                color: Colors.white,
                backgroundColor: TColors.primary,
                height: 40,
                width: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
