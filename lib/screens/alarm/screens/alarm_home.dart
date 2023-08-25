import 'dart:async';
import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:taba/screens/alarm/screens/ring.dart';

import '../../../constants.dart';
import '../widgets/tile.dart';
import 'edit_alarm.dart';

class AlarmHomeScreen extends StatefulWidget {
  final String alarmKey;
  const AlarmHomeScreen({Key? key, required this.alarmKey}) : super(key: key);

  @override
  State<AlarmHomeScreen> createState() => _AlarmHomeScreenState();
}

class _AlarmHomeScreenState extends State<AlarmHomeScreen> {

  static final DateTime startingDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 0);  // For example, starting at 7:00 AM today

  static Map<String, List<DateTime>> alarmMap = {
    'key1': [startingDateTime.add(Duration(hours: 1))],  // 8:00 AM
    'key2': [
      startingDateTime.add(Duration(hours: 2)),  // 9:00 AM
      startingDateTime.add(Duration(hours: 3))   // 10:00 AM
    ],
    // Add more keys and DateTime lists as needed
  };


  late List<AlarmSettings> alarms;

  static StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
  }

  void loadAlarms() {
    setState(() {
      alarms = Alarm.getAlarms();
      alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);

      if (alarmMap.containsKey(widget.alarmKey)) {
        final newAlarms = alarmMap[widget.alarmKey]!.map((dateTime) => AlarmSettings(id: Random().nextInt(10000), dateTime: dateTime, assetAudioPath: 'assets/marimba.mp3')).toList();

        for (var newAlarm in newAlarms) {
          var existingAlarmIndex = alarms.indexWhere((existingAlarm) => existingAlarm.id == newAlarm.id);
          if (existingAlarmIndex != -1) {
            // Update the existing alarm if the ID matches
            alarms[existingAlarmIndex] = newAlarm;
          } else if (!alarms.any((existingAlarm) => existingAlarm.dateTime == newAlarm.dateTime)) {
            // Add the alarm if it doesn't already exist in the list
            alarms.add(newAlarm);
          }
        }
      }
    });
  }


  Future<void> navigateToRingScreen(AlarmSettings alarmSettings) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ExampleAlarmRingScreen(alarmSettings: alarmSettings),
        ));
    loadAlarms();
  }

  Future<void> navigateToAlarmScreen(AlarmSettings? settings) async {
    final res = await showModalBottomSheet<bool?>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: ExampleAlarmEditScreen(alarmSettings: settings),
          );
        });

    if (res != null && res == true) loadAlarms();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarSize),
        child: AppBar(
          centerTitle: true,
          title: const Text('알람',style: TextStyle(fontSize: fontSizeHeader1),),
          backgroundColor: mainColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, size: iconSizeAppBar, color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: alarms.isNotEmpty
            ? ListView.separated(
                itemCount: alarms.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ExampleAlarmTile(
                    key: Key(alarms[index].id.toString()),
                    title: TimeOfDay(
                      hour: alarms[index].dateTime.hour,
                      minute: alarms[index].dateTime.minute,
                    ).format(context),
                    onPressed: () => navigateToAlarmScreen(alarms[index]),
                    onDismissed: () {
                      Alarm.stop(alarms[index].id).then((_) => loadAlarms());
                    },
                  );
                },
              )
            : Center(
                child: Text(
                  "등록된 알람이 없습니다",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 10,height: 10),
            FloatingActionButton(
              onPressed: () => navigateToAlarmScreen(null),
              child: const Icon(Icons.alarm_add_rounded, size: 33),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
