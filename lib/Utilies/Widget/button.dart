import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.ontap,
    this.color,
    this.height,
    this.radius,
    this.elevation,
    this.widget,
  });

  final Function()? ontap;
  final Widget? widget;
  final Color? color;
  final double? height;
  final double? radius;
  final double? elevation;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: height ?? size.height * 0.068,
      width: size.width,
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 2,
          side: const BorderSide(color: Colors.white, width: 0.6),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10)),
          backgroundColor: color ?? Colors.white,
        ),
        child: FittedBox(
          child: widget,
        ),
      ),
    );
  }
}
