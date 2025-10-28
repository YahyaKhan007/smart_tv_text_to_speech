import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  final double dotRadius;
  final double spacing;
  final Color color;

  const DottedDivider({
    this.dotRadius = 2.0,
    this.spacing = 5.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate how many dots fit in the available width
        final boxWidth = 2 * dotRadius + spacing;
        final dotCount = (constraints.maxWidth / boxWidth).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dotCount, (index) {
            return Container(
              width: 3 * dotRadius,
              height: 0.5 * dotRadius,
              decoration: BoxDecoration(
                color: color,
                // shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}