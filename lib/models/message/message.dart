class MessageObject {
  late String date;
  late num likes;
  late String msg;
  late String user;

  MessageObject();

  MessageObject.fromMap(Map data)
      : date = data['date'],
        likes = data['likes'],
        msg = data['msg'],
        user = data['user'];

  List<MessageObject> mapToMessageObjectList(List data) =>
      List.generate(data.length, (index) => MessageObject.fromMap(data[index].data()));
}
