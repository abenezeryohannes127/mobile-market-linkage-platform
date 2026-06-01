import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'chat_page.dart';

class MessageList extends StatefulWidget {
  final int userId;

  MessageList({required this.userId,});

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List data = [];

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  fetchMessages() async {
    var res = await http.get(Uri.parse(
        "http://10.0.2.2/php_backend/get_messages.php?receiver_id=${widget.userId}"));

    setState(() {
      data = json.decode(res.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Messages")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (c, i) {
          return Card(
            child: ListTile(
              title: Text(data[i]['sender_name']),
              subtitle: Text(data[i]['message']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(
                      myId: widget.userId,
                      otherId: int.parse(data[i]['sender_id']),
                      name: data[i]['sender_name'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}