import 'package:flutter/material.dart';
import 'package:animation_project/utils/app_color.dart';

class LabelWithTextfieldNewCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final String hintText;
  final TextEditingController controller;

  const LabelWithTextfieldNewCard({
    super.key,
    required this.label,
    required this.icon,
    required this.hintText,
    required this.controller,
  });

  @override
  State<LabelWithTextfieldNewCard> createState() => _LabelWithTextfieldNewCardState();
}

class _LabelWithTextfieldNewCardState extends State<LabelWithTextfieldNewCard> {
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
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon),
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

