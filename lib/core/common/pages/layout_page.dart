import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store_demo/core/utils/constants/colors.dart';

class LayoutPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const LayoutPage({super.key, required this.navigationShell});

  void goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.setting),
            label: 'Setting',
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        selectedItemColor: TColors.primary,
        unselectedItemColor: Colors.grey.shade300,
        onTap: (index) {
          goBranch(index);
        },
      ),
    );
  }
}
