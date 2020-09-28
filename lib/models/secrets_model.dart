class SecretsModel {
  final String secretID;
  final String secret;
  final String ownerID;
  final String ownerName;
  final String ownerEmail;
  final String sharedOn;

  SecretsModel({
    this.secretID,
    this.secret,
    this.ownerID,
    this.ownerName,
    this.ownerEmail,
    this.sharedOn,
  });
  Map<String, dynamic> toMap() {
    return {
      "_id": secretID,
      "content": secret,
      "owner": {
        "_id": ownerID,
        "name": ownerName,
        "email": ownerEmail,
      },
      "posted_on": sharedOn,
    };
  }

  SecretsModel.fromMap(Map<String, dynamic> map)
      : secretID = map['_id'],
        secret = map['content'],
        ownerID = map['owner']['_id'],
        ownerName = map['owner']['name'],
        ownerEmail = map['owner']['email'],
        sharedOn = map['posted_on'];
}
