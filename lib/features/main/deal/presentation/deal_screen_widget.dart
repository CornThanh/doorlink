import 'package:doorlink_mobile/features/main/deal/presentation/deal_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../model/deal.dart';

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
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<DealViewModel>(
        builder: (context, viewModel, child) {
          return GestureDetector(
            onTap: () =>
                FocusScope.of(context).requestFocus(_viewModel.unfocusNode),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
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
              body: _buildBody(viewModel),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(DealViewModel viewModel) {
    if (viewModel.isLoading && viewModel.deals.isEmpty) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if (viewModel.errorMessage != null && viewModel.deals.isEmpty) {
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
              'Failed to load deals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.errorMessage!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.refreshDeals,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (viewModel.deals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_offer_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No deals available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Check back later for new offers',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: viewModel.refreshDeals,
      child: ListView.builder(
        itemCount: viewModel.deals.length,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemBuilder: (context, index) {
          final deal = viewModel.deals[index];
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
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 160,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: Colors.grey[600],
                          ),
                        );
                      },
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
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Expires: ${deal.expireDate.toLocal().toIso8601String().split("T").first}',
                          style:
                              const TextStyle(fontSize: 13, color: Colors.red),
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
