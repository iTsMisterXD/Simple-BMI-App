import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:bmiproject/widgets/bmilogic.dart';
import 'package:bmiproject/assets/constrains.dart';
import 'package:bmiproject/pages/result.dart';
import 'package:bmiproject/widgets/valueselector.dart';
import 'package:bmiproject/pages/historypage.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Gender selectedGender = Gender.male;
  void selectGender(Gender gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  double height = 0;
  int age = 1;
  int weight = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              );
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  selectGender(Gender.male);
                },
                child:
                    gendercard('Male', selectedGender == Gender.male, context),
              ),
              GestureDetector(
                onTap: () {
                  selectGender(Gender.female);
                },
                child: gendercard(
                    'Female', selectedGender == Gender.female, context),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              heighslider(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.53,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueSelector(
                        label: 'weight',
                        value: weight,
                        onIncrement: () {
                          setState(() {
                            if (weight < 200) {
                              weight++;
                            }
                          });
                        },
                        onDecrement: () {
                          setState(() {
                            setState(() {
                              if (weight > 0) {
                                weight--;
                              }
                            });
                          });
                        }),
                    ValueSelector(
                      label: 'Age',
                      value: age,
                      onIncrement: () {
                        setState(() {
                          if (age < 100) {
                            age++;
                        }
                        });

                      },
                      onDecrement: () {
                        setState(() {
                          if (age > 1) {
                            age--;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          NeumorphicButton(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.35,
                right: MediaQuery.of(context).size.width * 0.35,
                top: 15,
                bottom: 15),
            style: NeumorphicStyle(
              color: kactivecolor,
            ),
            child: const Text(
              'Calculate',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () async {
              Calculation calc = Calculation(height: height, weight: weight);
              String bbmi = calc.calculatebmi();
              String result = calc.getresult();
              String gender = selectedGender.toString();
              int age = this.age;
              BMIRecord record = BMIRecord(height: height, weight: weight, bmi: bbmi, result: result, gender: gender, age: age);
              var box = await Hive.openBox<BMIRecord>('bmiStorage');
              box.add(record);
              await box.close();
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Resultscreen(
                    bmi: bbmi,
                    result: result,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Neumorphic heighslider(BuildContext context) {
    return Neumorphic(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.55,
        width: MediaQuery.of(context).size.width * 0.36,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Height',
              style: TextStyle(
                color: ktextcolor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.50,
              child: SfSliderTheme(
                data: SfSliderThemeData(
                    activeLabelStyle: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                    inactiveLabelStyle:
                        TextStyle(color: ktextcolor, fontSize: 15)),
                child: SfSlider.vertical(
                  activeColor: kactivecolor,
                  min: 100,
                  max: 250.0,
                  value: height,
                  interval: 20,
                  enableTooltip: true,
                  tooltipPosition: SliderTooltipPosition.right,
                  showTicks: true,
                  showLabels: true,
                  minorTicksPerInterval: 1,
                  onChanged: (dynamic value) {
                    setState(() {
                      height = value;
                    });
                  },
                  thumbIcon: NeumorphicIcon(Icons.circle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Neumorphic gendercard(String title, bool isSelected, BuildContext context) {
    return Neumorphic(
      child: Neumorphic(
        style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
            intensity: 0.9,
            depth: 3,
            shape: NeumorphicShape.flat,
            color: isSelected ? kactivecolor : null),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.all(18),
          child: Text(title),
        ),
      ),
    );
  }
}

enum Gender {
  male,
  female,
}
