import 'package:hive/hive.dart';
import 'package:bmiproject/widgets/bmilogic.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Box<BMIRecord> bmiBox;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    bmiBox = await Hive.openBox<BMIRecord>('bmiStorage');
  }

  Future<void> _deleteRecord(int index) async {
    await bmiBox.deleteAt(index);
    setState(() {});
  }

  Future<void> _deleteAllRecords() async {
    await bmiBox.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteAllRecords(),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _openBox(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (bmiBox.isEmpty) {
              return const Center(
                child: Text('No BMI records found.'),
              );
            }

             return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.blueAccent,
                  child: const Text(
                    'Swipe the record to delete',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: bmiBox.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    
                    itemBuilder: (context, index) {
                      BMIRecord record = bmiBox.getAt(index)!;
                      return Dismissible(
                        key: Key(record.bmi.toString()),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Deletion'),
                                content: const Text('Are you sure you want to delete this BMI record?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) => _deleteRecord(index),
                        child: Neumorphic(
                          style: NeumorphicStyle(
                            depth: 5,
                            color: Colors.grey[200]!,
                            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0)),
                          ),
                          child: ListTile(
                            title: Text(
                              'Your BMI: ${record.bmi}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Icon(Icons.access_time, size: 40.0, color: Colors.grey[600]),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Height: ${record.height.toStringAsPrecision(5)} cm, Weight: ${record.weight} kg'),
                                    Text('Gender: ${record.gender}, Age: ${record.age}'),
                                    Text('Status: ${record.result}'),
                                  ],
                                ),
                              ],
                            ),
                            subtitleTextStyle: const TextStyle(
                              color: Colors.grey,
                            )
                          ),
                        )
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
