
import 'package:flutter/material.dart';

class IosTapEffect extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double activeOpacity;
  final Duration duration;

  const IosTapEffect({
    super.key,
    required this.child,
    required this.onTap,
    this.activeOpacity = 0.7,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<IosTapEffect> createState() => _IosTapEffectState();
}

class _IosTapEffectState extends State<IosTapEffect> {
  double _opacity = 1.0;

  void _onTapDown(_) => setState(() => _opacity = widget.activeOpacity);
  void _onTapUp(_) {
    setState(() => _opacity = 1.0);
    widget.onTap();
  }

  void _onTapCancel() => setState(() => _opacity = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedOpacity(
        duration: widget.duration,
        opacity: _opacity,
        child: widget.child,
      ),
    );
  }
}
