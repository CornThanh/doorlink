import 'package:doorlink_mobile/features/main/mail/presentation/mail_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MailScreenWidget extends StatefulWidget {
  const MailScreenWidget({super.key});

  @override
  State<MailScreenWidget> createState() => _MailScreenWidgetState();
}

class _MailScreenWidgetState extends State<MailScreenWidget> {
  late MailViewModel _viewModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> types = [
    'All Mail',
    'Government & City Updates',
    'Offers & Promotions',
    'Alerts',
    'Archived / Deleted'
  ];

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
    return wrapWithModel(
      model: _viewModel,
      updateCallback: () => setState(() {}),
      child: GestureDetector(
        onTap: () =>
            FocusScope.of(context).requestFocus(_viewModel.unfocusNode),
        child: Container(
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
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: Image.asset(
                'assets/images/app_icon_no_bg.png',
                width: 64.0,
                height: 64.0,
                fit: BoxFit.cover,
                color: Colors.white,
              ),
              actions: [
                IconButton(
                  icon: Icon(CupertinoIcons.bell, color: Colors.white),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: List.generate(types.length, (index) {
                        final isSelected =
                            _viewModel.selectedType == types[index];
                        return ChoiceChip(
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          labelPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: 0),
                          label: Text(
                            types[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: Color(0xFF1A4572),
                          onSelected: (_) {
                            _viewModel.changeType(types[index]);
                          },
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(
                    height: 1,
                    color: Colors.white10,
                  ),
                  Expanded(
                    child: _buildMailList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMailList() {
    if (_viewModel.isLoading && _viewModel.filteredMails.isEmpty) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if (_viewModel.errorMessage != null && _viewModel.filteredMails.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load mails',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _viewModel.errorMessage!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _viewModel.refreshMails(),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_viewModel.filteredMails.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mail_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No mails available',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            if (_viewModel.selectedType != 'All Mail')
              Text(
                'for ${_viewModel.selectedType}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: _viewModel.filteredMails.length,
      separatorBuilder: (_, __) => Divider(
        height: 1,
        color: Colors.white10,
      ),
      itemBuilder: (context, index) {
        final mail = _viewModel.filteredMails[index];
        return Dismissible(
          key: ValueKey(mail.subject + mail.time),
          background: slideLeftBackground(),
          secondaryBackground: slideRightBackground(),
          onDismissed: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              // Swipe left to right - Delete
              final success = await _viewModel.deleteMailbox(mail.id!);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Mail deleted successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
                // Refresh the list to show updated data
                _viewModel.refreshMails();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        _viewModel.errorMessage ?? 'Failed to delete mail'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            } else if (direction == DismissDirection.endToStart) {
              // Swipe right to left - Archive
              final success = await _viewModel.archiveMailbox(mail.id!);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Mail archived successfully'),
                    backgroundColor: Colors.blue,
                  ),
                );
                // Refresh the list to show updated data
                _viewModel.refreshMails();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        _viewModel.errorMessage ?? 'Failed to archive mail'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          child: ListTile(
            onTap: () async {
              // Navigate to detail screen with mail data from the list
              final result = await context.pushNamed(
                'mail_detail_screen',
                queryParameters: {
                  'mailId': mail.id?.toString() ?? '',
                  'senderName': mail.sender,
                  'senderEmail': mail.senderEmail,
                  'subject': mail.subject,
                  'body': mail.description,
                  'time': mail.time,
                  'status': mail.status,
                  'type': mail.type,
                }.withoutNulls,
              );

              // Refresh the list if returning from detail screen with status update
              if (result == 'refresh') {
                _viewModel.refreshMails();
              }
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
                        fontWeight:
                            mail.isRead ? FontWeight.normal : FontWeight.bold,
                        color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  mail.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight:
                        mail.isRead ? FontWeight.normal : FontWeight.bold,
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
                      fontWeight:
                          mail.isRead ? FontWeight.normal : FontWeight.bold,
                      color: Colors.white70),
                ),
                Text(
                  mail.snippet,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
            isThreeLine: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
        );
      },
    );
  }
}
