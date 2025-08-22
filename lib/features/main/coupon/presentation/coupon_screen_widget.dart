import 'package:doorlink_mobile/features/main/coupon/presentation/coupon_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../model/coupon.dart';

class CouponScreenWidget extends StatefulWidget {
  const CouponScreenWidget({super.key});

  @override
  State<CouponScreenWidget> createState() => _CouponScreenWidgetState();
}

class _CouponScreenWidgetState extends State<CouponScreenWidget> {
  late CouponViewModel _viewModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = createModel(context, () => CouponViewModel());
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _onCouponTap(Coupon coupon) {
    context.pushNamed(
      'webview_screen',
      queryParameters: {
        'title': serializeParam(
          coupon.title,
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
      child: Consumer<CouponViewModel>(
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
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                  onPressed: () async {
                    context.pop();
                  },
                ),
                titleSpacing: 0,
                title: Text(
                  'Coupons',
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

  Widget _buildBody(CouponViewModel viewModel) {
    if (viewModel.isLoading && viewModel.coupons.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (viewModel.errorMessage != null && viewModel.coupons.isEmpty) {
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
              'Failed to load coupons',
              style: TextStyle(
                fontSize: 16,
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
              onPressed: () => viewModel.refreshCoupons(),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (viewModel.coupons.isEmpty) {
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
              'No coupons available',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: ListView.builder(
        itemCount: viewModel.coupons.length,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemBuilder: (context, index) {
          final coupon = viewModel.coupons[index];
          return GestureDetector(
            onTap: () => _onCouponTap(coupon),
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
                      coupon.iconUrl,
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
                          coupon.title,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          coupon.description,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Expires: ${coupon.expiryDate.toLocal().toIso8601String().split("T").first}',
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
