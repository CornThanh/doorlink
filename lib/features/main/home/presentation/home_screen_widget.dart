import 'package:MeU/features/main/home/presentation/home_view_model.dart';
import 'package:flutter/cupertino.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  late HomeViewModel _viewModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = createModel(context, () => HomeViewModel());
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
          title: Text(
            'Home',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Nunito Sans',
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts:
                      GoogleFonts.asMap().containsKey('Nunito Sans'),
                ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                CupertinoIcons.bell,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                child: Text(
                  'Welcome, John Doe',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Nunito Sans',
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        useGoogleFonts:
                            GoogleFonts.asMap().containsKey('Nunito Sans'),
                      ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 0.0, 0.0),
                child: Text(
                  '1234 Elm St. • Apt 3A',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Nunito Sans',
                        color: Colors.blueGrey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        useGoogleFonts:
                            GoogleFonts.asMap().containsKey('Nunito Sans'),
                      ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF3379CE), // Google blue
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Special 50th',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Anniversary Event',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    // Calendar icon
                    Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                child: Text(
                  'Offers & Updates',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Nunito Sans',
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        useGoogleFonts:
                            GoogleFonts.asMap().containsKey('Nunito Sans'),
                      ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(16),
                  itemCount: offers.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final offer = offers[index];
                    return Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
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
                              ],
                            ),
                          ),
                          // Time ago
                          Text(
                            offer.timeAgo,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFFCCCCCC),
                            ),
                          ),
                        ],
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
