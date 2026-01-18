import 'package:animation_project/models/location_item_model.dart';
import 'package:animation_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      onTap: onTap,
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
                  Text(location.city, style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    "${location.city}, ${location.country}",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppColor.grey),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: borderColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: location.imgUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator.adaptive()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:animation_project/models/location_item_model.dart';
// import 'package:animation_project/utils/app_color.dart';
// import 'package:flutter/material.dart';

// class LocationItemWidget extends StatelessWidget {
//   const LocationItemWidget({
//     super.key,
//     this.borderColor = AppColor.grey,
//     required this.onTap,
//     required this.location,
//   });

//   final Color borderColor;
//   final VoidCallback onTap;
//   final LocationItemModel location;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap, // ✅ FIXED — this actually calls the callback
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           border: Border.all(color: borderColor),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     location.city,
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   Text(
//                     "${location.city}, ${location.country}",
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleSmall!
//                         .copyWith(color: AppColor.grey),
//                   ),
//                 ],
//               ),
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: borderColor,
//                     radius: 55,
//                   ),
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundImage: NetworkImage(location.imgUrl),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
