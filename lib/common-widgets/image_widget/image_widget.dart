import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:united_proposals_app/utils/app_colors.dart';

class ImageWidget extends StatelessWidget {
  final String profileImage;
  final String? localProfileImage;
  final double? size;
  final double? radius;
  final bool? isRadius;
  const ImageWidget(
      {super.key,
      required this.profileImage,
      this.size,
      this.isRadius,
      this.radius,
      this.localProfileImage});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: profileImage,
      imageBuilder: (context, imageProvider) => Container(
        height: size ?? 50,
        width: size ?? 50,
        decoration: BoxDecoration(
          shape: (isRadius ?? false) ? BoxShape.rectangle : BoxShape.circle,
          borderRadius:
              (isRadius ?? false) ? BorderRadius.circular(radius ?? 10) : null,
          border:
              Border.all(color: AppColors.primary.withOpacity(.8), width: 1),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      fit: BoxFit.cover,
      errorWidget: (context, url, e) => Container(
          height: size ?? 50,
          width: size ?? 50,
          decoration: BoxDecoration(
            shape: (isRadius ?? false) ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: (isRadius ?? false)
                ? BorderRadius.circular(radius ?? 10)
                : null,
            border:
                Border.all(color: AppColors.primary.withOpacity(.8), width: 1),
          ),
          child: const Icon(Icons.error)),
      placeholder: (context, url) {
        return SizedBox(
          height: size ?? 50,
          width: size ?? 50,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
