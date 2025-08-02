import 'package:doorlink_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreenWidget extends StatelessWidget {
  final List<Message> messages = [
    Message("Hello sir, Good Morning", "09:30 am", true),
    Message("Morning, Can I help you ?", "09:31 am", false),
    Message(
        "I saw the UI/UX Designer vacancy that you uploaded on linkedin yesterday and I am interested in joining your company.",
        "09:33 am",
        true),
    Message("Oh yes, please send your CV/Resume here", "09:35 am", false),
  ];

  ChatScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Messages',
          style: FlutterFlowTheme.of(context).titleLarge.override(
                fontFamily: 'Nunito Sans',
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                useGoogleFonts: GoogleFonts.asMap().containsKey('Nunito Sans'),
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            // Message list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return MessageBubble(message: messages[index]);
                },
              ),
            ),

            // Input field
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.attach_file, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Write your message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1C315E),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final String time;
  final bool isUser;

  Message(this.text, this.time, this.isUser);
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final alignment =
        message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bgColor = message.isUser ? Color(0xFF1C315E) : Color(0xFFFDF1E7);
    final textColor = message.isUser ? Colors.white : Colors.black87;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        if (!message.isUser)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: CircleAvatar(
              radius: 14,
              backgroundImage:
                  AssetImage('assets/avatar.jpg'), // Thay bằng avatar nếu cần
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          constraints: BoxConstraints(maxWidth: 300),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message.text,
            style: TextStyle(color: textColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            message.time,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        )
      ],
    );
  }
}
