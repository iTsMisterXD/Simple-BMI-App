import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:bmiproject/assets/constrains.dart';
import 'package:bmiproject/widgets/circularindicator.dart';

class Resultscreen extends StatelessWidget {
  const Resultscreen({
    super.key,
    required this.bmi,
    required this.result,
    });
  final String bmi;
  final String result;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: NeumorphicButton(
            padding: const EdgeInsets.all(5),
            onPressed: () => Navigator.of(context).pop(),
            style: NeumorphicStyle(
              intensity: 1,
              boxShape: const NeumorphicBoxShape.circle(),
              depth: 2,
              color: primarybackgroundColor,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            )),
        title: Text(
          'BMI Result',
          style: TextStyle(
            color: ktextcolor,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Circular(
            bmi: bmi,
          ),
          Text(
            result,
            textAlign: TextAlign.center,
            maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20,),
          ),
        ],
      ),
    );
  }
}
