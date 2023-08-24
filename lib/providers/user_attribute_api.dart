import '../models/user_attribute.dart';

class UserAttributeApi {
  static UserAttribute? userAttribute;

  static UserAttribute? getUserAttribute() {
    userAttribute ??= UserAttribute(
        email: "email",
        name: "name",
        profileImage: ""
    );
    //  GetUserInfo 실행
    return userAttribute;
  }

  static void setUserAttribute(UserAttribute newUserAttribute) {
    userAttribute = newUserAttribute;
  }

  static void resetEmail(String email) {
    userAttribute?.email = email;
  }

  static void resetName(String name) {
    userAttribute?.name = name;
  }

  static void resetProfileImage(String profileImage) {
    userAttribute?.profileImage = profileImage;
  }

  static void show() {
    print(
        "[Debug UserAtt]\nemail: ${userAttribute?.email}\nname: ${userAttribute?.name}\nprofileImage${userAttribute?.profileImage}");
  }
}
