import 'package:flutter/material.dart';
import 'dart:math';

class GPACircularProgressBar extends StatelessWidget {
  final double gpa;
  final double maxGpa;

  const GPACircularProgressBar({Key? key, required this.gpa, this.maxGpa = 4.0})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage = gpa / maxGpa;

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Progress Painter
          CustomPaint(
            size: const Size(200, 200),
            painter: CircularProgressPainter(
              percentage: percentage,
              backgroundColor: Colors.grey.shade200,
              progressColor: _getGpaColor(gpa),
              strokeWidth: 16,
            ),
            isComplex: true,
            willChange: false,
          ),
          // Center Content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // GPA Value
              Text(
                gpa.toStringAsFixed(2),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              // Row with icon + label
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 4),
                  Container(
                    decoration: BoxDecoration(
                      color: _getGpaColor(gpa).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _getGpaColor(gpa).withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      _getGpaLabel(gpa),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _getGpaColor(gpa),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'out of $maxGpa',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getGpaColor(double gpa) {
    if (gpa >= 3.7) return Colors.green;
    if (gpa >= 3.0) return Colors.blue;
    if (gpa >= 2.0) return Colors.orange;
    return Colors.red;
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
