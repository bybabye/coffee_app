class UserApp {
  final String uid;
  final String displayname;
  final String email;
  final String photoURL;
  final DateTime online;

  UserApp(
      {required this.uid,
      required this.displayname,
      required this.email,
      required this.photoURL,
      required this.online});

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers

    return {
      'uid': uid,
      'displayName': displayname,
      'email': email,
      'photoURL': photoURL,
      'online': online,
    };
  }

  factory UserApp.fromJson(Map<String, dynamic> json) {
    // ignore: no_leading_underscores_for_local_identifiers

    return UserApp(
      uid: json['uid'],
      displayname: json['displayName'],
      email: json['email'],
      photoURL: json['photoURL'] ?? "",
      online: json['online'].toDate(),
    );
  }
}
