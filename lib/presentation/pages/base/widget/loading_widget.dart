import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  final double? radius;

  const LoadingWidget({super.key, this.radius = 16});

  @override
  State<StatefulWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
          child: CupertinoActivityIndicator(
        radius: widget.radius!,
        color: Colors.white,
      )),
    );
  }
}
