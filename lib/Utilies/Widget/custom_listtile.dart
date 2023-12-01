import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customlisttile2 extends StatelessWidget {
  const Customlisttile2(
      {super.key, required this.icon, required this.tap, required this.title});
  final IconData icon;
  final Function()? tap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(left: 10, bottom: 1),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Icon(
              icon,
              size: 26,
            ),
          ),
          onTap: tap,
          title: Text(
            title,
            style: GoogleFonts.robotoSlab(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
