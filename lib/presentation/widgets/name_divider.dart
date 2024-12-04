import 'package:flutter/material.dart';

class NameDivider extends StatelessWidget {
  final String text;

  const NameDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Expanded dividerLine() {
      return Expanded(
        child: Container(
          color: const Color.fromRGBO(208, 206, 220, 1.0),
          child: const Divider(
            color: Colors.transparent,
            height: 1.5,
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          dividerLine(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(text),
          ),
          dividerLine(),
        ],
      ),
    );
  }
}
