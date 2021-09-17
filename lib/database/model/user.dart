class Users {
  String? uid;
  String? name;
  bool? presence;

  Users({
    required this.uid,
    required this.name,
    required this.presence,
  });

  Users.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    presence = json['presence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['uid'] = uid;
    data['name'] = name;
    data['presence'] = presence;

    return data;
  }
}
