import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color fontColor;

  const IconText({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.black,
    this.fontColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          color: iconColor,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(color: fontColor, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
