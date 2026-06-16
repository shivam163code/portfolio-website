import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AnimatedGradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isOutlined;
  final double? width;

  const AnimatedGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isOutlined = false,
    this.width,
  });

  @override
  State<AnimatedGradientButton> createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.03 : 1.0),
        transformAlignment: Alignment.center,
        child: widget.isOutlined
            ? _buildOutlined()
            : _buildFilled(),
      ),
    );
  }

  Widget _buildFilled() {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: _isHovered
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
      ),
      child: ElevatedButton.icon(
        onPressed: widget.onPressed,
        icon: widget.icon != null
            ? Icon(widget.icon, size: 18)
            : const SizedBox.shrink(),
        label: Text(widget.text),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlined() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isHovered ? AppColors.secondary : AppColors.primary,
          width: 1.5,
        ),
        color: _isHovered
            ? AppColors.primary.withOpacity(0.1)
            : Colors.transparent,
      ),
      child: TextButton.icon(
        onPressed: widget.onPressed,
        icon: widget.icon != null
            ? Icon(widget.icon, size: 18, color: AppColors.primary)
            : const SizedBox.shrink(),
        label: Text(
          widget.text,
          style: const TextStyle(color: AppColors.primary),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
