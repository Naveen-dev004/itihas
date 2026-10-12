import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  final Widget iconWidget;
  final VoidCallback onPressed;

  const SocialAuthButton({
    super.key,
    required this.iconWidget,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE7A83B).withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(29),
          child: Center(
            child: iconWidget,
          ),
        ),
      ),
    );
  }
}
