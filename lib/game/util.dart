import 'dart:math';

Random rnd = new Random();

double getRandomNum(double min, double max) =>
    (rnd.nextDouble() * (max - min)).floor() + min;
