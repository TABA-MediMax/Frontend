import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:taba/providers/pill_attribute_controller.dart';
import 'package:taba/screens/initial_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:taba/screens/kyu/imforBlockSelect.dart';
import 'package:taba/screens/kyu/information.dart';
import 'package:taba/screens/kyu/imformation_block_only_for_useage.dart';
import 'package:taba/screens/my_info_screen.dart';

import 'constants.dart';
import 'http/dto.dart';
import 'models/current_index.dart';
import 'models/pill_attribute.dart';



MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class DownloadClass {
  static void callback(String id, DownloadTaskStatus status, int progress) {
    // print("Download Status : $status");
    // print("Download Progress : $progress");
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterDownloader.initialize(ignoreSsl: true);
  KakaoSdk.init(nativeAppKey: "f8b2890ef114ab577be86cf48c097cda");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<PillAttribute?>.value(
            value: PillAttributeController.getPillAttribute()),
        Provider<TokenResponse>.value(
            value: TokenResponse("", accessToken: "", refreshToken: "")),
        Provider<CurrentIndex>.value(
            value: CurrentIndex(index: 1)), // for BottomNavigationBar
      ],
      child: MaterialApp(
        title: '약사전',
        theme: ThemeData(
          // This is the theme of your application.

          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: createMaterialColor(mainColor),
        ),
        home: const ExplainScreen(),
      ),
    );
  }
}
