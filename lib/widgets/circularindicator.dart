import 'package:bmiproject/assets/constrains.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Circular extends StatelessWidget {
  const Circular({
    super.key,
    required this.bmi,
  });

  final String bmi;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Neumorphic(
        style: NeumorphicStyle(
          intensity: 5,
          depth: 20,
          color: kinactive,
          boxShape: const NeumorphicBoxShape.circle(),
        ),
        child: CircularPercentIndicator(
          radius: 100,
          rotateLinearGradient: true,
          lineWidth: 20,
          percent: (double.parse(bmi)*2.5) / 100,
          animationDuration: 1000,
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: kinactive,
          progressColor: kactivecolor,
          center: Text(
            bmi,
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: ktextcolor,
            ),
          ),
        ),
      ),
    );
  }
}
