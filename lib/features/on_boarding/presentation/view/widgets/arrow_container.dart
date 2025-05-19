import 'package:flutter/material.dart';

class ArrowContainer extends StatelessWidget {
  const ArrowContainer({
    super.key,
    required this.icon,
    required this.color,
    this.onTap,
  });
  final IconData icon;
  final Color color;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(
                  color: color,
                  width: 1,
                ))),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}
