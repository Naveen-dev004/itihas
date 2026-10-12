import 'package:flutter/material.dart';

class CinematicTransitionOverlay extends StatefulWidget {
  final VoidCallback onTransitionComplete;
  final String entranceAsset;
  final String welcomeAsset;
  final String? backgroundAsset; // For backward compatibility

  const CinematicTransitionOverlay({
    super.key,
    required this.onTransitionComplete,
    this.entranceAsset = 'assets/images/temple_steps_entrance.png',
    this.welcomeAsset = 'assets/images/itihasa_welcome.jpg',
    this.backgroundAsset,
  });

  @override
  State<CinematicTransitionOverlay> createState() =>
      _CinematicTransitionOverlayState();
}

class _CinematicTransitionOverlayState
    extends State<CinematicTransitionOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Zooming through the entrance doorway
  late Animation<double> _doorScale;
  late Animation<double> _doorOpacity;

  // Continuous walking momentum towards the temple in the welcome scene
  late Animation<double> _welcomeScale;

  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    );

    // 1. Entrance doors zoom (1.0 -> 3.8) focused on the doorway passage
    _doorScale = Tween<double>(begin: 1.0, end: 3.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.60, curve: Curves.easeInOutCubic),
      ),
    );

    // 2. Doorway seamlessly dissolves as the doors open and pass the camera
    _doorOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.30, 0.55, curve: Curves.easeInOut),
      ),
    );

    // 3. Welcome temple scene is underneath and continuously glides forward
    _welcomeScale = Tween<double>(begin: 1.0, end: 1.14).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 1.0, curve: Curves.easeOutQuad),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _finish();
      }
    });

    _controller.forward();
  }

  void _finish() {
    if (!_completed) {
      _completed = true;
      widget.onTransitionComplete();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeEntranceAsset =
        widget.backgroundAsset ?? widget.entranceAsset;

    return GestureDetector(
      onTap: _finish, // Tap anytime to proceed immediately
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // -------------------------------------------------------------
              // DESTINATION: ITIHASA WELCOME TEMPLE SCENE (itihasa_welcome.jpg)
              // Steadily moving forward towards the temple
              // -------------------------------------------------------------
              Positioned.fill(
                child: Transform.scale(
                  scale: _welcomeScale.value,
                  alignment: const Alignment(0.0, 0.08), // Towards the temple mandir
                  child: Image.asset(
                    widget.welcomeAsset,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ),

              // -------------------------------------------------------------
              // ENTRANCE DOORS ZOOM & SEAMLESS DISSOLVE (temple_steps_entrance.png)
              // Camera pushes through the door frame into the temple grounds
              // -------------------------------------------------------------
              if (_doorOpacity.value > 0.0)
                Positioned.fill(
                  child: Opacity(
                    opacity: _doorOpacity.value,
                    child: Transform.scale(
                      scale: _doorScale.value,
                      alignment: const Alignment(0.0, -0.42), // Arched doorway above steps
                      child: Image.asset(
                        activeEntranceAsset,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
