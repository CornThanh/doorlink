import 'package:doorlink_mobile/backend/api_requests/api_calls.dart';
import 'package:doorlink_mobile/flutter_flow/flutter_flow_theme.dart';
import 'package:doorlink_mobile/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class MailDetailScreenWidget extends StatelessWidget {
  final String? mailId;
  final String? senderName;
  final String? senderEmail;
  final String? subject;
  final String? body;
  final String? time;
  final String? status;
  final String? type;

  const MailDetailScreenWidget({
    super.key,
    this.mailId,
    this.senderName,
    this.senderEmail,
    this.subject,
    this.body,
    this.time,
    this.status,
    this.type,
  });

  void _shareMail(BuildContext context) {
    final shareText = '''
From: ${senderName ?? 'Unknown'} (${senderEmail ?? 'No email'})
Subject: ${subject ?? 'No Subject'}
Type: ${type ?? 'Unknown type'}

Content:
${body ?? 'No content available'}

---
Shared from DoorLink Mobile App
''';

    Share.share(
      shareText,
      subject: 'Mail: ${subject ?? 'No Subject'}',
    );
  }

  void _archiveMail(BuildContext context) {
    _showConfirmationDialog(
      context,
      'Archive Mail',
      'Are you sure you want to archive this mail?',
      'Archive',
      () => _performStatusUpdate(context, 'archived'),
    );
  }

  void _deleteMail(BuildContext context) {
    _showConfirmationDialog(
      context,
      'Archive Mail',
      'Are you sure you want to delete this mail?',
      'Delete',
      () => _performStatusUpdate(context, 'deleted'),
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    String title,
    String message,
    String actionText,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    actionText == 'Delete' ? Colors.red : Color(0xFF1A4572),
              ),
              child: Text(
                actionText,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _performStatusUpdate(BuildContext context, String status) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );

    try {
      // Call the API to update status
      final response = await VcardGroup.updateMailboxStatusCall.call(
        authToken: FFAppState().authToken,
        mailboxId: int.tryParse(mailId ?? '') ?? 0,
        status: status,
      );

      // Hide loading indicator
      Navigator.of(context).pop();

      if (response.succeeded) {
        final success =
            VcardGroup.updateMailboxStatusCall.success(response.jsonBody);
        if (success == true) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Mail $status successfully'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate back to mail list
          Navigator.of(context).pop('refresh');
        } else {
          // Show error message
          final errorMsg =
              VcardGroup.updateMailboxStatusCall.message(response.jsonBody) ??
                  'Failed to update status';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Show network error
        final errorMsg =
            VcardGroup.updateMailboxStatusCall.message(response.jsonBody) ??
                'Network error occurred';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Hide loading indicator
      Navigator.of(context).pop();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF003C7F),
            Color(0xFF243291),
            Color(0xFF3A299F),
            Color(0xFF7427AF),
          ], // 2 màu gradient
          stops: [0.0, 0.25, 0.5, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Mail Detail',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Nunito Sans',
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts:
                      GoogleFonts.asMap().containsKey('Nunito Sans'),
                ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Colors.white,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.archive),
              color: Colors.white,
              onPressed: () => _archiveMail(context),
              tooltip: 'Archive',
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.delete),
              onPressed: () => _deleteMail(context),
              tooltip: 'Delete',
            ),
            IconButton(
              icon: Icon(Icons.share),
              color: Colors.white,
              onPressed: () => _shareMail(context),
              tooltip: 'Share',
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
                subject ?? 'No Subject',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 16),
              // Sender info
              Row(
                children: [
                  CircleAvatar(child: Text((senderName ?? 'U')[0])),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(senderName ?? 'Unknown Sender',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text(senderEmail ?? 'No email',
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                  Text(time ?? 'Unknown time',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
              if (type != null) ...[
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF1A4572).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    type!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              Divider(
                height: 32,
                color: Colors.white,
              ),
              // Body
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    body ?? 'No content available',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              Divider(height: 32),
              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    onPressed: () => _shareMail(context),
                    tooltip: 'Share',
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.white),
                    onPressed: () => _deleteMail(context),
                    tooltip: 'Delete',
                  ),
                  IconButton(
                    icon: Icon(Icons.archive_outlined, color: Colors.white),
                    onPressed: () => _archiveMail(context),
                    tooltip: 'Archive',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
