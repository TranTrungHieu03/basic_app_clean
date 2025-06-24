import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_demo/core/utils/constants/colors.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(color: TColors.primary)),
    );
  }
}
