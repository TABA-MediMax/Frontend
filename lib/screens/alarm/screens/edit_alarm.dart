import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:taba/constants.dart';

class ExampleAlarmEditScreen extends StatefulWidget {
  final AlarmSettings? alarmSettings;

  const ExampleAlarmEditScreen({Key? key, this.alarmSettings})
      : super(key: key);

  @override
  State<ExampleAlarmEditScreen> createState() => _ExampleAlarmEditScreenState();
}

class _ExampleAlarmEditScreenState extends State<ExampleAlarmEditScreen> {
  bool loading = false;

  late bool creating;
  late TimeOfDay selectedTime;
  late bool loopAudio;
  late bool vibrate;
  late bool volumeMax;
  late bool showNotification;
  late String assetAudio;

  bool isToday() {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );

    return now.isBefore(dateTime);
  }

  @override
  void initState() {
    super.initState();
    creating = widget.alarmSettings == null;

    if (creating) {
      final dt = DateTime.now().add(const Duration(minutes: 1));
      selectedTime = TimeOfDay(hour: dt.hour, minute: dt.minute);
      loopAudio = true;
      vibrate = true;
      volumeMax = true;
      showNotification = true;
      assetAudio = 'assets/marimba.mp3';
    } else {
      selectedTime = TimeOfDay(
        hour: widget.alarmSettings!.dateTime.hour,
        minute: widget.alarmSettings!.dateTime.minute,
      );
      loopAudio = widget.alarmSettings!.loopAudio;
      vibrate = widget.alarmSettings!.vibrate;
      volumeMax = widget.alarmSettings!.volumeMax;
      showNotification = widget.alarmSettings!.notificationTitle != null &&
          widget.alarmSettings!.notificationTitle!.isNotEmpty &&
          widget.alarmSettings!.notificationBody != null &&
          widget.alarmSettings!.notificationBody!.isNotEmpty;
      assetAudio = widget.alarmSettings!.assetAudioPath;
    }
  }

  Future<void> pickTime() async {
    final res = await showTimePicker(
      initialTime: selectedTime,
      context: context,
    );
    if (res != null) setState(() => selectedTime = res);
  }

  AlarmSettings buildAlarmSettings() {
    final now = DateTime.now();
    final id = creating
        ? DateTime.now().millisecondsSinceEpoch % 100000
        : widget.alarmSettings!.id;

    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
      0,
      0,
    );
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    final alarmSettings = AlarmSettings(
      id: id,
      dateTime: dateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      volumeMax: volumeMax,
      notificationTitle: showNotification ? '약 알람' : null,
      notificationBody: showNotification ? '약 드실 시간이에요.' : null,
      assetAudioPath: assetAudio,
      stopOnNotificationOpen: false,
    );
    return alarmSettings;
  }

  void saveAlarm() {
    setState(() => loading = true);
    Alarm.set(alarmSettings: buildAlarmSettings()).then((res) {
      if (res) Navigator.pop(context, true);
    });
    setState(() => loading = false);
  }

  void deleteAlarm() {
    Alarm.stop(widget.alarmSettings!.id).then((res) {
      if (res) Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "취소",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: mainColor),
                ),
              ),
              TextButton(
                onPressed: saveAlarm,
                child: loading
                    ? const CircularProgressIndicator()
                    : Text(
                        "저장",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: mainColor),
                      ),
              ),
            ],
          ),
          Text(
            '${isToday() ? '오늘' : '내일'}',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.black),
          ),
          RawMaterialButton(
            onPressed: pickTime,
            fillColor: Colors.grey[200],
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Text(
                selectedTime.format(context),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '반복 알람',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Switch(
                value: loopAudio,
                onChanged: (value) => setState(() => loopAudio = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '진동',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Switch(
                value: vibrate,
                onChanged: (value) => setState(() => vibrate = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '볼륨 최대',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Switch(
                value: volumeMax,
                onChanged: (value) => setState(() => volumeMax = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '알림 켜기',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Switch(
                value: showNotification,
                onChanged: (value) => setState(() => showNotification = value),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '소리',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              DropdownButton(
                value: assetAudio,
                items: const [
                  DropdownMenuItem<String>(
                    value: 'assets/marimba.mp3',
                    child: Text('산뜻한 아침'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/nokia.mp3',
                    child: Text('활기찬 점심'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/mozart.mp3',
                    child: Text('편안한 밤'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/star_wars.mp3',
                    child: Text('기본1'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'assets/one_piece.mp3',
                    child: Text('기본2'),
                  ),
                ],
                onChanged: (value) => setState(() => assetAudio = value!),
              ),
            ],
          ),
          if (!creating)
            TextButton(
              onPressed: deleteAlarm,
              child: Text(
                '알람 삭제',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: mainColor),
              ),
            ),
          const SizedBox(),
        ],
      ),
    );
  }
}
