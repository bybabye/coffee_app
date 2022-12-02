enum Role {
  admin,
  employee,
  user,
}

class UserApp {
  final String uid;
  final String displayname;
  final String email;
  final String photoURL;
  final Role role;

  UserApp({
    required this.uid,
    required this.displayname,
    required this.email,
    required this.photoURL,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    String _role;
    switch (role) {
      case Role.admin:
        _role = 'admin';
        break;
      case Role.employee:
        _role = 'employee';
        break;
      case Role.user:
        _role = 'user';
        break;
    }
    return {
      'uid': uid,
      'displayname': displayname,
      'role': _role,
      'email': email,
      'photoURL': photoURL,
    };
  }

  factory UserApp.fromJson(Map<String, dynamic> json) {
    // ignore: no_leading_underscores_for_local_identifiers
    Role _role = Role.user;
    switch (json['role']) {
      case 'admin':
        _role = Role.admin;
        break;
      case 'employee':
        _role = Role.employee;
        break;
      case 'user':
        _role = Role.user;
        break;
    }
    return UserApp(
      uid: json['uid'],
      displayname: json['displayname'],
      email: json['email'],
      photoURL: json['photoURL'],
      role: _role,
    );
  }
}
