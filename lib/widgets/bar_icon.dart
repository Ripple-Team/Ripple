import 'package:flutter/material.dart';

class BarIcon extends StatelessWidget {
  final String title;
  final Icon icon;

  const BarIcon({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("("), icon, Text(")")],
          ),
          Text(title),
        ],
      ),
    );
  }
}
