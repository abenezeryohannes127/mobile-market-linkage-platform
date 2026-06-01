import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  final int myId;
  final int otherId;
  final String name;

  ChatPage({required this.myId, required this.otherId, required this.name});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List messages = [];
  TextEditingController msg = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchChat();
  }

  fetchChat() async {
    var res = await http.get(Uri.parse(
        "http://10.0.2.2/backend/get_chat.php?user1=${widget.myId}&user2=${widget.otherId}"));

    setState(() {
      messages = json.decode(res.body);
    });
  }

  sendMessage() async {
    await http.post(
      Uri.parse("http://10.0.2.2/backend/send_message.php"),
      body: {
        "sender_id": widget.myId.toString(),
        "receiver_id": widget.otherId.toString(),
        "message": msg.text
      },
    );

    msg.clear();
    fetchChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (c, i) {
                bool isMe =
                    messages[i]['sender_id'].toString() == widget.myId.toString();

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    color: isMe ? Colors.blue : Colors.grey,
                    child: Text(messages[i]['message'],
                        style: TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(controller: msg),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: sendMessage,
              )
            ],
          )
        ],
      ),
    );
  }
}