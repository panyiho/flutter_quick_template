import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetImage extends StatelessWidget {
  final String imageUrl;

  final Widget? placeholder;

  final Widget? errorWidget;

  final BoxFit? fit;

  final double? width;

  final double? height;

  final double? placeHolderHeight;

  const NetImage(
      {Key? key,
      required this.imageUrl,
      this.placeholder,
      this.errorWidget,
      this.fit,
      this.width,
      this.height,
      this.placeHolderHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => placeholder ?? _defaultPlaceholder(),
      errorWidget: (context, url, error) =>
          errorWidget ?? _defaultPlaceholder(),
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      fadeInDuration: const Duration(milliseconds: 1),
      fadeOutDuration: const Duration(milliseconds: 1),
    );
  }

  Widget _defaultPlaceholder() {
    return Container(
        width: placeHolderHeight,
        height: height ?? 300.h,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(231, 234, 236, 1),
          borderRadius: BorderRadius.all(
            Radius.circular(5.h),
          ),
        ));
  }
}
