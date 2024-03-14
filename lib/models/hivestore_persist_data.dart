import 'package:hive/hive.dart';
import '../models/Current_Anlist_user_model.dart';

class UserHiveStore {
  final Box _box;

  UserHiveStore() : _box = Hive.box('user');

  void saveUser(currentUser user) {
    _box.put('id', user.id);
    _box.put('name', user.name);
    _box.put('Avatar', user.avatar);
  }   

  currentUser loadUser() {
    final id = _box.get('id');
    final name = _box.get('name');
    final Avatar = _box.get('Avatar');

    return currentUser(id: id, name: name, avatar: Avatar);
  }
}
