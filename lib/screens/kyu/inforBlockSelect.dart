import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba/screens/home_screen.dart';
import 'package:taba/screens/kyu/information.dart';

import '../../constants.dart';
import '../../models/pill_attribute.dart';
import '../alarm/screens/alarm_home.dart';
import 'inforBlockSelect2.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  @override
  Widget build(BuildContext context) {
    PillAttribute? pillAttribute = Provider.of<PillAttribute?>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(appBarSize), //appbar 사이즈 조절
        child: AppBar(
          backgroundColor: mainColor,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              // Your navigation logic here
            },
            icon: const Icon(Icons.arrow_back, size: iconSizeAppBar, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 2,
                  child: Image.file(
                      File(pillAttribute!.imgPath),
                    fit: BoxFit.cover)
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: BottomAppBar(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(radiusBottomNavi),
                      topLeft: Radius.circular(radiusBottomNavi),
                    ),
                  ),
                  child: Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
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
                            flex: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(padding),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => SelectScreen2()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: BorderSide(color: mainColor, width: 4),
                                        ),
                                        child: AutoSizeText(
                                          '기본정보',
                                          style: const TextStyle(
                                              fontSize: fontSizeHeader2,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontStyleNanumBold),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(padding),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ExplainScreen(medicineDetail: pillAttribute!.interaction))
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: BorderSide(color: mainColor, width: 4),
                                        ),
                                        child: AutoSizeText(
                                          '상호작용',
                                          style: const TextStyle(
                                              fontSize: fontSizeHeader2,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontStyleNanumBold),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(padding),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ExplainScreen(medicineDetail: pillAttribute!.sideEffect))
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: BorderSide(color: mainColor, width: 4),
                                        ),
                                        child: AutoSizeText(
                                          '부작용',
                                          style: const TextStyle(
                                              fontSize: fontSizeHeader2,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontStyleNanumBold),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(padding),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ExplainScreen(medicineDetail: pillAttribute!.warning))
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: BorderSide(color: mainColor, width: 4),
                                        ),
                                        child: AutoSizeText(
                                          '주의사항',
                                          style: const TextStyle(
                                              fontSize: fontSizeHeader2,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: fontStyleNanumBold),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
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
                                  padding: EdgeInsets.zero,  // Ensures button fills entire space
                                ),
                                child: const Center(  // Center the text within the button
                                  child: Text(
                                    '알람 등록',
                                    style: TextStyle(
                                      fontSize: fontSizeHeader2,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                        fontFamily: fontStyleNanumBold
                                    ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
