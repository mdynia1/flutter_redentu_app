class User {
  final String id;
  final String userName;
  final String fullName;
  final String email;
  final String phone;

  User({this.id, this.fullName, this.email, this.userName, this.phone});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        phone = data['phone'],
        userName = data['userName'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userName': userName,
      'phone': phone,
    };
  }
}
