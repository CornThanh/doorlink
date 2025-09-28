import 'package:doorlink_mobile/features/main/notification/model/notification.dart';
import 'package:doorlink_mobile/features/main/notification/presentation/notification_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationScreenWidget extends StatefulWidget {
  const NotificationScreenWidget({super.key});

  @override
  State<NotificationScreenWidget> createState() =>
      _NotificationScreenWidgetState();
}

class _NotificationScreenWidgetState extends State<NotificationScreenWidget> {
  late NotificationViewModel _viewModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = createModel(context, () => NotificationViewModel());
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _onNotificationTap(NotificationModel notification) {
    // If notification has a URL in data, open it in webview
    final url = notification.data?['url']?.toString();
    if (url != null && url.isNotEmpty) {
      context.pushNamed(
        'webview_screen',
        queryParameters: {
          'title': serializeParam(
            notification.title ?? 'Notification',
            ParamType.String,
          ),
          'url': serializeParam(url, ParamType.String),
        }.withoutNulls,
        extra: <String, dynamic>{
          kTransitionInfoKey: const TransitionInfo(
            hasTransition: true,
            transitionType: PageTransitionType.fade,
            duration: Duration(milliseconds: 400),
          ),
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<NotificationViewModel>(
        builder: (context, viewModel, child) {
          return GestureDetector(
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
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: true,
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
                  titleSpacing: 0,
                  title: Text(
                    'Notifications',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Nunito Sans',
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Nunito Sans'),
                        ),
                  ),
                  centerTitle: true,
                  elevation: 0,
                ),
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: _buildBody(viewModel),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(NotificationViewModel viewModel) {
    if (viewModel.isLoading && viewModel.notifications.isEmpty) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (viewModel.errorMessage != null && viewModel.notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'Failed to load notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              viewModel.errorMessage!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.refreshNotifications,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (viewModel.notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'No notifications yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'You\'ll see your notifications here when they arrive',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: viewModel.refreshNotifications,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: viewModel.notifications.length,
        separatorBuilder: (_, __) => SizedBox(height: 6),
        itemBuilder: (context, index) {
          final notification = viewModel.notifications[index];
          return GestureDetector(
            onTap: () => _onNotificationTap(notification),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .1),
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Icon
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.pink.shade100,
                    backgroundImage: NetworkImage(notification.iconUrl),
                  ),
                  SizedBox(width: 12),
                  // Title + Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title ?? 'No Title',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E144F),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          notification.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF7B7B8B),
                          ),
                        ),
                        // Time ago
                        SizedBox(height: 6),
                        Text(
                          notification.timeAgo,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFCCCCCC),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
