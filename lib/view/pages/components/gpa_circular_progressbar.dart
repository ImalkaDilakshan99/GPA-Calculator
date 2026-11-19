import 'package:flutter/material.dart';
import 'dart:math';
import 'package:gpa_calculator/core/theme/theme.dart';

/// Helper model encapsulating dynamic colors and label for each GPA range.
class _GpaTheme {
  final Color arcColor;
  final Color pillBg;
  final Color pillBorder;
  final Color pillText;
  final String label;

  const _GpaTheme({
    required this.arcColor,
    required this.pillBg,
    required this.pillBorder,
    required this.pillText,
    required this.label,
  });
}

class GPACircularProgressBar extends StatelessWidget {
  final double gpa;
  final double maxGpa;

  const GPACircularProgressBar({super.key, required this.gpa, this.maxGpa = 4.0});

  @override
  Widget build(BuildContext context) {
    final percentage = (gpa / maxGpa).clamp(0.0, 1.0);
    final theme = _getGpaTheme(gpa, maxGpa);
    const trackColor = Color(0xFF1E2238); // Dark navy/slate track

    return SizedBox(
      width: 210,
      height: 210,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Progress Painter
          CustomPaint(
            size: const Size(210, 210),
            painter: CircularProgressPainter(
              percentage: percentage,
              backgroundColor: trackColor,
              progressColor: theme.arcColor,
              strokeWidth: 14.0,
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
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7A889B),
                  letterSpacing: 0.8,
                ),
              ),

              const SizedBox(height: 4),

              // GPA Value
              Text(
                gpa.toStringAsFixed(2),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -1.0,
                ),
              ),

              const SizedBox(height: 6),

              // Dynamic status pill badge with matching color theme
              Container(
                decoration: BoxDecoration(
                  color: theme.pillBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.pillBorder, width: 1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                child: Text(
                  theme.label,
                  style: TextStyle(
                    fontFamily: AppTextStyles.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.pillText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Returns dynamic colors and labels mapped to the GPA performance tier.
  static _GpaTheme _getGpaTheme(double gpa, double maxGpa) {
    if (gpa <= 0) {
      return const _GpaTheme(
        arcColor: Color(0xFF64748B),
        pillBg: Color(0xFF181C26),
        pillBorder: Color(0xFF2A3142),
        pillText: Color(0xFF94A3B8),
        label: 'No Grades Yet',
      );
    }

    final ratio = gpa / (maxGpa > 0 ? maxGpa : 4.0);

    if (ratio >= 0.925) {
      // 3.70 - 4.00 on a 4.0 scale: High Distinction (Emerald Green)
      return const _GpaTheme(
        arcColor: Color(0xFF10B981),
        pillBg: Color(0xFF0D2818),
        pillBorder: Color(0xFF134E2E),
        pillText: Color(0xFF34D399),
        label: 'High Distinction',
      );
    } else if (ratio >= 0.825) {
      // 3.30 - 3.69 on a 4.0 scale: Distinction (Electric Blue)
      return const _GpaTheme(
        arcColor: Color(0xFF2E5BFF),
        pillBg: Color(0xFF141D45),
        pillBorder: Color(0xFF1D2C6A),
        pillText: Color(0xFF3861FB),
        label: 'Distinction',
      );
    } else if (ratio >= 0.675) {
      // 2.70 - 3.29 on a 4.0 scale: Credit (Cyan / Aqua)
      return const _GpaTheme(
        arcColor: Color(0xFF06B6D4),
        pillBg: Color(0xFF082730),
        pillBorder: Color(0xFF0E4352),
        pillText: Color(0xFF22D3EE),
        label: 'Credit',
      );
    } else if (ratio >= 0.50) {
      // 2.00 - 2.69 on a 4.0 scale: Pass (Amber Orange)
      return const _GpaTheme(
        arcColor: Color(0xFFF59E0B),
        pillBg: Color(0xFF2A1C08),
        pillBorder: Color(0xFF54360B),
        pillText: Color(0xFFFBBF24),
        label: 'Pass',
      );
    } else {
      // < 2.00 on a 4.0 scale: Needs Improvement (Coral Red)
      return const _GpaTheme(
        arcColor: Color(0xFFEF4444),
        pillBg: Color(0xFF2B1012),
        pillBorder: Color(0xFF571D21),
        pillText: Color(0xFFF87171),
        label: 'Needs Improvement',
      );
    }
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
