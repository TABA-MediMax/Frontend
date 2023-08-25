import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../http/dto.dart';
import '../constants.dart';
import '../models/current_index.dart';
import '../models/user_attribute.dart';
import '../providers/user_attribute_api.dart';
import 'home_screen.dart';
import 'kyu/inforselect.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({super.key});

  @override
  _MyInfoScreenState createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  // 프로필 사진용
  File? _imageFile;
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
    UserAttribute? userAttribute = Provider.of<UserAttribute?>(context);
    CurrentIndex currentIndex = Provider.of<CurrentIndex>(context);

    Future<ImageSource?> _showImageSourceDialog() async {
      return await showDialog<ImageSource>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text('Choose image source'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                  child: const Text('Camera'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                  child: const Text('Gallery'),
                ),
              ],
            );
          });
    }

    Future<ImageProvider> _currentImageProvider() async {
      return const AssetImage('lib/assets/profile/default_profile_icon.jpg');
    }

    Future<void> _chooseImage(ImageSource source) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
      }
    }

    userAttribute = UserAttributeApi.getUserAttribute();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: SizedBox(
          height: 100,
          child: AppBar(
            centerTitle: true,
            title: const Text(
              '환경설정',
              style: TextStyle(
                fontSize: fontSizeLarge,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // 내 정보
          const Divider(
            color: Colors.grey,
            height: 30,
            thickness: 1,
            indent: 1,
            endIndent: 1,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(
              left: padding,
            ),
            child: const Text("내 정보",
                style: TextStyle(
                    fontSize: fontSizeMiddle,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.left),
          ),
          const Divider(
            color: Colors.grey,
            height: 30,
            thickness: 1,
            indent: 1,
            endIndent: 1,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              // Profile Picture UI
              InkWell(
                onTap: () async {
                  ImageSource? selectedSource = await _showImageSourceDialog();
                  if (selectedSource != null) {
                    _chooseImage(selectedSource);
                  }
                },
                child: FutureBuilder<ImageProvider>(
                  future: _currentImageProvider(), // Set future to _currentImageProvider()
                  builder: (BuildContext context, AsyncSnapshot<ImageProvider> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: snapshot.data,
                      );
                    } else {
                      // While the image is loading, display a spinner
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),

              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 이름
                      Container(
                        child: Text((userAttribute?.name ?? ''), style: const TextStyle(
                            fontSize: fontSizeMiddle,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  //이메일
                  Text((userAttribute?.email ?? ''), style: const TextStyle(
                      fontSize: fontSizeSmall, color: Colors.black)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        '닉네임',
                        style: TextStyle(
                            fontSize: fontSizeMiddle,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),

          // 전체 기록 저장
          const Divider(
            color: Colors.grey,
            height: 30,
            thickness: 1,
            indent: 1,
            endIndent: 1,
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(
              left: padding,
            ),
            child: const Text("전체 기록 저장",
                style: TextStyle(
                    fontSize: fontSizeMiddle,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.left),
          ),
          const Divider(
            color: Colors.grey,
            height: 30,
            thickness: 1,
            indent: 1,
            endIndent: 1,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home, size: iconSize), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: iconSize), label: "검색"),
          BottomNavigationBarItem(icon: Icon(Icons.settings, size: iconSize), label: "설정"),
        ],
        currentIndex: currentIndex.index,
        selectedItemColor: mainColor,
        onTap: (value) {
          currentIndex.setCurrentIndex(value);
          switch (value) {
            case 0:
            //TODO: pillList = ListPillResponses 받아서
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
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
                          final pickedImage = await pickImage(ImageSource.camera);
                          if (pickedImage != null) {
                            //TODO: await searchApi(pickedImage);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const SelectScreen()),
                            );
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
                          final pickedImage = await pickImage(ImageSource.gallery);
                          if (pickedImage != null) {
                            //TODO: await searchApi(pickedImage);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const SelectScreen()),
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              );
              break;

            case 2:
              break;
          }

          setState(() {});
        },
      ),
    );
  }
}