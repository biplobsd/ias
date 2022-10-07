import 'package:flutter/material.dart';

class CheckButtonLW extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? width;
  final double? height;
  final Color? color;
  const CheckButtonLW({
    required this.text,
    required this.onPressed,
    this.color,
    this.width = double.infinity,
    this.height = 45,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: color,
            elevation: 0.3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
