import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ScrollProgressIndicatorWidget extends StatefulWidget {
  final ScrollController scrollController;

  const ScrollProgressIndicatorWidget({
    super.key,
    required this.scrollController,
  });

  @override
  State<ScrollProgressIndicatorWidget> createState() =>
      _ScrollProgressIndicatorWidgetState();
}

class _ScrollProgressIndicatorWidgetState
    extends State<ScrollProgressIndicatorWidget> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateProgress);
  }

  void _updateProgress() {
    if (!mounted) return;
    final max = widget.scrollController.position.maxScrollExtent;
    final current = widget.scrollController.position.pixels;
    setState(() {
      _progress = max > 0 ? (current / max).clamp(0.0, 1.0) : 0;
    });
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateProgress);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        height: 3,
        child: LinearProgressIndicator(
          value: _progress,
          backgroundColor: Colors.transparent,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }
}
