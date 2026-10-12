import 'package:flutter/material.dart';

import '../controllers/onboarding_controller.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/animated_onboarding_buttons.dart';
import '../widgets/onboarding_indicator.dart';
import '../../../core/constants/app_colors.dart';

/// Main Onboarding Screen implementing responsive Figma-designed flow.
class OnboardingScreen extends StatefulWidget {
  final OnboardingController? controller;

  const OnboardingScreen({super.key, this.controller});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final OnboardingController _controller;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? OnboardingController();
    _pageController = PageController(initialPage: _controller.currentIndex);
    _controller.addListener(_onControllerUpdate);
  }

  void _onControllerUpdate() {
    if (mounted) {
      if (_pageController.hasClients &&
          _pageController.page?.round() != _controller.currentIndex) {
        _pageController.animateToPage(
          _controller.currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutCubic,
        );
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerUpdate);
    _pageController.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isCompact = mediaQuery.size.height < 700;

    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity != null) {
              if (details.primaryVelocity! < -100) {
                _controller.nextPage(context);
              } else if (details.primaryVelocity! > 100) {
                _controller.previousPage(context);
              }
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Size illustration relative to actual available height so
              // it also works correctly in the widget-test environment.
              final availableHeight = constraints.maxHeight;
              final imgHeight = availableHeight * (isCompact ? 0.55 : 0.62);
              return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. ILLUSTRATION — full-width, clipped at bottom (cutout look)
              ClipRect(
                child: SizedBox(
                  height: imgHeight,
                  width: constraints.maxWidth,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _controller.slides.length,
                    onPageChanged: _controller.onPageChanged,
                    itemBuilder: (context, index) {
                      final slide = _controller.slides[index];
                      return slide.imageAsset != null
                          ? Image.asset(
                              slide.imageAsset!,
                              width: constraints.maxWidth,
                              // Render taller than the box so it overflows and gets clipped
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.auto_stories_rounded,
                                size: 120,
                                color: Color(0xFFF5B800),
                              ),
                            )
                          : const Icon(
                              Icons.auto_stories_rounded,
                              size: 120,
                              color: Color(0xFFF5B800),
                            );
                    },
                  ),
                ),
              ),

              // 2. INDICATOR DOTS
              Padding(
                padding: EdgeInsets.only(
                  top: isCompact ? 18.0 : 26.0,
                  bottom: isCompact ? 14.0 : 20.0,
                ),
                child: OnboardingIndicator(
                  count: _controller.slides.length,
                  currentIndex: _controller.currentIndex,
                ),
              ),

              // 3. TEXT SECTION — shrink-wraps; overflow handled by SingleChildScrollView
              Expanded(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: OnboardingTextCard(
                      key: ValueKey(_controller.currentIndex),
                      slide: _controller.slides[_controller.currentIndex],
                    ),
                  ),
                ),
              ),

              // 4. BOTTOM CONTROLS (Skip and Next Buttons)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  28.0,
                  0,
                  28.0,
                  mediaQuery.padding.bottom > 0
                      ? mediaQuery.padding.bottom + 8.0
                      : (isCompact ? 20.0 : 36.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedSkipButton(
                      onTap: () => _controller.skip(context),
                    ),
                    AnimatedNextButton(
                      onTap: () => _controller.nextPage(context),
                      isLastPage: _controller.isLastPage,
                    ),
                  ],
                ),
              ),
            ],
          );
            },
          ),
        ),
      ),
    );
  }
}
