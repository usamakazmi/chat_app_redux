
class LoginModel {
  final String email;
  final String firstname;
  final String lastname;
  final String user_type;
  final String userid;
  final String user_pic;
  final String password;
  final int status;
  final String msg;

  LoginModel({required this.email,
    required this.firstname,
    required this.lastname,
    required this.user_type,
    required this.userid,
    required this.user_pic,
    required this.password,
    required this.status,
    required this.msg});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      user_type: json['user_type'],
      userid: json['userid'],
      user_pic: json['user_pic'],
      password: json['password'],
      status: json['status'],
      msg: json['msg'],
    );
  }
}