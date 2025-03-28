import 'package:flutter/material.dart';

class FancySlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final String label;
  final ValueChanged<double> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final Color labelColor;

  const FancySlider({
    super.key,
    required this.value,
    this.min = 0.0,
    this.max = 100.0,
    required this.label,
    required this.onChanged,
    this.activeColor = Colors.greenAccent,
    this.inactiveColor = Colors.grey,
    this.thumbColor = Colors.white,
    this.labelColor = Colors.black87,
  });

  @override
  State<FancySlider> createState() => _FancySliderState();
}

class _FancySliderState extends State<FancySlider> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: widget.labelColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                  color: widget.activeColor.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .05),
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  "${widget.value.toInt()}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: widget.activeColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 8,
            trackShape: const RoundedRectSliderTrackShape(),
            activeTrackColor: widget.activeColor,
            inactiveTrackColor: widget.inactiveColor.withValues(alpha: .3),
            thumbShape: _CustomThumbShape(
              thumbRadius: 12,
              isDragging: _isDragging,
              color: widget.thumbColor,
              borderColor: widget.activeColor.withValues(alpha: .7),
              animation: _scaleAnimation,
            ),
            overlayColor: widget.activeColor.withValues(alpha: .2),
            thumbColor: widget.thumbColor,
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
          ),
          child: GestureDetector(
            onTapDown: (_) {
              setState(() {
                _isDragging = true;
              });
              _animationController.forward();
            },
            onTapUp: (_) {
              setState(() {
                _isDragging = false;
              });
              _animationController.reverse();
            },
            child: Slider(
              value: widget.value,
              min: widget.min,
              max: widget.max,
              onChanged: (value) {
                widget.onChanged(value);
              },
              onChangeStart: (_) {
                setState(() {
                  _isDragging = true;
                });
                _animationController.forward();
              },
              onChangeEnd: (_) {
                setState(() {
                  _isDragging = false;
                });
                _animationController.reverse();
              },
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         "${widget.min.toInt()}%",
        //         style: TextStyle(
        //           fontSize: 12,
        //           color: widget.labelColor.withValues(alpha: .7),
        //         ),
        //       ),
        //       Text(
        //         "${widget.max.toInt()}%",
        //         style: TextStyle(
        //           fontSize: 12,
        //           color: widget.labelColor.withValues(alpha: .7),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class _CustomThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final bool isDragging;
  final Color color;
  final Color borderColor;
  final Animation<double> animation;

  const _CustomThumbShape({
    required this.thumbRadius,
    required this.isDragging,
    required this.color,
    required this.borderColor,
    required this.animation,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    
    // Scale based on drag state
    final scale = isDragging ? animation.value : 1.0;
    
    // Draw shadow
    final shadowPaint = Paint()
      ..color = Colors.black26
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(center, thumbRadius * scale * .9, shadowPaint);
    
    // Draw border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(center, thumbRadius * scale, borderPaint);
    
    // Draw thumb
    final thumbPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius * scale - 2, thumbPaint);
    
    // Draw inner accent
    final accentPaint = Paint()
      ..color = borderColor.withValues(alpha: .3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius * scale * 0.5, accentPaint);
  }
}