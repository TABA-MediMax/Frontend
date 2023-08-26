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

  static DateTime? startingDateTime;

  // Determine the closest future time from the given time slots
  static int getClosestFutureTime(int currentHour) {
    List<int> timeSlots = [0, 6, 12, 18, 24];
    for (int time in timeSlots) {
      if (currentHour < time) {
        return time;
      }
    }
    return 0;  // Return 0 if currentHour is past 24
  }

  late List<AlarmSettings> alarms;

  static StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    int closestTime = getClosestFutureTime(now.hour);

    if (closestTime == 0) {
      // If the closest time is 0 o'clock, then set it for the next day
      startingDateTime = DateTime(now.year, now.month, now.day + 1, 0, 0);
    } else {
      startingDateTime = DateTime(now.year, now.month, now.day, closestTime, 0);
    }

    loadAlarms();
    subscription ??= Alarm.ringStream.stream.listen(
      (alarmSettings) => navigateToRingScreen(alarmSettings),
    );
  }
  static Map<String, List<DateTime>> alarmMap = {
    '201310592': [startingDateTime!.add(Duration(hours: 0))],
    '201400318': [startingDateTime!.add(Duration(hours: 0))],
    '201403390': [
      startingDateTime!.add(Duration(hours: 0)),
      startingDateTime!.add(Duration(hours: 12))],
    '199902612': [
      startingDateTime!.add(Duration(hours: 0)),
      startingDateTime!.add(Duration(hours: 6)),
      startingDateTime!.add(Duration(hours: 12))],
    '200900682': [
      startingDateTime!.add(Duration(hours: 0)),
      startingDateTime!.add(Duration(hours: 12)),
    ],
    '198701721': [
      startingDateTime!.add(Duration(hours: 0)),
      startingDateTime!.add(Duration(hours: 6)),
      startingDateTime!.add(Duration(hours: 12))],
    '201103366': [
      startingDateTime!.add(Duration(hours: 0)),
      startingDateTime!.add(Duration(hours: 6)),
      startingDateTime!.add(Duration(hours: 12))
    ],
      //바소피린장용정(아스피린)[201310592]: 성인은 1회 1정,
      //유한아스피린장용정(아스피린)[201400318]: 성인 1일 1회 1정,
      //한솔나프록센연질캡슐[201403390]: 나프록센으로서 1회 250 mg ~ 500 mg 1일 2회(12시간마다) 경구투여한다.
      //골사민캡슐(결정글루코사민황산염)(수출명 : NEOCOMIN)[199902612]: 1일 3회 6주간 복용한다.
      //굿스펜연질캡슐(덱시부프로펜)[200900682]: 1회 300 mg을 1일 2～4회 경구투여
      //나르펜정400밀리그램(이부프로펜)(수출명:PANALTab.)[198701721]: 1일 3-4회
      //한솔이부프로펜연질캡슐[201103366]: 1 일 3 ~ 4 회
  };

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
