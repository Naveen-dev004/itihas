import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../widgets/cinematic_transition_overlay.dart';

class AuthScreen extends StatefulWidget {
  final bool initialIsLogin;

  const AuthScreen({
    super.key,
    this.initialIsLogin = true,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool _isLogin;
  final AuthController _authController = AuthController();
  bool _isTransitioning = false;
  bool _obscurePassword = true;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isLogin = widget.initialIsLogin;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    if (_isTransitioning) return;
    setState(() => _isLogin = !_isLogin);
  }

  Future<void> _handleAuth() async {
    if (_authController.isLoading || _isTransitioning) return;
    final email = _emailController.text.trim().isEmpty
        ? 'test@example.com'
        : _emailController.text.trim();
    final password =
        _passwordController.text.isEmpty ? 'password' : _passwordController.text;
    bool success;
    if (_isLogin) {
      success = await _authController.login(email, password, context);
    } else {
      success = await _authController.createAccount(
        _nameController.text.isEmpty ? 'User' : _nameController.text,
        email, password, context,
      );
    }
    if (success && mounted) {
      if (_isLogin) {
        setState(() => _isTransitioning = true);
      } else {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final cardTop = screenHeight * 0.46;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              _isLogin
                  ? 'assets/images/temple_steps_entrance.png'
                  : 'assets/images/signup_illustration.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: const Color(0xFFD4A84B)),
            ),
          ),
          AnimatedOpacity(
            opacity: _isTransitioning ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: cardTop),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(minHeight: screenHeight - cardTop),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFEF9EF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                    ),
                    child: Column(
                      children: [
                        const _ArchNotch(),
                        Text(
                          _isLogin ? 'Welcome Back' : 'Create Account',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF3B1F00),
                            letterSpacing: 0.2,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const _LotusDivider(),
                        const SizedBox(height: 22),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              if (!_isLogin) ...[
                                _AuthField(
                                  controller: _nameController,
                                  hint: 'Full Name',
                                  icon: Icons.person_outline_rounded,
                                ),
                                const SizedBox(height: 12),
                              ],
                              _AuthField(
                                controller: _emailController,
                                hint: 'loremipsum@gmail.com',
                                icon: Icons.mail_outline_rounded,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 12),
                              _AuthField(
                                controller: _passwordController,
                                hint: '...........',
                                icon: Icons.lock_outline_rounded,
                                obscureText: _obscurePassword,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: const Color(0xFF9E8C6A),
                                    size: 22,
                                  ),
                                  onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword,
                                  ),
                                ),
                              ),
                              if (_isLogin) ...[
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color: Color(0xFFD4870A),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 20),
                              _GoldenButton(
                                label: _isLogin ? 'Login' : 'Create Account',
                                onTap: _handleAuth,
                              ),
                              const SizedBox(height: 24),
                              const _OrDivider(),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _SocialButton(
                                    onTap: () {},
                                    child: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg',
                                      width: 26,
                                      height: 26,
                                      errorBuilder: (context, error, stackTrace) => const Text(
                                        'G',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Color(0xFF4285F4),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  _SocialButton(
                                    onTap: () {},
                                    child: const Icon(Icons.apple, size: 30, color: Color(0xFF1D1D1F)),
                                  ),
                                  const SizedBox(width: 20),
                                  _SocialButton(
                                    onTap: () {},
                                    child: const Icon(Icons.facebook, size: 28, color: Color(0xFF1877F2)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _isLogin
                                        ? "Don't have an account? "
                                        : 'Already have an account? ',
                                    style: const TextStyle(color: Color(0xFF6B5B3E), fontSize: 14),
                                  ),
                                  GestureDetector(
                                    onTap: _toggleAuthMode,
                                    child: Text(
                                      _isLogin ? 'Sign Up' : 'Login',
                                      style: const TextStyle(
                                        color: Color(0xFFD4870A),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: mediaQuery.padding.bottom + 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isTransitioning)
            Positioned.fill(
              child: CinematicTransitionOverlay(
                entranceAsset: 'assets/images/temple_steps_entrance.png',
                welcomeAsset: 'assets/images/itihasa_welcome.jpg',
                onTransitionComplete: () {
                  if (mounted) Navigator.of(context).pushReplacementNamed('/home');
                },
              ),
            ),
        ],
      ),
    );
  }
}

// ── ARCH NOTCH ────────────────────────────────────────────────────────────────
class _ArchNotch extends StatelessWidget {
  const _ArchNotch();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: CustomPaint(painter: _ArchPainter()),
    );
  }
}

