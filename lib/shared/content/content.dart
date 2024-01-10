import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Content extends StatelessWidget {
  final Widget child;
  final bool loading;

  const Content({super.key, required this.child, this.loading = false});

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return child;
    }
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        color: Colors.grey[300],
        child: child,
      ),
    );
  }
}
