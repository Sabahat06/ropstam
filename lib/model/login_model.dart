import 'package:cached_map/cached_map.dart';
class LoginModel {
  Data? data;
  Meta? meta;

  LoginModel({this.data, this.meta});

  LoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  String? accessToken;
  User? user;

  Data({this.accessToken, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? name;
  String? email;
  String? emailVerifiedAt='';
  String? mobile;
  bool? mobileVerifiedAt;
  String? apiToken='';
  String? image;
  String? address;
  String? country;
  String? state;
  String? role;
  int? verified;
  String? lang;
  String? ltd;
  String? deviceToken;
  int? gender;
  String? type='';
  String? customerId='';
  String? provider='';
  String? addedBy='';
  String? rating;
  int? ratingCount;
  String? rememberToken='';

  User(
      {this.id,
        this.username,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.mobile,
        this.mobileVerifiedAt,
        this.apiToken,
        this.image,
        this.address,
        this.country,
        this.state,
        this.role,
        this.verified,
        this.lang,
        this.ltd,
        this.deviceToken,
        this.gender,
        this.type,
        this.customerId,
        this.provider,
        this.addedBy,
        this.rating,
        this.ratingCount,
        this.rememberToken});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at']??'';
    mobile = json['mobile'];
    mobileVerifiedAt = json['mobile_verified_at'];
    apiToken = json['api_token']??'';
    image = json['image'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    role = json['role'];
    verified = json['verified'];
    lang = json['lang'];
    ltd = json['ltd'];
    deviceToken = json['device_token'];
    gender = json['gender'];
    type = json['type']??'';
    customerId = json['customer_id']??'';
    provider = json['provider']??'';
    addedBy = json['added_by']??'';
    rating = json['rating'];
    ratingCount = json['rating count'];
    rememberToken = json['remember_token']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile'] = this.mobile;
    data['mobile_verified_at'] = this.mobileVerifiedAt;
    data['api_token'] = this.apiToken;
    data['image'] = this.image;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['role'] = this.role;
    data['verified'] = this.verified;
    data['lang'] = this.lang;
    data['ltd'] = this.ltd;
    data['device_token'] = this.deviceToken;
    data['gender'] = this.gender;
    data['type'] = this.type;
    data['customer_id'] = this.customerId;
    data['provider'] = this.provider;
    data['added_by'] = this.addedBy;
    data['rating'] = this.rating;
    data['rating count'] = this.ratingCount;
    data['remember_token'] = this.rememberToken;
    return data;
  }

  /// Get User From Cache if Not then it will return null
  static Future<User?> fromCache() async{
    Mapped cacheJson = await Mapped.getInstance();
    var cachedUser = cacheJson.loadFile(cachedFileName: "user");
    print("user from cache: $cachedUser");
    if(cachedUser==null)
      return null;
    else
      return User.fromJson(cachedUser);
  }

  /// Saving User into Cache

  static Future<String> saveUserToCache(User user) async{
    Mapped cacheJson = await Mapped.getInstance();
    try{
      cacheJson.saveFile(file: user.toJson(), cachedFileName: "user");
    }
    catch(e){
      return "Failed to save user due to: $e";
    }
    return "Save user to cache successfully ";
  }

  ///Deleting Cache User

  static Future<String> deleteCachedUser()async{
    Mapped cacheJson = await Mapped.getInstance();
    try{
      cacheJson.deleteFile(cachedFileName: "user");
    }
    catch(e){
      return "Some Problem accoured while deleting user File:$e";
    }
    return "Deleted user to cache successfully";

  }
}

class Meta {
  String? message;
  int? status;

  Meta({this.message, this.status, });

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
