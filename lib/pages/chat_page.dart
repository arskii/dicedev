import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final Dio _dio = Dio();

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({'sender': 'user', 'message': message});
    });
    _controller.clear();

    try {
      final response = await _dio.post(
        '${dotenv.env['BASE_URL']}/chat/completions',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${dotenv.env['OPENAI_API_KEY']}',
          },
        ),
        data: jsonEncode({
          'model': 'gpt-4o',
          'messages': [
            {'role': 'user', 'content': message},
          ],
          'max_tokens': 150,
        }),
      );

      final responseData = response.data;

      setState(() {
        _messages.add({
          'sender': 'bot',
          'message': responseData['choices'][0]['message']['content']
        });
      });
    } catch (e) {
      setState(() {
        _messages.add({
          'sender': 'bot',
          'message': 'Error: Could not fetch response from OpenAI.'
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with OpenAI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message['message']!),
                  subtitle: Text(message['sender']!),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
