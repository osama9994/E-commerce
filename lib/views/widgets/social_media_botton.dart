import 'package:animation_project/utils/app_color.dart';
import 'package:flutter/material.dart';

class SocialMediaBotton extends StatelessWidget {
   SocialMediaBotton({
    super.key,
      this.text,
       this.icon,
        this.ontap,
       this.isLoading = false
       }){
        assert(text!=null || isLoading==true || icon!=null);
        }
final String? text;
final IconData? icon;
final VoidCallback? ontap;
final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: DecoratedBox(decoration: 
      BoxDecoration(
       
        border: Border.all(
          color: AppColor.grey2
          ),
        borderRadius: BorderRadius.circular(16),
        
      
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:isLoading? const CircularProgressIndicator.adaptive(): Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 16),
            Text(text!),
          ],
        ),
        ),
      ),
    );
  }
}