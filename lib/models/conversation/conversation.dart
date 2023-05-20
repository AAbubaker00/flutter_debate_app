import 'package:debate/models/message/message.dart';

class ConversationObject {
  late String dataCreated;
  late String userAgainst;
  late String userFor;
  late String question;
  late String parentId;
  late String id;
  // late List<MessageObject> messages;

  ConversationObject();

  ConversationObject.fromMap(dynamic data, this.id, this.parentId)
      : dataCreated = data['dateCreated'],
        userAgainst = data['userAgainst'],
        userFor = data['userFor'],
        question = data['question'];

  List<ConversationObject> listMapToConversationObjectList(List data, String parentId) => List.generate(
      data.length, (index) => ConversationObject.fromMap(data[index], data[index].id, parentId));
}
