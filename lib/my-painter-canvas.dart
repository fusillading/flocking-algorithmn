import 'dart:math';

import 'package:flocking/particle.dart';
import 'package:flutter/material.dart';

import 'direction-decision.dart';

double eyesight = 25000;
double crowd = 250;
double theta_coefficient = 100;
double seperation_coefficient = 15;
double alignment_coefficient = 100;
double cohesion_coefficient = 10;

Offset PolarToCartestian(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}
Offset PolarToCartestian2(double speed, double seperation, double alignment, double cohesion, double theta){
  Offset factor = Offset(seperation_coefficient*cos(seperation)
      + alignment_coefficient*cos(alignment)
      + cohesion_coefficient*cos(cohesion)
      + theta_coefficient*cos(theta),
      seperation_coefficient*sin(seperation)
      + alignment_coefficient*sin(alignment)
      + cohesion_coefficient*sin(cohesion)
      + theta_coefficient*sin(theta));

  return Offset(speed*factor.dx/(seperation_coefficient+alignment_coefficient+cohesion_coefficient+theta_coefficient)
  ,speed*factor.dy/(seperation_coefficient+alignment_coefficient+cohesion_coefficient+theta_coefficient));
}



class MyPainterCanvas extends CustomPainter {
  List<Particle> particles;
  Random rgn;
  double animValue;
  MyPainterCanvas(this.rgn, this.particles, this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    // update the objects
    this.particles.forEach((p){
      //direction decision part
      var cohesion_cnt = 0;
      var seperation_cnt = 0;
      var alignment_cnt = 0;
      var cohesion_position = Offset(0.0, 0.0);
      var seperation_position = Offset(0.0, 0.0);
      var alignment_theta = 0.0;
      Offset position = Offset(p.position.dx - size.width / 2, size.height / 2 - p.position.dy);

      for (var val in this.particles) {
        Offset val_position = Offset(val.position.dx - size.width / 2, size.height/2 - val.position.dy);
        double distance = (val_position.dx-position.dx)*(val_position.dx-position.dx)+
            (val_position.dy-position.dy)*(val_position.dy-position.dy);
        if (distance > 0 && distance < eyesight) {
          cohesion_position += val_position;
          cohesion_cnt++;
          alignment_theta += val.theta;
          alignment_cnt++;
        }
        if (distance > 0 && distance < crowd){
          seperation_position += val_position;
          seperation_cnt++;
          //seperation_coefficient += 1/(sqrt(distance)*20);
        }
      }
      if (cohesion_cnt > 0) {
        cohesion_position = Offset(cohesion_position.dx / cohesion_cnt,
            cohesion_position.dy / cohesion_cnt);
      }
      if (seperation_cnt > 0){
        seperation_position = Offset(seperation_position.dx/seperation_cnt,
            seperation_position.dy/seperation_cnt);
      }
      if (alignment_cnt > 0){
        alignment_theta = alignment_theta/alignment_cnt;
      }
      var cohesion_theta = atan2(-(cohesion_position.dy - position.dy),
          (cohesion_position.dx - position.dx));
      var seperation_theta = atan2(seperation_position.dy - position.dy,
          seperation_position.dx - position.dx);

      var velocity = PolarToCartestian(p.speed, p.theta);
      if (cohesion_cnt > 0 || seperation_cnt > 0 || alignment_cnt >0) {
        velocity = PolarToCartestian2(p.speed, seperation_theta, alignment_theta, cohesion_theta, p.theta);
        p.theta = atan2(velocity.dy, velocity.dx);
      }

      //moving part
      var dx = p.position.dx + velocity.dx;
      var dy = p.position.dy + velocity.dy;
      if (p.position.dx < 0){
        dx = size.width;
      }
      else if (p.position.dx > size.width){
        dx = 0;
      }
      if (p.position.dy < 0){
        dy = size.height;
      }
      else if (p.position.dy > size.height){
        dy = 0;
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
      //canvas.drawCircle(p.position, sqrt(eyesight), paint2);
      //canvas.drawCircle(p.position,sqrt(crowd),paint2);
      //canvas.drawLine(p.position, line_factor, paint3);
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