class _ArchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = const Color(0xFFD4A030)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final fill = Paint()
      ..color = const Color(0xFFD4A030)
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    const topY = 12.0;

    final arch = Path()
      ..moveTo(cx - 32, topY + 26)
      ..lineTo(cx - 32, topY + 13)
      ..quadraticBezierTo(cx - 32, topY, cx, topY)
      ..quadraticBezierTo(cx + 32, topY, cx + 32, topY + 13)
      ..lineTo(cx + 32, topY + 26);
    canvas.drawPath(arch, stroke);

    // Lotus petals above arch
    const ly = topY - 5;
    const r = 5.0;
    final bloom = Path();
    bloom.addOval(Rect.fromCenter(center: Offset(cx, ly - r * 0.5), width: r * 1.8, height: r * 3.0));
    bloom.addOval(Rect.fromCenter(center: Offset(cx - r, ly + 1), width: r * 1.5, height: r * 2.4));
    bloom.addOval(Rect.fromCenter(center: Offset(cx + r, ly + 1), width: r * 1.5, height: r * 2.4));
    canvas.drawPath(bloom, fill);
  }
  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

// ── LOTUS DIVIDER ─────────────────────────────────────────────────────────────
class _LotusDivider extends StatelessWidget {
  const _LotusDivider();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 48, height: 1, color: const Color(0xFFD4A030)),
        const SizedBox(width: 8),
        const Icon(Icons.diamond_outlined, size: 7, color: Color(0xFFD4A030)),
        const SizedBox(width: 6),
        const Icon(Icons.spa, size: 15, color: Color(0xFFD4A030)),
        const SizedBox(width: 6),
        const Icon(Icons.diamond_outlined, size: 7, color: Color(0xFFD4A030)),
        const SizedBox(width: 8),
        Container(width: 48, height: 1, color: const Color(0xFFD4A030)),
      ],
    );
  }
}

// ── AUTH FIELD ────────────────────────────────────────────────────────────────
class _AuthField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const _AuthField({
    this.controller,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDD0B3), width: 1.2),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(icon, size: 22, color: const Color(0xFF7A6845)),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(fontSize: 15, color: Color(0xFF2C1A00), fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Color(0xFF9E8C6A), fontSize: 15),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
          if (suffixIcon != null) ...[
            suffixIcon!,
            const SizedBox(width: 4),
          ],
        ],
      ),
    );
  }
}

// ── GOLDEN BUTTON ─────────────────────────────────────────────────────────────
class _GoldenButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _GoldenButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFCB2B), Color(0xFFE8960A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE8960A).withValues(alpha: 0.38),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF2C1A00), letterSpacing: 0.3),
          ),
        ),
      ),
    );
  }
}

// ── OR DIVIDER ────────────────────────────────────────────────────────────────
class _OrDivider extends StatelessWidget {
  const _OrDivider();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: const Color(0xFFE2D5BB))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: const [
              Icon(Icons.fiber_manual_record, size: 5, color: Color(0xFFD4A030)),
              SizedBox(width: 7),
              Text('Or', style: TextStyle(color: Color(0xFF6B5B3E), fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(width: 7),
              Icon(Icons.fiber_manual_record, size: 5, color: Color(0xFFD4A030)),
            ],
          ),
        ),
        Expanded(child: Container(height: 1, color: const Color(0xFFE2D5BB))),
      ],
    );
  }
}

// ── SOCIAL BUTTON ─────────────────────────────────────────────────────────────
class _SocialButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const _SocialButton({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2D5BB), width: 1.2),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}
