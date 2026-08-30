import 'package:flutter/material.dart';

class VoiceButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isListening;

  const VoiceButton({
    Key? key,
    required this.onPressed,
    required this.isListening,
  }) : super(key: key);

  @override
  State<VoiceButton> createState() => _VoiceButtonState();
}

class _VoiceButtonState extends State<VoiceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(VoiceButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isListening && !_animationController.isAnimating) {
      _animationController.repeat();
    } else if (!widget.isListening && _animationController.isAnimating) {
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      ),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isListening ? Colors.blue.shade700 : Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            widget.isListening ? Icons.mic : Icons.mic_none,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
