import 'package:animation_project/utils/app_color.dart';
import 'package:flutter/material.dart';

class MainBotton extends StatelessWidget {
    final double height;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final String? text;
  final bool isLoading;
   MainBotton({
    super.key,
    this.onTap,
    this.height = 60,
    this.backgroundColor = AppColor.primary,
    this.foregroundColor = AppColor.white,
   this.text,
    this.isLoading=false,
  })
  {
    assert(text!=null ||isLoading==true);
  }

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
        child:isLoading?
        const Center(child: CircularProgressIndicator.adaptive(),)
        :  Text(text!),
      ),
    );
  }
}
