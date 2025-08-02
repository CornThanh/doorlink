import 'package:doorlink_mobile/features/main/coupon/presentation/coupon_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/coupon.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  final List<Coupon> allCoupons = [
    Coupon(
      title: '10% Off All Orders',
      description: 'Valid for orders above \$20',
      iconUrl: 'https://picsum.photos/id/1016/800/400',
      code: 'SAVE10',
      discountAmount: 0,
      discountPercent: 10,
      minimumOrderValue: 20,
      expiryDate: DateTime(2025, 8, 30),
      isActive: true,
    ),
    Coupon(
      title: 'Free Shipping',
      description: 'No minimum spend required',
      iconUrl: 'https://picsum.photos/id/1016/800/400',
      code: 'FREESHIP',
      discountAmount: 0,
      discountPercent: 0,
      minimumOrderValue: 0,
      expiryDate: DateTime(2025, 9, 1),
      isActive: true,
    ),
    Coupon(
      title: '\$5 Off Next Purchase',
      description: 'For orders over \$50',
      iconUrl: 'https://picsum.photos/id/1016/800/400',
      code: 'FIVEOFF',
      discountAmount: 5,
      discountPercent: 0,
      minimumOrderValue: 50,
      expiryDate: DateTime(2025, 8, 15),
      isActive: true,
    ),
  ];

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
        body: SafeArea(
          child: ListView.builder(
            itemCount: allCoupons.length,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemBuilder: (context, index) {
              final coupon = allCoupons[index];
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
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Image.network(
                          coupon.iconUrl,
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
                              coupon.title,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              coupon.description,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Expires: ${coupon.expiryDate.toLocal().toIso8601String().split("T").first}',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.red),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                // Handle apply action
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text('Coupon "${coupon.code}" applied!'),
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text('Apply Now'),
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
