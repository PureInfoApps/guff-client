import 'package:flutter/material.dart';

/// A custom widget that displays a movie cover tile.
class MovieCoverTile extends StatelessWidget {
  /// Creates a [MovieCoverTile].
  ///
  /// The [image] parameter specifies the [AssetImage] to be used as the cover
  /// image.
  const MovieCoverTile({Key? key, required this.image}) : super(key: key);

  /// The [AssetImage] to be used as the cover image.
  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.contain,
          isAntiAlias: true,
        ),
      ),
    );
  }
}
