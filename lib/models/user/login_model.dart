class LoginModel {
  LoginModel({
    this.message,
    this.token,
    this.data,
  });

  LoginModel.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  String? token;
  Data? data;
  LoginModel copyWith({
    String? message,
    String? token,
    Data? data,
  }) =>
      LoginModel(
        message: message ?? this.message,
        token: token ?? this.token,
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.user,
  });

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? user;
  Data copyWith({
    User? user,
  }) =>
      Data(
        user: user ?? this.user,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    this.id,
    this.fullname,
    this.email,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
  }
  int? id;
  String? fullname;
  String? email;
  User copyWith({
    int? id,
    String? fullname,
    String? email,
  }) =>
      User(
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fullname'] = fullname;
    map['email'] = email;
    return map;
  }
}
