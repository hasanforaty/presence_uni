import 'package:flutter/material.dart';

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  double expandedHeight;
  Widget? background;
  Widget? appBar;
  Widget? sortWidget;
  double sortWidgetSize;
  CustomSliverAppBar({
    required this.expandedHeight,
    this.background,
    this.appBar,
    this.sortWidget,
    this.sortWidgetSize = 60,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double top = expandedHeight - shrinkOffset - sortWidgetSize / 2;
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Opacity(opacity: disappear(shrinkOffset), child: background),
        Opacity(
          opacity: appear(shrinkOffset),
          child: appBar,
        ),
        Positioned(
          top: top,
          right: 30,
          left: 30,
          child: Opacity(
            opacity: disappear(shrinkOffset),
            child: sortWidget,
          ),
        )
      ],
    );
  }

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;
  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
