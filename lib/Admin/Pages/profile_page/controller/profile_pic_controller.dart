import 'package:flutter_riverpod/flutter_riverpod.dart';

final profilePicProvider =
    NotifierProvider<ProfilePicController, String>(ProfilePicController.new);

class ProfilePicController extends Notifier<String> {
  bool isProfileFileImageAdded = false;
  String fileProfileImage = "";
  @override
  String build() {
    return "";
  }

  onChangeProfilePic(String imagePath) {
    state = imagePath;
  }
}
