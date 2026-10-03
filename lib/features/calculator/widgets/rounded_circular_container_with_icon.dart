import 'package:flutter/material.dart';
import 'package:glass_calculator/features/calculator/widgets/rounded_circular_container.dart';

class RoundedCircularContainerWithIcon extends StatelessWidget {
  const RoundedCircularContainerWithIcon({
    super.key,
    required this.icon,
    this.iconCOlor = Colors.white,
  });
  final IconData icon;
  final Color iconCOlor;

  @override
  Widget build(BuildContext context) {
    return RoundedCircularContainer(
      child: Icon(icon, color: iconCOlor.withValues(alpha: 0.8)),
    );
  }
}
