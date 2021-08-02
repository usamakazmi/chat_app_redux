
class LoginModel {
   String? email;
   String? firstname;
   String? lastname;
   String? user_type;
   String? userid;
   String? user_pic;
   String? password;
   int? status;
   String? msg;

  LoginModel({ this.email,
     this.firstname,
     this.lastname,
     this.user_type,
     this.userid,
     this.user_pic,
     this.password,
     this.status,
     this.msg});

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