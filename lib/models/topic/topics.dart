import 'package:debate/services/database/database.dart';

class TopicObject {
  late String topic;
  late String question;
  late String id;

  TopicObject();

  Map<String, dynamic> topicObjectToMap(TopicObject topic) =>
      {'id': topic.id, 'question': topic.question, 'topic': topic.topic};

  Map<String, dynamic> topicObjectToMapSide({required TopicObject topic, required SIDES side}) =>
      {'id': topic.id, 'question': topic.question, 'topic': topic.topic, 'side': side.name};

  TopicObject.fromMap(Map data, this.id)
      : topic = data['topic'],
        question = data['question'];

  List<TopicObject> listMapToTopicList(List data) =>
      List.generate(data.length, (index) => TopicObject.fromMap(data[index].data(), data[index].id));
}

class TopicFollowingObject {
  late String id;

  TopicFollowingObject();

  TopicFollowingObject.fromMap(this.id);

  List<TopicFollowingObject> listMapToTopicFollowingList(List data) =>
      List.generate(data.length, (index) => TopicFollowingObject.fromMap(data[index].id));
}
