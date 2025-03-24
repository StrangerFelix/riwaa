import 'package:flutter/material.dart';
import 'package:riwaa/core/utilities/constants.dart';
class FancyProgressBar extends StatelessWidget {
  final double progress; // Progress from 0.0 to 1.0
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final List<Color> progressGradient;
  final bool showPercentage;
  final TextStyle percentageTextStyle;
  final bool animate;
  final Duration animationDuration;
  final Widget? leadingIcon;
  final bool showGlowEffect;

  const FancyProgressBar({
    super.key,
    required this.progress,
    this.height = 30.0,
    this.borderRadius = 12.0,
    this.backgroundColor = const Color(0xFFDDDDDD),
    // this.progressGradient = const [ kPrimaryColor,Color(0xFF6FE08D)],
    this.progressGradient = const [ Color(0xFF6FE08D),kPrimaryColor],
    // this.progressGradient = const [Color(0xFF61CAFC), Color(0xFF6FE08D)],
    this.showPercentage = true,
    this.percentageTextStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12.0,
    ),
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.leadingIcon,
    this.showGlowEffect = true,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: height,
          child: Stack(
            children: [
              // Background
              Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 1,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
              
              // Progress indicator
              AnimatedContainer(
                duration: animate ? animationDuration : Duration.zero,
                width: clampedProgress * MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  gradient: LinearGradient(
                    colors: progressGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: showGlowEffect ? [
                    BoxShadow(
                      color: progressGradient.last.withValues(alpha: 0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 0),
                    ),
                  ] : null,
                ),
                child: Stack(
                  children: [
                    // Simple reflection effect (optional)
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white, Colors.white],
                              stops: [0.0, 0.5],
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // Percentage text
                    if (showPercentage && clampedProgress >= 0.1)
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              '${(clampedProgress * 100).toInt()}%',
                              style: percentageTextStyle,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              // Leading icon (optional)
              if (leadingIcon != null)
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(child: leadingIcon),
                ),
            ],
          ),
        ),
      ],
    );
  }
}