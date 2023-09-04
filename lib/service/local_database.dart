import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ycsh/model/user.dart';

class LocalDatabase extends GetxService {
  static const ACCESS_TOKEN = "user";
  static const USER_CART = "user_cart";
  final GetStorage _box = GetStorage();

  static const CALL="call";

  static LocalDatabase? _instance;

  static Future<LocalDatabase> get instance async {
    if (_instance == null) {
      _instance = LocalDatabase();
      await _instance!.init();
    }
    return _instance!;
  }

  @override
  void onInit() {
    print("local database initialized");
    super.onInit();
    // this.onStart();
  }

  Future<void> init() async {
    await GetStorage.init();
  }

  Future<void> saveUser(StakeHolder user) async {
    await _box.write(ACCESS_TOKEN, user.toLocalMap());
  }

  Future<void> removeUser() async {
    await _box.remove(ACCESS_TOKEN);
  }

  StakeHolder? getUserToken() {
    StakeHolder? user;
    var map = _box.read(ACCESS_TOKEN);
    print("user local map: $map");
    if (map != null) {
      user=User.fromLocalMap(map);
    }
    return user;
  }

  Map<String, dynamic>? getUserCart(String user_id) {
    return _box.read(USER_CART)?[user_id];
  }

  Future<void> saveCartMap(String user_id, Map<String, dynamic> new_map) async {
    var map = _box.read(USER_CART);
    if (map != null) {
      map[user_id] = new_map;
    } else {
      map = {user_id: new_map};
    }
    await _box.write(USER_CART, map);
  }
/*
  Future<void> saveCurrentCall(VoiceCall call) async{
    await _box.write(CALL, call.toLocalMap());
  }


  Future<void> removeCurrentCall() async{
    await _box.remove(CALL);
  }

  VoiceCall? getCurrentCall({StakeHolder? receiver}) {
    VoiceCall? call;
    var map= _box.read(CALL);
    print("call local map: $map");
    if(map!=null) {
      call=VoiceCall.fromLocalMap(map,side: VoiceCall.SIDE_RECEIVER, receiver: receiver,);
    }
    //user=null;
    return call;
  }*/

}
