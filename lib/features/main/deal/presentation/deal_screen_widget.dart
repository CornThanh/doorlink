import 'package:doorlink_mobile/features/main/deal/presentation/deal_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/deal.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealScreenWidget extends StatefulWidget {
  const DealScreenWidget({super.key});

  @override
  State<DealScreenWidget> createState() => _DealScreenWidgetState();
}

class _DealScreenWidgetState extends State<DealScreenWidget> {
  late DealViewModel _viewModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = createModel(context, () => DealViewModel());
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  final List<Deal> dealList = [
    Deal(
      title: 'Buy 1 Get 1 Free',
      description: 'Valid for all coffee drinks until Aug 10.',
      imageUrl: 'https://picsum.photos/id/1011/800/400',
      createdDate: DateTime(2025, 7, 30),
      expireDate: DateTime(2025, 8, 10),
    ),
    Deal(
      title: 'Summer Sale 30% Off',
      description: 'Enjoy a discount on selected items.',
      imageUrl: 'https://picsum.photos/id/1011/800/400',
      createdDate: DateTime(2025, 7, 28),
      expireDate: DateTime(2025, 8, 5),
    ),
    Deal(
      title: 'Free Shipping Weekend',
      description: 'Applies to orders over 500K.',
      imageUrl: 'https://picsum.photos/id/1011/800/400',
      createdDate: DateTime(2025, 7, 26),
      expireDate: DateTime(2025, 8, 2),
    ),
    Deal(
      title: 'Back to School Promo',
      description: 'Get up to 40% off on school supplies.',
      imageUrl: 'https://picsum.photos/id/1011/800/400',
      createdDate: DateTime(2025, 7, 25),
      expireDate: DateTime(2025, 8, 15),
    ),
  ];

  void _onDealTap(Deal deal) {
    context.pushNamed(
      'webview_screen',
      queryParameters: {
        'title': serializeParam(
          deal.title,
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
            'Offers & Updates',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Nunito Sans',
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts:
                      GoogleFonts.asMap().containsKey('Nunito Sans'),
                ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: ListView.builder(
          itemCount: dealList.length,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          itemBuilder: (context, index) {
            final deal = dealList[index];
            return GestureDetector(
              onTap: () => _onDealTap(deal),
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        deal.imageUrl,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deal.title,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            deal.description,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Expires: ${deal.createdDate.toLocal().toIso8601String().split("T").first}',
                            style: const TextStyle(
                                fontSize: 13, color: Colors.red),
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
