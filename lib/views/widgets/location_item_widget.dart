import 'package:animation_project/models/location_item_model.dart';
import 'package:animation_project/utils/app_color.dart';
import 'package:flutter/material.dart';

class LocationItemWidget extends StatelessWidget {
  const LocationItemWidget({
    super.key,
    this.borderColor = AppColor.grey,
    required this.onTap,
    required this.location,
  });

  final Color borderColor;
  final VoidCallback onTap;
  final LocationItemModel location;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // ✅ FIXED — this actually calls the callback
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.city,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "${location.city}, ${location.country}",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColor.grey),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: borderColor,
                    radius: 55,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(location.imgUrl),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
