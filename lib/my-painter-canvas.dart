import 'dart:math';

import 'package:flocking/particle.dart';
import 'package:flutter/material.dart';

Offset PolarToCartestian(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}

double eyesight = 25000;

class MyPainterCanvas extends CustomPainter {
  List<Particle> particles;
  Random rgn;
  double animValue;
  MyPainterCanvas(this.rgn, this.particles, this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    // update the objects
    this.particles.forEach((p){
      var cnt = 0;
      var temp_position = Offset(0.0,0.0);
      Offset position = Offset(p.position.dx-size.width/2,size.height/2 - p.position.dy);
      for (var val in this.particles) {
        var distance = (val.position.dx-p.position.dx)*(val.position.dx-p.position.dx)+
            (val.position.dy-p.position.dy)*(val.position.dy-p.position.dy);
        if (distance > 0 && distance < eyesight) {
          Offset reposition = Offset(val.position.dx-size.width/2, size.height/2 - val.position.dy);
          temp_position += reposition;
          cnt++;
        }
      }
      temp_position = Offset(temp_position.dx/cnt, temp_position.dy/cnt);

      if (cnt >0) {
          p.theta = atan2(-(temp_position.dy-position.dy),(temp_position.dx-position.dx));

      }
      var velocity = PolarToCartestian(p.speed, p.theta);
      var dx = p.position.dx + velocity.dx;
      var dy = p.position.dy + velocity.dy;
      if (p.position.dx < 0){
        dx = size.width-10;
      }
      else if (p.position.dx > size.width){
        dx = 10;
      }
      if (p.position.dy < 0){
        dy = size.height-10;
      }
      else if (p.position.dy > size.height){
        dy = 10;
      }
      p.position = Offset(dx,dy);
    });
    double line_length = sqrt(eyesight);
    //paint the objects
    this.particles.forEach((p) {
      var paint = Paint();
      var paint2 = Paint();
      var paint3 = Paint();
      paint2.color = Colors.black12;
      paint.color = Colors.red;
      paint3.color  = Colors.blue;
      var line_factor = Offset(p.position.dx+cos(p.theta)*line_length, p.position.dy+sin(p.theta)*line_length);
      canvas.drawCircle(p.position, p.radius, paint);
      canvas.drawCircle(p.position, sqrt(eyesight), paint2);
      canvas.drawLine(p.position, line_factor, paint3);
    });
    /*
    var dx = size.width/2;
    var dy = size.height/2;
    var c = Offset(dx,dy);

    var radius = 100.0;
    var paint = Paint();
    paint.color = Colors.red;
    canvas.drawCircle(c, radius, paint);
    */
  }

  @override
  bool shouldRepaint(CustomPainter o) {
    return true;
  }
}
