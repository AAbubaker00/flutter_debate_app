import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debate/models/message/message.dart';
import 'package:debate/services/database/database.dart';
import 'package:debate/shared/Custome_Widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationPage extends StatefulWidget {
  final String question;

  const ConversationPage({super.key, required this.question});

  @override
  // ignore: library_private_types_in_public_api
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  late QuerySnapshot feed;
  late List<MessageObject> messages;

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    dynamic result = Provider.of<QuerySnapshot?>(context);
    if (result != null) {
      feed = result;

      messages = MessageObject().mapToMessageObjectList(feed.docs);


      isLoaded = true;
    }

    if (isLoaded) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.question),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: messages[index].user == 'Jma' ? 0 : 60,
                        right: messages[index].user == 'Jma' ? 60 : 0),
                    child: Row(
                      mainAxisAlignment:
                          messages[index].user == 'Jma' ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: messages[index].user == 'Jma' ? Colors.grey[200] : Colors.blue[200],
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  messages[index].msg,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  messages[index].date,
                                  style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      // onSubmitted: _handleSubmitted,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                    child: const Icon(Icons.send),
                    onTap: () => DatabaseService().sendMessage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Loading();
    }
  }
}
