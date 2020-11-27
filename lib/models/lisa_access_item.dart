class LisaAccessItem {
  int id;
  String siteName;
  String siteUrl;
  String username;
  String password;
  String dateCreated;

  LisaAccessItem(this.siteName, this.siteUrl, this.username, this.password,
      this.dateCreated);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'siteName': siteName,
      'siteUrl': siteUrl,
      'username': username,
      'password': password,
      'dateCreated': dateCreated,
    };
    return map;
  }

  LisaAccessItem.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    siteName = map['siteName'];
    siteUrl = map['siteUrl'];
    username = map['username'];
    password = map['password'];
    dateCreated = map['dateCreated'];
  }
}
