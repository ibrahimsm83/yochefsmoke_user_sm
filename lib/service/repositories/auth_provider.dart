import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ycsh/model/address.dart';
import 'package:ycsh/model/location.dart';
import 'package:ycsh/model/user.dart';
import 'package:ycsh/service/cloud.dart';
import 'package:ycsh/service/network.dart';
import 'package:ycsh/utils/actions.dart';
import 'package:ycsh/utils/config.dart';

class AuthProvider {
  Future<bool> forgetpassword(String email) async {
    const String url = AppConfig.DIRECTORY + "auth/send-otp";
    final Map map = {
      "email": email,
    };
    bool value = false;
    final String json = jsonEncode(map);
    await Network().post(
      url,
      json,
      headers: {'Content-type': 'application/json'},
      onSuccess: (val) {
        print("ForgetPassword response: $val");
        var map = jsonDecode(val);
        bool status = map["statusCode"] == Network.STATUS_OK;
        if (status) {
          value = true;
        }
        AppMessage.showMessage(map["message"].toString());
      },
    );
    return value;
  }

  changePassword(String email, String otp, String pass, String conpass) async {
    const String url = AppConfig.DIRECTORY + "auth/change-password";
    final Map map = {
      "email": email,
      "password": pass,
      "confirm_password": conpass,
      "otp": otp,
    };
    bool value = false;
    final String json = jsonEncode(map);
    await Network().post(
      url,
      json,
      headers: {'Content-type': 'application/json'},
      onSuccess: (val) {
        print("ForgetPassword response: $val");
        var map = jsonDecode(val);
        bool status = map["statusCode"] == Network.STATUS_OK;
        if (status) {
          value = true;
        }
        AppMessage.showMessage(map["message"].toString());
      },
    );
    return value;
  }

  Future<StakeHolder?> signUpUser(
      String fullname, String email, String password, String phone,
      {Location? location}) async {
    StakeHolder? user_id;
    const String url = AppConfig.DIRECTORY + "auth/sign-up";
    print("sign up url: $url");

    final Map map = {
      "email": email,
      "full_name": fullname,
      "mobile": phone,
      "password": password,
      "confirm_password": password,
      "device_token": CloudDatabase().fcmToken,
      "role": StakeHolder.TYPE_USER,
    };

    if (location != null) {
      map.addAll({
        "latitude": location.latitude,
        "longitude": location.longitude,
        "address": location.name,
      });
    }

    final String json = jsonEncode(map);

    print("sign up map: $json");

    await Network().post(
      url,
      json,
      headers: {'Content-type': 'application/json'},
      onSuccess: (val) {
        print("signup response: $val");
        var map = jsonDecode(val);
        bool status = map["statusCode"] == Network.STATUS_OK;
        if (status) {
          var data = map["data"];
          user_id = _getUser(data["user_details"], token: data["token"]);
        }
        AppMessage.showMessage(map["message"].toString());
      },
    );
    return user_id;
  }

  Future<StakeHolder?> loginUser(
    String email,
    String password,
    String user_type,
  ) async {
    StakeHolder? user;
    const String url = AppConfig.DIRECTORY + "auth/login";
    print("login url: $url");
    final String map = jsonEncode({
      "email": email,
      "password": password,
      "device_token": CloudDatabase().fcmToken,
    });
    print("login map: $map");
    await Network().post(
      url,
      map,
      headers: {'Content-type': 'application/json'},
      onSuccess: (val) {
        print("login response: $val");
        var map = jsonDecode(val);
        bool status = map["statusCode"] == Network.STATUS_OK;
        if (status) {
          var data = map["data"];
          user = _getUser(data["user_details"], token: data["token"]);
        }else{
          AppMessage.showMessage(map["message"].toString());
        }

      },
    );
    return user;
  }

  StakeHolder _getUser(Map data, {String? token}) {
    late StakeHolder user;
    user = User.fromMap(data,
        accesstoken: token,
        location: Address.fromHome(Location.fromAddressMap(data)));
    return user;
  }

  Future<StakeHolder?> updateProfile(
      String token, String fullname, String phone,
      {String? image, Address? location}) async {
    StakeHolder? stak;
    const String url = AppConfig.DIRECTORY + "user/update-profile";
    print("edit profile: ${url}");
    final List<http.MultipartFile> files = [];

    final Map<String, String> body = {
      "full_name": fullname,
      "mobile": phone,
    };
    if (location != null) {
      body.addAll({
        "latitude": location.location!.latitude.toString(),
        "longitude": location.location!.longitude.toString(),
        "address": location.location!.name,
      });
    }
    print("edit profile body: ${body}");

    if (image != null) {
      files.add(await http.MultipartFile.fromPath("image", image));
    }
    print("edit profile files: $files");
    await Network().multipartPost(url, body,
        headers: {
          "Authorization": "Bearer ${token}",
        },
        files: files, onSuccess: (val) {
      print("edit profile response: ${val}");
      var map = jsonDecode(val);
      bool status = map["statusCode"] == Network.STATUS_OK;
      if (status) {
        var data = map["data"];
        stak = _getUser(data, token: data["token"]);
      }
      AppMessage.showMessage(map["message"].toString());
    });
    return stak;
  }

  Future<bool> logoutUser(
    String token,
  ) async {
    bool status = false;
    const String url = AppConfig.DIRECTORY + "auth/logout";
    print("logout url: $url");
    await Network().post(url, jsonEncode({}), headers: {
      'Content-type': 'application/json',
      "Authorization": "Bearer ${token}",
    }, onSuccess: (val) {
      print("logout response: $val");
      var map = jsonDecode(val);
      status = true;
      AppMessage.showMessage(map["message"].toString());
    }, onError: (err) {});
    return status;
  }

  Future<String?> aboutUsContent(
    String token,
  ) async {
    String? content;
    const String url = AppConfig.DIRECTORY + "user/app-content";
    print("aboutUsContent url: $url");
    await Network().get(
      url,
      headers: {
        'Content-type': 'application/json',
        "Authorization": "Bearer ${token}",
      },
      onSuccess: (val) {
        print("aboutUsContent response: $val");
        var map = jsonDecode(val);
        bool status = map["statusCode"] == Network.STATUS_OK;
        if (status) {
          var data = map["data"];
          content = data;
        }
      },
    );
    return content;
  }
}
