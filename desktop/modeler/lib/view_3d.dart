import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vmath;
import 'package:vector_math/vector_math_64.dart' as vmath64;

class View3D extends StatefulWidget {
  const View3D({
    super.key,
  });

  @override
  State<View3D> createState() => _View3DState();
}

class _View3DState extends State<View3D> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  void _stopStartAnimation() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _stopStartAnimation,
      child: CustomPaint(
        painter: _View3DPainter(
          animation: _controller,
        ),
      ),
    );
  }
}

class _View3DPainter extends CustomPainter {
  final Animation<double> animation;

  static const double centerX = 200.0;
  static const double centerY = 200.0;

  vmath.Frustum f = vmath.Frustum();

  var rect = Rect.fromCenter(
    center: const Offset(centerX, centerY),
    width: 200,
    height: 200,
  );

  _View3DPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    // var aspectRatio = size.width / size.height;

    canvas.drawRect(
        rect,
        Paint()
          ..color = Colors.pink[300]!
          ..style = PaintingStyle.stroke);

    var v = animation.value * 50.0;

    canvas.drawLine(
      Offset(centerX, centerY + v),
      Offset(centerX + 100.0, centerY + v),
      Paint()..color = Colors.deepOrange,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return animation.value != (oldDelegate as _View3DPainter).animation.value;
  }

  vmath.Vector2 projection(vmath64.Vector3 point) {
    final viewMatrix = vmath64.makeViewMatrix(
      vmath64.Vector3(-10.0, 0.0, 0.0), // Position
      vmath64.Vector3.all(0.5), // Target
      vmath64.Vector3(1, 0, 0), // Up
    );

    // set the Frustum using perspective projection.

    double width = 640.0;
    double height = 480.0;
    double aspectRatio;
    if (width > height) {
      aspectRatio = width / height;
    } else {
      aspectRatio = height / width;
    }

    double fov = 45.0;
    double near = 1.0;
    double right = -near * tan((vmath.degrees2Radians * fov) / 2);
    double left = -right;
    double bottom = left / aspectRatio;
    double top = right / aspectRatio;

    double far = 100.0;

    final Matrix4 projectionMatrix = vmath64.makeFrustumMatrix(
      left,
      right,
      bottom,
      top,
      near,
      far,
    );

    final transformationMatrix = projectionMatrix * viewMatrix;

    //  w = 1 means transform a point NOT a vector.
    final projectiveCoords = vmath64.Vector4(point.x, point.y, point.z, 1.0);
    projectiveCoords.applyMatrix4(transformationMatrix);

    var x = projectiveCoords.x / projectiveCoords.w;
    var y = projectiveCoords.y / projectiveCoords.w;

    return vmath.Vector2(x, y);
  }
}
