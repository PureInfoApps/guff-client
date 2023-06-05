import 'package:flutter/material.dart';
import 'package:guff/views/widgets/auto_scroll.dart';
import 'package:guff/views/widgets/rotated_infinite_tile_grid_view.dart';
import 'package:guff/views/widgets/movie_cover_tile.dart';

/// A widget that displays a scrolling background of movie covers.
class ScrollingMovieCoversBackground extends StatelessWidget {
  /// Creates a [ScrollingMovieCoversBackground].
  const ScrollingMovieCoversBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoScroll(
      child: (ScrollController scrollController) {
        return RotatedInfiniteTileGridView(
          scrollController: scrollController,
          itemBuilder: (BuildContext context, int index) {
            return MovieCoverTile(
              image: AssetImage(
                'assets/boarding_cover_arts/${(index % 36) + 1}.webp',
              ),
            );
          },
        );
      },
    );
  }
}
