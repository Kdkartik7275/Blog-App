// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TListView extends StatelessWidget {
  const TListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.shrinkWap = false,
    this.physics,
  });

  final int itemCount;

  final Widget? Function(BuildContext, int) itemBuilder;
  final bool shrinkWap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      shrinkWrap: shrinkWap,
      physics: physics,
    );
  }
}
