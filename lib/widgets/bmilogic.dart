import 'dart:math';
import 'package:hive/hive.dart';
part 'bmilogic.g.dart';

class Calculation {
  Calculation({required this.height, required this.weight});
  final double height;
  final int weight;
  double _bmi = 0;

  String calculatebmi() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsPrecision(3);
  }

  String getresult() {
    if (_bmi >= 25 && _bmi < 35) {
      return 'You are overweight, do some exercise!';
    } else if (_bmi >= 35) {
      return 'You are obese, go see a doctor!';
    } else if (_bmi > 18.5 && _bmi < 25) {
      return 'You are normal, good job!';
    } else {
      return 'You are underweight, eat more!';
    }
  }
}

@HiveType(typeId: 0)
class BMIRecord extends HiveObject {
  @HiveField(0)
  final String gender;

  @HiveField(1)
  final double height;

  @HiveField(2)
  final int weight;

  @HiveField(3)
  final String bmi;

  @HiveField(4)
  final String result;

  @HiveField(5)
  final int age;

  BMIRecord({required this.height, required this.weight, required this.bmi, required this.result, required this.gender, required this.age});
}
