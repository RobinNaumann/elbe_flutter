import 'dart:math' as math;

import 'package:elbe/elbe.dart';

/// a progress indicator that shows an animation.
/// Use this to indicate that the app is busy.
/// The spinner is a simple animation that shows a wave.
///
/// Use [kind] to set the color of the spinner.
class Spinner extends StatefulWidget {
  final ColorKinds kind;

  const Spinner({super.key, this.kind = ColorKinds.accent});

  @override
  createState() => _State();
}

class _State extends State<Spinner> with SingleTickerProviderStateMixin {
  late AnimationController ctrl;
  late Animation<double> anim;

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(duration: Duration(seconds: 1), vsync: this);
    anim = Tween<double>(begin: 0.0, end: 1.0).animate(ctrl);
    ctrl.repeat();
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = GeometryTheme.of(context).rem(2.2);
    final color =
        ColorTheme.of(context).activeSchemes.kind(widget.kind).safeMinor.front;
    return Center(
      child: AnimatedBuilder(
        animation: anim,
        builder: (context, child) => SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            size: Size.square(size),
            painter: _SpinnerPainter(anim.value, color),
          ),
        ),
      ),
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  final Color color;
  final double value;

  _SpinnerPainter(this.value, this.color);

  List<double> _makeCurve(double width) {
    final List<double> curve = [];
    final double frequency = 2 * math.pi;

    for (double x = 0; x <= width; x++) {
      final double y = math.sin(value * 2 * math.pi + x * frequency / width);
      curve.add(y);
    }
    return curve;
  }

  Path _makePath(List<double> curve, Size s, double yOffset,
      [double xMin = 0, double xMax = 1]) {
    final path = Path();
    bool isEmpty = true;
    for (int i = 0; i < curve.length; i++) {
      final y = (s.height * yOffset) + curve[i] * (s.height * .10);

      if (i < s.width * xMin || i > s.width * xMax) continue;

      if (isEmpty) {
        path.moveTo(i + 0.0, y);
        isEmpty = false;
        continue;
      }

      path.lineTo(i + 0.0, y);
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final curve = _makeCurve(size.width);

    final Paint wavePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.height * .1;

    final pMid = _makePath(curve, size, .5);
    final pBot = _makePath(curve, size, .8, .2, .6);
    final pTop = _makePath(curve, size, .2, .4, .8);

    canvas.drawPath(pMid, wavePaint);
    canvas.drawPath(pBot, wavePaint);
    canvas.drawPath(pTop, wavePaint);
  }

  @override
  bool shouldRepaint(oldDelegate) => true;
}
