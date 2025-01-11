import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyImages {
  static Widget normalImage(String? url, {BoxFit fit = BoxFit.cover}) {
    if (url == null || url.isEmpty) {
      return Image.asset(
        'assets/images/342x200.png',
        fit: fit,
      );
    }
    return CachedNetworkImage(
      fit: fit,
      imageUrl: url,
      placeholder: (BuildContext context, String url) {
        return Image.asset(
          'assets/images/342x200.png',
          fit: fit,
        );
      },
      errorWidget: (BuildContext context, String url, dynamic error) {
        return Image.asset(
          'assets/logo/app_logo.png',
          fit: fit,
          color: Colors.grey.withOpacity(0.4),
        );
      },
    );
  }
}

class MyImage {
  /// Returns an [ImageProvider] based on the provided [url].
  ///
  /// If [url] is null or empty, a default local image is returned.
  /// In case of an error, a fallback image provider is used.
  static ImageProvider<Object> imageProvider(String? url) {
    if (url == null || url.isEmpty) {
      return const AssetImage('assets/images/342x200.png');
    }

    // Here, use a placeholder for CachedNetworkImage
    // but for DecorationImage we need to use ImageProvider.
    return CachedNetworkImageProvider(url);
  }
}
