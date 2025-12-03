import 'package:flutter/material.dart';

class DColors {
  DColors._();

  // 🌑 Backgrounds
  static const Color background = Color(0xFF060606);
  static const Color secondaryBackground = Color(0xFF000000);
  static const Color sectionBackground = Color(0x14FF014F);

  // card background
  static const Color cardBackground = Color(0xFF1D1D1D);
  static const Color secondaryCard = Color(0xFF0F0F0F);

  // button Colors
  static const Color primaryButton = Color(0xFFFF014F);

  // border
  static const Color buttonBorder = Color(0xFFFF014F);
  static const Color cardBorder = Color(0x40FF014F);

  // 📝 Text
  static const Color textPrimary = Color(0xFFFAFAFA);
  static const Color textSecondary = Color(0xFF9F9F9F);

  // Service Page Specific Colors (Optional - eye-catching er jonno)
  static const Color serviceBlue = Color(0xFF3B82F6);
  static const Color servicePurple = Color(0xFF8B5CF6);
  static const Color serviceCyan = Color(0xFF06B6D4);
  static const Color serviceOrange = Color(0xFFFF6B35);
  static const Color servicePink = Color(0xFFEC4899);
  static const Color serviceGreen = Color(0xFF10B981);


  // 🖼️ Gradient Helper
  static const Gradient pinkGradient = LinearGradient(
    colors: [Color(0x90FF014F), Color(0xFF000000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient yearsCardGradient = LinearGradient(
    begin: Alignment(-0.2, -1.0),
    end: Alignment(0.2, 1.0),
    colors: [Color.fromRGBO(113, 9, 41, 0.15), Color.fromRGBO(65, 65, 65, 0.15)],
  );

  static const Gradient reviewsSectionGradient = LinearGradient(
    colors: [Color(0xFF0F0204), Color(0xFF180C0F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

}

class DiamondGradiantShape extends StatelessWidget {
  final double vector1Width;
  final double vector1Height;
  final double vector2Width;
  final double vector2Height;
  const DiamondGradiantShape({
    super.key,
    this.vector1Width = 530,
    this.vector1Height = 500,
    this.vector2Width = 440,
    this.vector2Height = 500,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // vector 1
          SizedBox(
            width: vector1Width,
            height: vector1Height,
            child: CustomPaint(
              painter: VectorTrapezoidPainter(
                gradient: const RadialGradient(
                  colors: [Color(0x33FF014F), Color(0x330F0F0F)],
                  center: Alignment.bottomCenter,
                  radius: 1.0,
                ),
              ),
            ),
          ),

          // vector 2
          SizedBox(
            width: vector2Width,
            height: vector2Height,
            child: CustomPaint(
              painter: VectorTrapezoidPainter(
                gradient: const RadialGradient(
                  colors: [Color(0x40FF014F), Color(0x40000000)],
                  center: Alignment.bottomCenter,
                  radius: 0.8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VectorTrapezoidPainter extends CustomPainter {
  final Gradient gradient;

  VectorTrapezoidPainter({required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path()
      ..moveTo(size.width * 0.05, 5)
      ..lineTo(size.width * 0.95, 0)
      ..lineTo(size.width * 0.80, size.height)
      ..lineTo(size.width * 0.20, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
