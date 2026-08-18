import 'package:flutter/material.dart';

class BarIcon extends StatelessWidget {
  final String title;
  final Icon icon;

  const BarIcon({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("("),
              const SizedBox(width: 5),
              icon,
              const SizedBox(width: 5),
              Text(")"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                softWrap: false,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
