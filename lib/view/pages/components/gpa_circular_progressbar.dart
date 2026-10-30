import 'package:flutter/material.dart';
import 'dart:math';
import 'package:gpa_calculator/core/theme/theme.dart';

class GPACircularProgressBar extends StatelessWidget {
  final double gpa;
  final double maxGpa;

  const GPACircularProgressBar({super.key, required this.gpa, this.maxGpa = 4.0});

  @override
  Widget build(BuildContext context) {
    final percentage = (gpa / maxGpa).clamp(0.0, 1.0);
    final gpaColor = _getGpaColor(gpa);

    return SizedBox(
      width: AppDimensions.progressIndicatorSize,
      height: AppDimensions.progressIndicatorSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Progress Painter
          CustomPaint(
            size: const Size(
              AppDimensions.progressIndicatorSize,
              AppDimensions.progressIndicatorSize,
            ),
            painter: CircularProgressPainter(
              percentage: percentage,
              backgroundColor: AppColors.surfaceVariant,
              progressColor: gpaColor,
              strokeWidth: AppDimensions.progressStrokeWidth,
            ),
            isComplex: true,
            willChange: false,
          ),
          // Center Content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'TOTAL CGPA',
                style: AppTextStyles.labelSmall,
              ),

              const SizedBox(height: AppDimensions.xxs),

              // GPA Value
              Text(
                gpa.toStringAsFixed(2),
                style: AppTextStyles.displayMedium,
              ),

              const SizedBox(height: AppDimensions.xs),

              // Row with status pill badge
              Container(
                decoration: AppDecorations.gpaStatusPill(gpaColor),
                padding: AppDimensions.paddingAllSm,
                child: Text(
                  _getGpaLabel(gpa),
                  style: TextStyle(
                    fontFamily: AppTextStyles.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: gpaColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getGpaColor(double gpa) {
    if (gpa >= 3.7) return AppColors.success;
    if (gpa >= 3.0) return AppColors.info;
    if (gpa >= 2.0) return AppColors.warning;
    return AppColors.error;
  }

  String _getGpaLabel(double gpa) {
    if (gpa >= 3.9) return 'Academic Excellence';
    if (gpa >= 3.5) return 'Consistent High Achiever';
    if (gpa >= 3.0) return 'On the Right Track';
    if (gpa >= 2.5) return 'Safe Zone';
    if (gpa >= 2.0) return 'Needs Improvement';
    return 'Needs a Strategic Pivot';
  }
}

// Custom Painter for the circular arc
class CircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;
  final double strokeWidth;

  CircularProgressPainter({
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc (starts from top = -pi/2)
    final sweepAngle = 2 * pi * percentage;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // start from top
      sweepAngle, // sweep clockwise
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) =>
      oldDelegate.percentage != percentage ||
      oldDelegate.progressColor != progressColor;
}
