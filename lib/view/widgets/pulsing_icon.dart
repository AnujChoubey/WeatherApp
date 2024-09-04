import 'package:flutter/material.dart';

class PulsingIcon extends StatefulWidget {
  final String iconUrl;

  PulsingIcon({required this.iconUrl});

  @override
  _PulsingIconState createState() => _PulsingIconState();
}

class _PulsingIconState extends State<PulsingIcon> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      lowerBound: 0.8,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _controller!,
      child: Image.network(widget.iconUrl,height: 80,width: 80,),
    );
  }
}