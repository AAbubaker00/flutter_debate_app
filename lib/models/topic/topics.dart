class TopicObject {
  late String topic;
  late String question;
  late String id;

  TopicObject();

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
