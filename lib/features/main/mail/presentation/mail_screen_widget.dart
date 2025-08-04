import 'package:doorlink_mobile/features/main/mail/model/mail.dart';
import 'package:doorlink_mobile/features/main/mail/presentation/mail_view_model.dart';
import 'package:flutter/cupertino.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MailScreenWidget extends StatefulWidget {
  const MailScreenWidget({super.key});

  @override
  State<MailScreenWidget> createState() => _MailScreenWidgetState();
}

class _MailScreenWidgetState extends State<MailScreenWidget> {
  late MailViewModel _viewModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> types = [
    'All',
    'Offers & Promotions',
    'Government & City Updates',
    'Archived / Deleted'
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _viewModel = createModel(context, () => MailViewModel());
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  final List<Mail> mails = [
    Mail(
      sender: 'Google',
      senderEmail: 'no-reply@google.com',
      subject: 'Your security alert',
      snippet: 'We detected a new login to your account...',
      time: '8:15 AM',
      isRead: false,
    ),
    Mail(
      sender: 'LinkedIn',
      senderEmail: 'jobs@linkedin.com',
      subject: 'New job matches for you',
      snippet: 'Senior Flutter Developer roles in Ho Chi Minh City...',
      time: 'Yesterday',
      isRead: true,
    ),
    Mail(
      sender: 'GitHub',
      senderEmail: 'noreply@github.com',
      subject: 'Pull Request: Update readme.md',
      snippet: 'A new PR was submitted to your repo...',
      time: 'Aug 3',
      isRead: false,
    ),
  ];

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20),
      child: Icon(Icons.delete, color: Colors.white),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Color(0xFF1A4572),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      child: Icon(Icons.archive, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_viewModel.unfocusNode),
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Image.asset(
            'assets/images/app_icon_no_bg.png',
            width: 64.0,
            height: 64.0,
            fit: BoxFit.cover,
          ),
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.bell, color: const Color(0xFF1A4572)),
              onPressed: () {
                context.pushNamed('notification_screen');
              },
            )
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: types.length,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndex == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        elevation: 0,
                        pressElevation: 0,
                        label: Text(
                          types[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: Color(0xFF1A4572),
                        onSelected: (_) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              Divider(height: 1),
              Expanded(
                child: ListView.separated(
                  itemCount: mails.length,
                  separatorBuilder: (_, __) => Divider(height: 1),
                  itemBuilder: (context, index) {
                    final mail = mails[index];
                    return Dismissible(
                      key: ValueKey(mail.subject + mail.time),
                      background: slideLeftBackground(),
                      secondaryBackground: slideRightBackground(),
                      onDismissed: (direction) {
                        // Bạn có thể xử lý xóa, lưu trữ, v.v tại đây
                      },
                      child: ListTile(
                        onTap: () {
                          // Điều hướng đến trang chi tiết
                          context.pushNamed('mail_detail_screen');
                        },
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF1A4572),
                          child: Text(mail.sender[0]),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                mail.sender,
                                style: TextStyle(
                                  fontWeight: mail.isRead
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              mail.time,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: mail.isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mail.subject,
                              style: TextStyle(
                                fontWeight: mail.isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                            Text(
                              mail.snippet,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
