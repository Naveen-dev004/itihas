import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;

  const AuthTextField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }
  
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9), // very light warm white
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: _isFocused ? const Color(0xFFE59A22) : const Color(0xFFE7A83B).withOpacity(0.3), 
          width: _isFocused ? 1.5 : 1
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          // Circular icon container
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF8EA),
              shape: BoxShape.circle,
            ),
            child: Icon(widget.icon, color: const Color(0xFFE59A22), size: 22),
          ),
          const SizedBox(width: 16),
          
          // Texts
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 6),
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                obscureText: widget.isPassword ? _obscureText : false,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF151515),
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  labelText: widget.label,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B6B6B),
                    fontWeight: FontWeight.w500,
                  ),
                  floatingLabelStyle: const TextStyle(
                    fontSize: 12, // Becomes smaller when focused or filled
                    color: Color(0xFFE59A22),
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          
          // Eye icon for password
          if (widget.isPassword)
            IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: const Color(0xFF6B6B6B),
                size: 22,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            
          if (widget.isPassword) const SizedBox(width: 8),
        ],
      ),
    );
  }
}
