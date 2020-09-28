class ErrorModel {
  final String msg;
  final String value;
  final String param;
  final String location;

  ErrorModel({this.msg, this.location, this.param, this.value});
  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    // Map<String, dynamic> medium = map['errors'].values;
    // converted map to list - to get the first child/key of the map as they differ depending on the error but position never change
    List list = map['errors'].values.toList();
    return ErrorModel(
      location: list[0]['location'],
      msg: list[0]['msg'],
      param: list[0]['param'],
      value: list[0]['value'],
    );
  }

  @override
  String toString() {
    return "Error: $msg";
  }
}
