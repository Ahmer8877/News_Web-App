import 'dart:math';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback? onFinished;
  const SplashScreen({super.key, this.onFinished});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  //  Controllers
  late AnimationController _globeController;
  late AnimationController _radarController;
  late AnimationController _staggerController;
  late AnimationController _tickerController;
  late AnimationController _exitController;

  //Globe pulse
  late Animation<double> _globeScale;
  late Animation<double> _globeOpacity;

  //Radar sweep
  late Animation<double> _radarRotation;
  late Animation<double> _radarOpacity;

  // Staggered text
  late Animation<double> _breakingFade;
  late Animation<Offset> _breakingSlide;
  late Animation<double> _titleFade;
  late Animation<double> _titleScale;
  late Animation<double> _subtitleFade;
  late Animation<double> _dividerWidth;

  // Ticker
  late Animation<double> _tickerOffset;

  //  Exit
  late Animation<double> _exitFade;

  final List<String> _headlines = [
    '  🔴 BREAKING: Markets surge to record highs   •   ',
    '  🌍 World Leaders Gather for Climate Summit   •   ',
    '  🚀 SpaceX launches next-gen satellite fleet   •   ',
    '  💡 Tech Giants reveal AI breakthroughs   •   ',
    '  🏆 Sports: Championship finals this weekend   •   ',
  ];

  @override
  void initState() {
    super.initState();

    // Globe controller
    _globeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _globeScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _globeController, curve: Curves.elasticOut),
    );
    _globeOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _globeController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // Radar controller (infinite rotation)
    _radarController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _radarRotation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _radarController, curve: Curves.linear),
    );
    _radarOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _radarController, curve: const Interval(0, 0.2)),
    );

    // Stagger controller
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _breakingFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );
    _breakingSlide =
        Tween<Offset>(begin: const Offset(-0.5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _staggerController,
            curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
          ),
        );
    _dividerWidth = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: const Interval(0.25, 0.55, curve: Curves.easeOut),
      ),
    );
    _titleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: const Interval(0.35, 0.65, curve: Curves.easeOut),
      ),
    );
    _titleScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: const Interval(0.35, 0.7, curve: Curves.easeOut),
      ),
    );
    _subtitleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: const Interval(0.6, 0.9, curve: Curves.easeOut),
      ),
    );

    // Ticker controller (infinite scroll)
    _tickerController = AnimationController(
      duration: const Duration(seconds: 18),
      vsync: this,
    )..repeat();
    _tickerOffset = Tween<double>(begin: 1.0, end: -5.0).animate(
      CurvedAnimation(parent: _tickerController, curve: Curves.linear),
    );

    // Exit controller
    _exitController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeIn),
    );

    _startSequence();
  }

  Future<void> _startSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _globeController.forward();
    await Future.delayed(const Duration(milliseconds: 600));
    _staggerController.forward();
    await Future.delayed(const Duration(milliseconds: 3200));
    await _exitController.forward();
    widget.onFinished?.call();
  }

  @override
  void dispose() {
    _globeController.dispose();
    _radarController.dispose();
    _staggerController.dispose();
    _tickerController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FadeTransition(
      opacity: _exitFade,
      child: Scaffold(
        backgroundColor:  Colors.deepOrangeAccent,
        body: Stack(
          children: [
            // Background grid
            CustomPaint(
              size: size,
              painter: _GridPainter(),
            ),

            // Main content
            Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Globe + Radar
                      AnimatedBuilder(
                        animation: Listenable.merge(
                            [_globeController, _radarController]),
                        builder: (context, _) {
                          return Opacity(
                            opacity: _globeOpacity.value,
                            child: Transform.scale(
                              scale: _globeScale.value,
                              child: SizedBox(
                                width: 160,
                                height: 160,
                                child: CustomPaint(
                                  painter: _GlobeRadarPainter(
                                    radarAngle: _radarRotation.value,
                                    radarOpacity: _radarOpacity.value,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 32),

                      // BREAKING NEWS tag
                      AnimatedBuilder(
                        animation: _staggerController,
                        builder: (context, _) {
                          return SlideTransition(
                            position: _breakingSlide,
                            child: Opacity(
                              opacity: _breakingFade.value,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE63946),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: const Text(
                                  'BREAKING NEWS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 3.5,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 14),

                      // Divider line
                      AnimatedBuilder(
                        animation: _staggerController,
                        builder: (context, _) {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 280 * _dividerWidth.value,
                              height: 1.5,
                              color: const Color(0xFFE63946),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 18),

                      // App title
                      AnimatedBuilder(
                        animation: _staggerController,
                        builder: (context, _) {
                          return Opacity(
                            opacity: _titleFade.value,
                            child: Transform.scale(
                              scale: _titleScale.value,
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'APNI',
                                      style: TextStyle(
                                        fontSize: 52,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        letterSpacing: -1,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'WAVE',
                                      style: TextStyle(
                                        fontSize: 52,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFFE63946),
                                        letterSpacing: -1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      // Subtitle
                      AnimatedBuilder(
                        animation: _staggerController,
                        builder: (context, _) {
                          return Opacity(
                            opacity: _subtitleFade.value,
                            child: const Text(
                              'Stay Informed. Stay Ahead.',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Bottom ticker
                AnimatedBuilder(
                  animation: _staggerController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _subtitleFade.value,
                      child: child,
                    );
                  },
                  child: Container(
                    height: 40,
                    color: const Color(0xFFE63946),
                    child: Row(
                      children: [
                        // LIVE badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          color: Colors.black,
                          height: double.infinity,
                          child: const Center(
                            child: Row(
                              children: [
                                _PulsingDot(),
                                SizedBox(width: 6),
                                Text(
                                  'LIVE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Scrolling ticker
                        Expanded(
                          child: ClipRect(
                            child: AnimatedBuilder(
                              animation: _tickerController,
                              builder: (context, _) {
                                return FractionalTranslation(
                                  translation:
                                  Offset(_tickerOffset.value, 0),
                                  child: Text(
                                    _headlines.join(''),
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Pulsing red dot
class _PulsingDot extends StatefulWidget {
  const _PulsingDot();
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this)
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Color(0xFFE63946),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// Globe + Radar Painter
class _GlobeRadarPainter extends CustomPainter {
  final double radarAngle;
  final double radarOpacity;

  _GlobeRadarPainter({required this.radarAngle, required this.radarOpacity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Outer glow
    final glowPaint = Paint()
      ..color = const Color(0xFFE63946).withOpacity(0.12)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24);
    canvas.drawCircle(center, radius + 18, glowPaint);

    // Globe background
    final bgPaint = Paint()
      ..color = const Color(0xFF12121C)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, bgPaint);

    // Latitude lines
    final latPaint = Paint()
      ..color = const Color(0xFF2A2A3E)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    for (int i = 1; i <= 4; i++) {
      final y = center.dy - radius + (i * radius * 2 / 5);
      final halfW = sqrt(max(0, radius * radius - pow(y - center.dy, 2)));
      canvas.drawArc(
        Rect.fromCenter(
            center: Offset(center.dx, y), width: halfW * 2, height: 10),
        0,
        pi,
        false,
        latPaint,
      );
      canvas.drawArc(
        Rect.fromCenter(
            center: Offset(center.dx, y), width: halfW * 2, height: 10),
        pi,
        pi,
        false,
        latPaint,
      );
    }

    // Longitude lines (vertical ellipses)
    for (int i = 0; i < 5; i++) {
      final angle = i * pi / 5;
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);
      canvas.drawOval(
        Rect.fromCenter(
            center: Offset.zero, width: radius * 0.5, height: radius * 2),
        latPaint,
      );
      canvas.restore();
    }

    // Globe border
    final borderPaint = Paint()
      ..color = const Color(0xFF3A3A5C)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, borderPaint);

    // Radar sweep gradient
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        colors: [
          Colors.transparent,
          const Color(0xFFE63946).withOpacity(0.0),
          const Color(0xFFE63946).withOpacity(0.5 * radarOpacity),
          const Color(0xFFE63946).withOpacity(0.15 * radarOpacity),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 0.75, 0.9, 1.0],
        transform: GradientRotation(radarAngle),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));
    canvas.drawRect(Rect.fromCenter(center: center, width: size.width, height: size.height), sweepPaint);
    canvas.restore();

    // Radar line
    final radarLinePaint = Paint()
      ..color = const Color(0xFFE63946).withOpacity(0.9 * radarOpacity)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      center,
      Offset(center.dx + cos(radarAngle) * radius,
          center.dy + sin(radarAngle) * radius),
      radarLinePaint,
    );

    // Concentric range rings
    final ringPaint = Paint()
      ..color = const Color(0xFFE63946).withOpacity(0.15)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;
    for (final r in [radius * 0.33, radius * 0.66]) {
      canvas.drawCircle(center, r, ringPaint);
    }

    // Center dot
    canvas.drawCircle(
      center,
      4,
      Paint()..color = const Color(0xFFE63946),
    );
  }

  @override
  bool shouldRepaint(_GlobeRadarPainter old) =>
      old.radarAngle != radarAngle || old.radarOpacity != radarOpacity;
}

// Background grid painter
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1A2E).withOpacity(0.6)
      ..strokeWidth = 0.5;
    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => false;
}