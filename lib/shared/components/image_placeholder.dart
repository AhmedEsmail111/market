import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';

class BuildImagePlaceholder extends StatelessWidget {
  final double imageHeight;
  final double imageWidth;
  final String image;
  final double? cachedHeight;
  final double? cachedWidth;
  final BoxFit? fit;
  final bool isAsset;

  const BuildImagePlaceholder({
    super.key,
    required this.image,
    this.fit,
    required this.imageHeight,
    required this.imageWidth,
    this.cachedHeight,
    this.cachedWidth,
    this.isAsset = false,
  });
  @override
  Widget build(BuildContext context) {
    return !isAsset
        ? ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              errorBuilder: (context, error, stackTrace) => ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Image(
                  colorBlendMode: BlendMode.color,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.07),
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.cover,
                  image: MemoryImage(kTransparentImage),
                ),
              ),
              width: imageWidth,
              height: imageHeight,
              image,

              filterQuality: FilterQuality.low,
              fit: fit,
              cacheHeight: cachedHeight != null
                  ? cachedHeight!.round()
                  : imageHeight.round(),

              cacheWidth: cachedWidth != null
                  ? cachedWidth!.round()
                  : imageWidth.round(),
              // opacity: Tween(),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              // errorBuilder: (context, error, stackTrace) => ClipRRect(
              //   borderRadius: BorderRadius.circular(14.r),
              //   child: Image(
              //     colorBlendMode: BlendMode.color,
              //     color:
              //         Theme.of(context).colorScheme.secondary.withOpacity(0.07),
              //     width: imageWidth,
              //     height: imageHeight,
              //     fit: BoxFit.cover,
              //     image: MemoryImage(kTransparentImage),
              //   ),
              // ),
              width: imageWidth,
              height: imageHeight,
              image,
              filterQuality: FilterQuality.high,
              fit: fit,
              cacheHeight: cachedHeight != null
                  ? cachedHeight!.round()
                  : imageHeight.round(),
              cacheWidth: cachedWidth != null
                  ? cachedWidth!.round()
                  : imageWidth.round(),

              // opacity: Tween(),
            ),
          );
  }
}
