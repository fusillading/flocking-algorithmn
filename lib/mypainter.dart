import 'dart:ui';
import 'dart:math';

import 'package:flocking/particle.dart';
import 'package:flutter/material.dart';

import 'my-painter-canvas.dart';

class MyPainter extends StatefulWidget {
  MyPainter({Key? key}) : super(key: key);

  @override
  _MyPainterState createState() => _MyPainterState();
}

Color getRandomColor(Random rgn){
  var a = rgn.nextInt(255);
  var r = rgn.nextInt(255);
  var g = rgn.nextInt(255);
  var b = rgn.nextInt(255);
  return Color.fromARGB(a, r, g, b);
}

double maxRadius = 5;
double maxSpeed = 1;
double maxTheta = 2.0 * pi;
int maxwidth = 5000;
int maxheight = 5000;

class _MyPainterState extends State<MyPainter>
    with SingleTickerProviderStateMixin{
  late List<Particle> particles;
  late Animation<double> animation;
  late AnimationController controller;
  Random rgn = Random(DateTime.now().millisecondsSinceEpoch);

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration : Duration(seconds: 10));
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
     ..addListener(() {
       setState(() {

       });
     })
     ..addStatusListener((status) {
      if (status == AnimationStatus.completed){
        controller.repeat();
      }
      else if (status == AnimationStatus.dismissed){
        controller.forward();
      }
    });

    controller.forward();

    this.particles = List<Particle>.generate(50, (index) {
      var p = Particle();
      p.color = getRandomColor(rgn);
      p.position = Offset(rgn.nextDouble() *maxwidth, rgn.nextDouble()*maxheight);
      p.speed  = (rgn.nextDouble()+1.0)/2*maxSpeed;
      p.theta = rgn.nextDouble() * maxTheta;
      p.radius = maxRadius;
      return p;
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
        body: CustomPaint(
            child: Container(), painter: MyPainterCanvas(rgn, particles, animation.value)));
  }
}