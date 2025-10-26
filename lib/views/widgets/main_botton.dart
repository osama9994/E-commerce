import 'package:animation_project/utils/app_color.dart';
import 'package:flutter/material.dart';

class MainBotton extends StatelessWidget {
  const MainBotton({
    super.key,
    this.onTap,
    this.height = 60,
    this.backgroundColor = AppColor.primary,
    this.foregroundColor = AppColor.white,
    required this.text,
  });
  final double height;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor:foregroundColor,
        ),
        child:  Text(text),
      ),
    );
  }
}
