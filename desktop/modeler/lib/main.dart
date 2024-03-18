import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const NanoModelerApp());
}

class NanoModelerApp extends StatelessWidget {
  const NanoModelerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Nano Modeler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Nano Modeler'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: CustomPaint(
          painter: DemoPainter(Colors.lime),
          child: const SizedBox.expand(),
          // For painting on foreground
          // foregroundPainter: DemoPainter(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class DemoPainter extends CustomPainter {
  final Color rectColor;

  DemoPainter(this.rectColor);

  var rect = Rect.fromCenter(
    center: const Offset(250.0, 250.0),
    width: 200,
    height: 200,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        rect,
        Paint()
          ..color = rectColor
          ..style = PaintingStyle.stroke);

    canvas.drawLine(
      const Offset(10.0, 50.0),
      const Offset(100.0, 10.0),
      Paint()..color = Colors.deepOrange,
    );

    var vertices = Vertices(VertexMode.triangleStrip, [
      const Offset(100, 100),
      const Offset(200, 100),
      const Offset(350, 300),
      const Offset(400, 100),
      const Offset(500, 300),
      const Offset(700, 200),
    ]);

    canvas.drawVertices(
      vertices,
      BlendMode.plus,
      Paint()..color = Colors.blue[400]!,
    );

    canvas.drawPoints(
        PointMode.points,
        [
          const Offset(50, 50),
          // const Offset(50, 51),
          // const Offset(51, 51),
          // const Offset(51, 50),
        ],
        Paint()
          ..color = Colors.black
          ..strokeWidth = 1
          ..strokeCap = StrokeCap.square
          ..isAntiAlias = false);
  }

  @override
  bool shouldRepaint(covariant DemoPainter oldDelegate) {
    return rectColor != oldDelegate.rectColor;
  }
}
