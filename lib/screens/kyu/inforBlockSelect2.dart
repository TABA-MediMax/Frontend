import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba/screens/kyu/information.dart';
import '../../constants.dart';
import '../../models/pill_attribute.dart';
import '../alarm/screens/alarm_home.dart';

class SelectScreen2 extends StatefulWidget {
  const SelectScreen2({super.key});

  @override
  State<SelectScreen2> createState() => _SelectScreen2State();
}

class _SelectScreen2State extends State<SelectScreen2> {
  @override
  Widget build(BuildContext context) {
    PillAttribute? pillAttribute = Provider.of<PillAttribute?>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(appBarSize),
        child: AppBar(
          backgroundColor: mainColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, size: iconSizeAppBar, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 2,
                child: Image.file(File(pillAttribute!.imgPath), fit: BoxFit.cover),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: BottomAppBar(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(horizontal: padding),
                        child: AutoSizeText(
                          pillAttribute.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: fontSizeHeader1, // This will be the maximum font size
                              fontFamily: fontStyleNanumBold
                          ),
                          maxLines: 2, // Specify the maximum number of lines for the text
                          minFontSize: fontSizeMin, // Specify the minimum font size
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                buttonBuilder('사용법', () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ExplainScreen(medicineDetail: pillAttribute!.howToUse),
                                    ),
                                  );
                                }),
                                buttonBuilder('효능', () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ExplainScreen(medicineDetail: pillAttribute!.effect),
                                    ),
                                  );
                                }),
                                buttonBuilder('보관법', () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ExplainScreen(medicineDetail: pillAttribute!.howToStore),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(padding),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => AlarmHomeScreen(alarmKey: '${pillAttribute.pillId}',)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(radiusRoundButton),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '알람 등록',
                              style: TextStyle(
                                fontSize: fontSizeHeader2,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                  fontFamily: fontStyleNanumBold
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonBuilder(String title, VoidCallback onPressed) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(padding),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: mainColor, width: 4),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: fontSizeHeader1, // This will be the maximum font size
              fontFamily: fontStyleNanumBold
            ),
            maxLines: 1, // Specify the maximum number of lines for the text
          ),
        ),
      ),
    );
  }
}

