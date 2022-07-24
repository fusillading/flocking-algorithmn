import 'dart:math';
import 'dart:ui';
import 'package:flocking/particle.dart';
import 'package:flutter/material.dart';

import 'my-painter-canvas.dart';

int seperation_coefficient = 5;
int alignment_coefficient = 3;
int cohesion_coefficient = 3;

/*
double direction_decision(Particle p, Size size) {
  List<Particle> particles;
  var cohesion_cnt = 0;
  var seperation_cnt = 0;
  var alignment_cnt = 0;
  var cohesion_position = Offset(0.0, 0.0);
  var seperation_position = Offset(0.0, 0.0);
  var alignment_theta = 0.0;
  Offset position = Offset(
      p.position.dx - size.width / 2, size.height / 2 - p.position.dy);

  for (var val in this.particles) {
    var distance = (val.position.dx-p.position.dx)*(val.position.dx-p.position.dx)+
    (val.position.dy-p.position.dy)*(val.position.dy-p.position.dy);
    Offset reposition = Offset(val.position.dx-size.width/2, size.height/2 - val.position.dy);
    if (distance > 0 && distance < eyesight) {
      cohesion_position += reposition;
      cohesion_cnt++;
      alignment_theta += val.theta;
      alignment_cnt++;
    }
    if (distance > 0 && distance < crowd){
      seperation_position += reposition;
      seperation_cnt++;
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

  return (cohesion_theta*cohesion_coefficient
      +seperation_theta*seperation_coefficient
      +alignment_theta*alignment_coefficient)/
      (cohesion_coefficient+seperation_coefficient+alignment_coefficient);
}

 */