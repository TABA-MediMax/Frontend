import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _MyAppState();
}

class _MyAppState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mec',
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  TextEditingController tec = TextEditingController();
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    File pickedImage1 =
        (await picker.pickImage(source: ImageSource.camera)) as File;
    if (pickedImage1 != null) {
      print(pickedImage1.path);
      if (this.mounted) {
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.0),
            Container(
              width: 400,
              height: 100,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(
                "무엇을 찾으시나요?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(width: 8),
                  Flexible(
                    flex: 1,
                    child: TextField(
                      controller: tec,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        hintText: '검색어를 입력해주세요.',
                      ),
                    ),
                  ),
                  Icon(Icons.search, color: Colors.black),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(height: 100),
            Row(
              children: [
                SizedBox(width: 20),
                Text(
                  '인기있는',
                  style: TextStyle(
                      color: Colors.black, letterSpacing: 2.0, fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 5),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('타이레놀',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                  SizedBox(width: 20),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('케토톱',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                  SizedBox(width: 20),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('아스피린',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: 400,
                  height: 100,
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(70, 20, 0, 0),
                  child: Text(
                    "카테고리 별 약 찾기",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
                Image.asset('images/medicine.png', width: 250, height: 250),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffC74847),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          height: 100.0,
          child: Container(
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                color: Color(0xffC74847),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      topRight: Radius.circular(100),
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text('Modal BottomSheet'),
                                        ElevatedButton(
                                          child: const Text('Done!'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.home, size: 80, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 300,
                                decoration: const BoxDecoration(
                                  color: Color(0xffC74847),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        '사진찍기',
                                        style: TextStyle(
                                            fontSize: 50, color: Colors.white),
                                      ),
                                      IconButton(
                                        onPressed: () => pickImage(context),
                                        icon: Icon(Icons.satellite,
                                            size: 230, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.camera_alt,
                            size: 80, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          // '설정' 아이콘 버튼이 눌렸을 때 실행할 동작 추가
                        },
                        icon:
                            Icon(Icons.settings, size: 80, color: Colors.white),
                      ),
                      SizedBox(width: 5),
                    ]),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            width: 300,
            height: 300,
            child: Image.file(File(_image!.path)),
          )
        : Container(
            width: 300,
            height: 300,
            color: Colors.grey,
          );
  }
}
