import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'dto.dart';

String ip = "http://192.168.0.11";

Future<ResponseData> TextSearchRequest(String inputValue) async {
  final response = await http.get(Uri.parse('$ip:8080/textSearch'), headers: {
    "searchText": inputValue,  // adjust this based on how you send the string
  });

  if (response.statusCode == 200) {
    return ResponseData.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<ResponseData> ImageSearchRequest(File imageFile, String filename) async {
  var uri = Uri.parse('$ip:8080/imageUpload');
  var request = http.MultipartRequest('POST', uri);

  request.files.add(
    http.MultipartFile(
      'Image',
      imageFile.readAsBytes().asStream(),
      imageFile.lengthSync(),
      filename: filename,
    ),
  );

  try {
    var response = await request.send();
    print("[debug]response:${response.statusCode}");

    if (response.statusCode == 200) {
      List<int> responseData = await response.stream.toList().then((listOfInts) => listOfInts.expand((x) => x).toList());
      var decodedJson = jsonDecode(utf8.decode(responseData));
      return ResponseData.fromJson(decodedJson);
    } else {
      throw Exception('Failed to upload image and retrieve data with status code ${response.statusCode}');
    }
  } catch (e) {
    print('Error while processing the response: $e');
    throw Exception('Failed to upload image and retrieve data');
  }
}

