import 'package:flutter/material.dart';
import 'package:animation_project/utils/app_color.dart';

class LabelWithTextfield extends StatefulWidget {
  final String label;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  const LabelWithTextfield({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.hintText,
    required this.controller, 
    this.suffixIcon,
     this.obscureText=false,
  });

  @override
  State<LabelWithTextfield> createState() => _LabelWithTextfieldState();
}

class _LabelWithTextfieldState extends State<LabelWithTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          validator:(value) => value==null||value.isEmpty?"${widget.label} Can not be Empty":null ,
          
          controller: widget.controller,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.prefixIcon),
            suffixIcon: widget.suffixIcon,
            suffixIconColor: AppColor.grey,
            hintText: widget.hintText,
            fillColor: AppColor.grey1,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColor.red,
              )
            )
          ),
        ),
      ],
    );
  }
}

