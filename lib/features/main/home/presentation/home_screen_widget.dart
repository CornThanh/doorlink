import 'package:carousel_slider/carousel_slider.dart';
import 'package:doorlink_mobile/features/main/coupon/model/coupon.dart';
import 'package:doorlink_mobile/features/main/home/presentation/home_view_model.dart';
import 'package:doorlink_mobile/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/cupertino.dart';

import '../../deal/model/deal.dart';
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

  final List<Deal> dealList = [
    Deal(
      title: 'Buy 1 Get 1 Free',
      description: 'Valid for all coffee drinks until Aug 10.',
      imageUrl: 'https://picsum.photos/id/1016/800/400',
      createdDate: DateTime(2025, 7, 30),
      expireDate: DateTime(2025, 8, 10),
    ),
    Deal(
      title: 'Summer Sale 30% Off',
      description: 'Enjoy a discount on selected items.',
      imageUrl: 'https://picsum.photos/id/1016/800/400',
      createdDate: DateTime(2025, 7, 28),
      expireDate: DateTime(2025, 8, 5),
    ),
    Deal(
      title: 'Free Shipping Weekend',
      description: 'Applies to orders over 500K.',
      imageUrl: 'https://picsum.photos/id/1016/800/400',
      createdDate: DateTime(2025, 7, 26),
      expireDate: DateTime(2025, 8, 2),
    ),
    Deal(
      title: 'Back to School Promo',
      description: 'Get up to 40% off on school supplies.',
      imageUrl: 'https://picsum.photos/id/1016/800/400',
      createdDate: DateTime(2025, 7, 25),
      expireDate: DateTime(2025, 8, 15),
    ),
  ];

  final List<Map<String, String>> couponList = [
    {
      'title': '10% Off All Orders',
      'subtitle': 'Valid for orders above \$20',
      'image': 'https://picsum.photos/id/1016/800/400',
      'createdDate': '2025-08-01',
    },
    {
      'title': 'Free Shipping Coupon',
      'subtitle': 'No minimum spend required',
      'image': 'https://picsum.photos/id/1016/800/400',
      'createdDate': '2025-07-28',
    },
    {
      'title': '\$5 OFF on Your Next Purchase',
      'subtitle': 'For orders over \$50',
      'image': 'https://picsum.photos/id/1016/800/400',
      'createdDate': '2025-07-25',
    },
    {
      'title': 'Summer Flash Deal',
      'subtitle': 'Flat 15% off for 24 hours only!',
      'image': 'https://picsum.photos/id/1016/800/400',
      'createdDate': '2025-07-29',
    },
  ];

  int _current = 0;
  final List<String> imgList = [
    'https://picsum.photos/id/1011/800/400',
    'https://picsum.photos/id/1015/800/400',
    'https://picsum.photos/id/1016/800/400',
    'https://picsum.photos/id/1020/800/400',
  ];

  final CarouselSliderController _controller = CarouselSliderController();

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

  void _onCouponTab(Coupon coupon) {
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: imgList.map((url) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 6.0,
                        height: 6.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == entry.key
                              ? Color(0xFF1A4572)
                              : Colors.grey[300],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hot Coupons',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Nunito Sans',
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap()
                                  .containsKey('Nunito Sans'),
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushNamed('coupon_screen');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xFF1A4572),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'See more',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 250, // enough to fit image + texts
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: couponList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final coupon = couponList[index];
                      return GestureDetector(
                        onTap: () => _onCouponTab(Coupon(
                          title: coupon['title']!,
                          description: coupon['subtitle']!,
                          iconUrl: coupon['image']!,
                          code: 'COUPON${index + 1}',
                          discountAmount: 200,
                          discountPercent: 10,
                          minimumOrderValue: 2,
                          expiryDate: DateTime.now(),
                          isActive: true,
                        )),
                        child: Container(
                          width: 256,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.network(
                                  coupon['image']!,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  coupon['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  coupon['subtitle']!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 2),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                                child: Text(
                                  '${coupon['createdDate']!} - ${coupon['createdDate']!}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: FFButtonWidget(
                                  onPressed: () => {},
                                  text: 'Apply Now',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    color: const Color(0xFF1A4572),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Nunito Sans',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Nunito Sans'),
                                        ),
                                    elevation: 1.0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'News & Deals',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Nunito Sans',
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap()
                                  .containsKey('Nunito Sans'),
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushNamed('offer_screen');
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xFF1A4572),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'See more',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200, // enough to fit image + texts
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: dealList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final deal = dealList[index];
                      return GestureDetector(
                        onTap: () => _onDealTap(deal),
                        child: Container(
                          width: 256,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.network(
                                  deal.imageUrl,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  deal.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  deal.description,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 2),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                                child: Text(
                                  '${deal.createdDate.year}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
