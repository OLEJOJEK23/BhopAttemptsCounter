import 'package:flutter/material.dart';

class RotatingSettingsIcon extends StatefulWidget {
  final VoidCallback onPressed;

  const RotatingSettingsIcon({super.key, required this.onPressed});

  @override
  State<RotatingSettingsIcon> createState() => _RotatingSettingsIconState();
}

class _RotatingSettingsIconState extends State<RotatingSettingsIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _handlePress() {
    // Запускаем анимацию и вызываем внешний callback
    _controller.forward(from: 0.0);
    widget.onPressed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      // Анимация вращения на 180 градусов (PI радиан)
      turns: Tween(begin: 0.0, end: 0.5).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: _handlePress,
      ),
    );
  }
}
