import 'dart:math';
import 'dart:ui';

double eyesight = 25000;
double crowd = 250;
double theta_coefficient = 100;
double seperation_coefficient = 15;
double alignment_coefficient = 50;
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