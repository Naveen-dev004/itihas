import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/onboarding_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class AnimatedOnboardingCards extends StatefulWidget {
  final int currentIndex;
  final List<OnboardingModel> slides;
  final ValueNotifier<bool> isBackButtonPressed;

  const AnimatedOnboardingCards({
    super.key,
    required this.currentIndex,
    required this.slides,
    required this.isBackButtonPressed,
  });

  @override
  State<AnimatedOnboardingCards> createState() =>
      _AnimatedOnboardingCardsState();
}

class _AnimatedOnboardingCardsState extends State<AnimatedOnboardingCards>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _oldIndex = 0;

  @override
  void initState() {
    super.initState();
    _oldIndex = widget.currentIndex;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedOnboardingCards oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _oldIndex = oldWidget.currentIndex;
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.isBackButtonPressed,
      builder: (context, isPressed, _) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            double t = _animationController.value;

            List<_CardRenderData> renderData = [];

            // We have exactly 3 slides
            for (int i = 0; i < widget.slides.length; i++) {
              // Calculate logical position for this card at oldIndex and currentIndex
              int posOld =
                  (i - _oldIndex + widget.slides.length) % widget.slides.length;
              int posNew =
                  (i - widget.currentIndex + widget.slides.length) %
                  widget.slides.length;

              _CardTransform state = _getInterpolatedTransform(
                posOld,
                posNew,
                t,
                isPressed,
              );

              final matrix = Matrix4.identity()
                ..translate(state.x, state.y, 0.0)
                ..rotateZ(state.rotation)
                ..scale(state.scale, state.scale, 1.0);

              renderData.add(
                _CardRenderData(
                  index: i,
                  zIndex: state.zIndex,
                  widget: Opacity(
                    opacity: state.opacity,
                    child: Transform(
                      transform: matrix,
                      alignment: Alignment.center, // EXACT SAME CENTER ANCHOR
                      child: _buildCardImage(context, widget.slides[i]),
                    ),
                  ),
                ),
              );
            }

            // Sort by zIndex so the lowest zIndex renders first (at the back)
            renderData.sort((a, b) => a.zIndex.compareTo(b.zIndex));

            return ClipRect(
              child: Stack(
                alignment: Alignment.center, // STACK CENTERED
                children: renderData.map((e) => e.widget).toList(),
              ),
            );
          },
        );
      },
    );
  }

  _CardTransform _getInterpolatedTransform(
    int posOld,
    int posNew,
    double t,
    bool isPressed,
  ) {
    final start = _getStaticTransform(posOld, isPressed && posOld == 0);
    final end = _getStaticTransform(posNew, isPressed && posNew == 0);

    if (t == 0.0) return start;
    if (t == 1.0 || posOld == posNew) return end;

    // Linear interpolation for all base properties
    final current = _CardTransform.lerp(start, end, t);

    // For the sweeping out-of-bounds animations (Front <-> Back)
    if (posOld == 0 && posNew == 2) {
      // Forward Swipe: Front -> Back
      // Swings outward and upward, rotating slightly, dropping behind
      final sweepX = math.sin(t * math.pi) * 200.0;
      final sweepY = math.sin(t * math.pi) * -150.0; 
      final sweepRot = math.sin(t * math.pi) * 0.2;
      return _CardTransform(
        x: current.x + sweepX,
        y: current.y + sweepY,
        scale: current.scale,
        rotation: current.rotation + sweepRot,
        zIndex: t < 0.5 ? 4.0 : 0.0,
        opacity: current.opacity,
      );
    } else if (posOld == 2 && posNew == 0) {
      // Backward Swipe: Back -> Front
      // Swings outward and upward to come from behind
      final sweepX = math.sin(t * math.pi) * 200.0;
      final sweepY = math.sin(t * math.pi) * -150.0;
      final sweepRot = math.sin(t * math.pi) * 0.2;
      return _CardTransform(
        x: current.x + sweepX,
        y: current.y + sweepY,
        scale: current.scale,
        rotation: current.rotation + sweepRot,
        zIndex: t < 0.5 ? 0.0 : 4.0,
        opacity: current.opacity,
      );
    }

    // Default: linear interpolation works perfectly for 1->0, 2->1, 0->1, 1->2
    return current;
  }

  _CardTransform _getStaticTransform(int pos, bool isPressed) {
    double x = 0.0, y = 0.0, scale = 1.0, rotation = 0.0, zIndex = 0.0;
    
    // Exact positions to maintain consistency across pages
    if (pos == 0) {
      // FRONT
      y = 0.0;
      scale = 1.0;
      rotation = 0.0;
      zIndex = 3.0;
    } else if (pos == 1) {
      // MIDDLE
      y = 30.0;
      scale = 0.95;
      rotation = -0.1;
      zIndex = 2.0;
    } else {
      // BACK
      y = 60.0;
      scale = 0.90;
      rotation = -0.2;
      zIndex = 1.0;
    }

    if (isPressed && pos == 0) {
      scale *= 0.96;
    }

    return _CardTransform(
      x: x,
      y: y,
      scale: scale,
      rotation: rotation,
      zIndex: zIndex,
      opacity: 1.0,
    );
  }

  Widget _buildCardImage(BuildContext context, OnboardingModel slide) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge,
      ),
      child: AspectRatio(
        aspectRatio: 0.75, // Fixed 3:4 aspect ratio box for every card
        child: Center( // Center the actual image inside the fixed box
          child: slide.imageAsset != null
              ? Image.asset(
                  slide.imageAsset!,
                  fit: BoxFit.contain, // Fits intrinsically without stretching
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.auto_stories_rounded,
                      size: 100,
                      color: AppColors.primary.withValues(alpha: 0.5),
                    );
                  },
                )
              : Icon(
                  Icons.auto_stories_rounded,
                  size: 100,
                  color: AppColors.primary.withValues(alpha: 0.5),
                ),
        ),
      ),
    );
  }
}

class _CardRenderData {
  final int index;
  final double zIndex;
  final Widget widget;

  _CardRenderData({
    required this.index,
    required this.zIndex,
    required this.widget,
  });
}

class _CardTransform {
  final double x;
  final double y;
  final double scale;
  final double rotation;
  final double zIndex;
  final double opacity;

  const _CardTransform({
    required this.x,
    required this.y,
    required this.scale,
    required this.rotation,
    required this.zIndex,
    required this.opacity,
  });

  static _CardTransform lerp(_CardTransform a, _CardTransform b, double t) {
    return _CardTransform(
      x: a.x + (b.x - a.x) * t,
      y: a.y + (b.y - a.y) * t,
      scale: a.scale + (b.scale - a.scale) * t,
      rotation: a.rotation + (b.rotation - a.rotation) * t,
      zIndex: a.zIndex + (b.zIndex - a.zIndex) * t,
      opacity: a.opacity + (b.opacity - a.opacity) * t,
    );
  }
}
