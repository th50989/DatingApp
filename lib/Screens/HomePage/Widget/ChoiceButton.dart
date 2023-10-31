import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChoiceButton extends StatelessWidget {
  final IconData icon;
  final double width;
  final double height;
  final double size;
  final Color color;
  final Function onPressed;
  const ChoiceButton({
    required this.icon,
    required this.width,
    required this.height,
    required this.size,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(50),
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(3, 3),
            )
          ]
        ),
        child: Icon(
          size: size,
          icon,
          color: color,
        ),
      ),
    );
  }
}