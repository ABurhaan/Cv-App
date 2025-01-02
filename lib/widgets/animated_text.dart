import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration delay;

  const AnimatedText({
    Key? key,
    required this.text,
    required this.style,
    this.delay = Duration.zero,
  }) : super(key: key);

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  String _displayText = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _startAnimation();
      }
    });
  }

  void _startAnimation() async {
    await _controller.forward();
    if (mounted) {
      setState(() {
        _displayText = widget.text;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Text(
        _displayText,
        style: widget.style,
      ),
    );
  }
}