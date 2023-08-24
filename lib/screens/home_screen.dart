import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taba/constants.dart';
import 'package:provider/provider.dart';

import '../models/current_index.dart';
import 'my_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class MyCustomClass {
  const MyCustomClass();

  Future<void> myAsyncMethod(BuildContext context, VoidCallback onSuccess) async {
    await Future.delayed(const Duration(seconds: 2));
    onSuccess.call();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTextController = TextEditingController(
      text: ""
  );

  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      return pickedFile;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {

    CurrentIndex currentIndex = Provider.of<CurrentIndex>(context);


    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 검색 창
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: paddingBetween),
                    child: const Text(
                      "무엇을 찾으시나요?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: fontSizeHeader1,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            child: TextField(
                              controller: searchTextController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                hintText: '검색어를 입력해주세요.',
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: IconButton(
                              icon: const Icon(Icons.search, color: Colors.black),
                              onPressed: () async {
                              //   // TODO: 검색 API 호출 await ;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '인기있는',
                    style: TextStyle(
                        color: Colors.black, letterSpacing: 2.0, fontSize: 20),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: paddingBetween),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: Text('타이레놀',
                              style: TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text('케토톱',
                              style: TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text('아스피린',
                              style: TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: padding),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: paddingBetween),
                    child: const Text(
                      "카테고리 별 약 찾기",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: fontSizeHeader2,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Image.asset(
                      'lib/assets/medicine.png',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain, // 이미지를 부모 위젯에 맞게 조절하되, 원본 비율을 유지합니다.
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home, size: iconSize), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt, size: iconSize), label: "사진으로 검색"),
          BottomNavigationBarItem(icon: Icon(Icons.settings, size: iconSize), label: "설정"),
        ],
        currentIndex: currentIndex.index,
        selectedItemColor: mainColor,
        onTap: (value) {
          currentIndex.setCurrentIndex(value);
          switch (value) {
            case 0:
              break;

            case 1:
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: listTileSize),
                        leading: const Icon(Icons.camera_alt, size: iconSize),
                        title: const Text(
                          '카메라로 사진 찍기',
                          style: TextStyle(fontSize: fontSizeLarge),
                        ),
                        onTap: () async {
                          Navigator.pop(context);
                          final pickedImage = await pickImage(ImageSource.camera);
                          if (pickedImage != null) {
                            // TODO: await searchApi(pickedImage);
                          }
                        },
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: listTileSize),
                        leading: const Icon(Icons.photo, size: iconSize),
                        title: const Text(
                          '갤러리에서 사진 선택',
                          style: TextStyle(fontSize: fontSizeLarge),
                        ),
                        onTap: () async {
                          Navigator.pop(context);
                          final pickedImage = await pickImage(ImageSource.gallery);
                          if (pickedImage != null) {
                            // TODO: await searchApi(pickedImage);
                          }
                        },
                      ),
                    ],
                  );
                },
              );
              break;

            case 2:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MyInfoScreen()),
              );
              break;
          }

          setState(() {});
        },
      ),
    );
  }
}
