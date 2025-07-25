import 'package:doorlink_mobile/features/main/notification/presentation/notification_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  final List<OfferItem> offers = [
    OfferItem(
      title: "Domino's",
      description: "Get 20% off your next online order!",
      timeAgo: "2d ago",
      iconUrl:
          'https://cdn-icons-png.flaticon.com/512/733/733544.png', // pink Dribbble icon
    ),
    OfferItem(
      title: "Retail Chains with Loyalty",
      description: "See the latest city newsletter",
      timeAgo: "2d ago",
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/733/733544.png',
    ),
    OfferItem(
      title: "Retail Chains with Loyalty",
      description: "See the latest city newsletter",
      timeAgo: "2d ago",
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/733/733544.png',
    ),
    OfferItem(
      title: "Retail Chains with Loyalty",
      description: "See the latest city newsletter",
      timeAgo: "2d ago",
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/733/733544.png',
    ),
  ];

  void _onNotificationTap(OfferItem offer) {
    context.pushNamed(
      'webview_screen',
      queryParameters: {
        'title': serializeParam(
          offer.title,
          ParamType.String,
        ),
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

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_viewModel.unfocusNode),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: FlutterFlowTheme.of(context).primaryText,
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
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts:
                      GoogleFonts.asMap().containsKey('Nunito Sans'),
                ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: offers.length,
            separatorBuilder: (_, __) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              final offer = offers[index];
              return GestureDetector(
                onTap: () => _onNotificationTap(offer),
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
                        backgroundImage: NetworkImage(offer.iconUrl),
                      ),
                      SizedBox(width: 12),
                      // Title + Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offer.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E144F),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              offer.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF7B7B8B),
                              ),
                            ),
                            // Time ago
                            SizedBox(height: 6),
                            Text(
                              offer.timeAgo,
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
        ),
      ),
    );
  }
}

class OfferItem {
  final String title;
  final String description;
  final String timeAgo;
  final String iconUrl;

  OfferItem({
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.iconUrl,
  });
}
