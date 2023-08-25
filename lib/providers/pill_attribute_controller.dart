import 'dart:math';

import '../models/pill_attribute.dart';

class PillAttributeController {
  static PillAttribute? pillAttribute;

  static PillAttribute? getPillAttribute() {
    pillAttribute ??= PillAttribute(
      pillId: "",
      name: "",
      howToUse: "",
      effect: "",
      warning: "",
      howToStore: "",
      sideEffect: "",
      interaction: "",
      imgPath: "",
    );
    //  GetUserInfo 실행
    return pillAttribute;
  }

  static void set(PillAttribute newPillAttribute) {
    pillAttribute = newPillAttribute;
  }

  static void show() {
    print(
        "[Debug PillAtt]\n"
            "name: ${pillAttribute?.name}\n"
            "pillId: ${pillAttribute?.pillId}\n"
            "howToUse: ${pillAttribute?.howToUse}\n"
            "effect: ${pillAttribute?.effect}\n"
            "warning: ${pillAttribute?.warning}\n"
            "howToStore: ${pillAttribute?.howToStore}\n");
    print("sideEffect: ${pillAttribute?.sideEffect}\n"
        "interaction: ${pillAttribute?.interaction}\n"
        "imgPath: ${pillAttribute?.imgPath}\n");
  }
  static dynamic get(String attrName) {
    if (pillAttribute == null) {
      return null;
    }

    switch (attrName) {
      case 'pillId':
        return pillAttribute?.pillId;
      case 'name':
        return pillAttribute?.name;
      case 'howToUse':
        return pillAttribute?.howToUse;
      case 'effect':
        return pillAttribute?.effect;
      case 'warning':
        return pillAttribute?.warning;
      case 'howToStore':
        return pillAttribute?.howToStore;
      case 'sideEffect':
        return pillAttribute?.sideEffect;
      case 'interaction':
        return pillAttribute?.interaction;
      case 'imgPath':
        return pillAttribute?.imgPath;
      default:
        throw ArgumentError('Invalid attribute name: $attrName');
    }
  }
}
