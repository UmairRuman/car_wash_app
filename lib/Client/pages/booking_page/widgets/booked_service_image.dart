import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookedServiceImage extends StatelessWidget {
  final String imagepath;
  const BookedServiceImage({super.key, required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: imagepath[0] == "a"
              ? AssetImage(imagepath) as ImageProvider
              : CachedNetworkImageProvider(imagepath),
          fit: BoxFit
              .cover, // Ensures both asset and network images cover the whole area
        ),
      ),
      child: imagepath[0] == "a"
          ? null // The image is already being handled by DecorationImage
          : CachedNetworkImage(
              imageUrl: imagepath,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
    );
  }
}
