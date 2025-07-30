import 'user.dart';

class CurrentUserHolder {
  User? user;
  static final CurrentUserHolder instance = CurrentUserHolder._internal();
  CurrentUserHolder._internal();
}
