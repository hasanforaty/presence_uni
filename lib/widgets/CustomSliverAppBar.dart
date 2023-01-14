import 'package:flutter/material.dart';

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  double expandedHeight;
  Widget? background;
  Widget? appBar;
  CustomSliverAppBar({
    required this.expandedHeight,
    this.background,
    this.appBar,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Opacity(opacity: disappear(shrinkOffset), child: background),
        Opacity(
          opacity: appear(shrinkOffset),
          child: appBar,
        )
      ],
    );
  }

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;
  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
