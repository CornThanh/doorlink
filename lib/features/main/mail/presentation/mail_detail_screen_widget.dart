import 'package:doorlink_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:doorlink_mobile/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MailDetailScreenWidget extends StatelessWidget {
  final String senderName = "John Doe";
  final String senderEmail = "john.doe@example.com";
  final String subject = "Meeting Follow-up";
  final String body = '''
Hi team,

Thanks for the productive meeting today. Attached is the follow-up document with tasks and timelines.

Let me know if you have any questions.

Best regards,
John
''';
  final String time = "10:30 AM";

  const MailDetailScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        title: Text(
          'Mail Detail',
          style: FlutterFlowTheme.of(context).titleLarge.override(
                fontFamily: 'Nunito Sans',
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                useGoogleFonts: GoogleFonts.asMap().containsKey('Nunito Sans'),
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: FlutterFlowTheme.of(context).primaryText,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.archive),
            color: Color(0xFF1A4572),
            onPressed: () {},
          ),
          IconButton(
            color: Color(0xFF1A4572),
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.reply),
            color: Color(0xFF1A4572),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject
            Text(
              subject,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Sender info
            Row(
              children: [
                CircleAvatar(child: Text(senderName[0])),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(senderName,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(senderEmail,
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                Text(time,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
            Divider(height: 32),
            // Body
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  body,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Divider(height: 32),
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.reply),
                  onPressed: () {},
                  tooltip: 'Reply',
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {},
                  tooltip: 'Delete',
                ),
                IconButton(
                  icon: Icon(Icons.archive_outlined),
                  onPressed: () {},
                  tooltip: 'Archive',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
