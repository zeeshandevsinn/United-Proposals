class NotiModel {
  var id;
  String? from;
  String? to;
  String? event;
  String? title;
  var createdAt;
  num? redirectType;
  var redirectId;
  bool? isSeen;

  NotiModel(
      {this.id,
      this.from,
      this.to,
      this.event,
      this.title,
      this.createdAt,
      this.redirectType,
      this.redirectId,
      this.isSeen});
}
