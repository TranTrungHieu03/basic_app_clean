import 'package:flutter/material.dart';
import 'package:store_demo/core/utils/constants/sizes.dart';

class TRoundedIcon extends StatelessWidget {
  const TRoundedIcon({
    super.key,
    this.height,
    this.width,
    this.size = TSizes.lg,
    required this.icon,
    this.color = Colors.black,
    this.borderRadius = 100,
    this.backgroundColor,
    this.onPressed,
  });

  final double? height, width, size;
  final double borderRadius;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (dark
                ? Colors.black.withOpacity(0.9)
                : Colors.grey.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}
