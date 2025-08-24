import 'package:flutter/material.dart';

import '/backend/api_requests/api_calls.dart';
import '/component/drawer/drawer_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../model/coupon.dart';
import 'coupon_screen_widget.dart' show CouponScreenWidget;

class CouponViewModel extends FlutterFlowModel<CouponScreenWidget>
    with ChangeNotifier {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Switch widget.
  bool? switchValue1;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? affiliationOffRes;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? affiliationOnRes;
  // State field(s) for Switch widget.
  bool? switchValue2;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? contactOnRes;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? contactOffRes;
  // State field(s) for Switch widget.
  bool? switchValue3;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? stickybarOffRes;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? stickybarOnRes;
  // State field(s) for Switch widget.
  bool? switchValue4;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? whatsappOnRes;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? whatsappOffRes;
  // Model for drawer component.
  late DrawerModel drawerModel;

  // Coupon-related state
  List<Coupon> coupons = [];
  bool isLoading = false;
  String? errorMessage;
  ApiCallResponse? getCouponsRes;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    drawerModel = createModel(context, () => DrawerModel());
    _loadCoupons();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    drawerModel.dispose();
    super.dispose();
  }

  /// Action blocks are added here.

  /// Load coupons from API
  Future<void> _loadCoupons() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await VcardGroup.getCouponsCall.call(
        authToken: FFAppState().authToken,
      );

      getCouponsRes = response;

      if (response.succeeded) {
        // Check if the API call was successful using the same pattern as login
        final success = VcardGroup.getCouponsCall.success(response.jsonBody);

        if (success == true) {
          final couponsData = VcardGroup.getCouponsCall.data(response.jsonBody);

          if (couponsData != null && couponsData.isNotEmpty) {
            coupons = couponsData.map((json) => Coupon.fromJson(json)).toList();
          } else {
            // Fallback to empty list if no data
            coupons = [];
          }
        } else {
          // API returned success: false
          errorMessage = VcardGroup.getCouponsCall.message(response.jsonBody) ??
              'Failed to load coupons';
          coupons = [];
        }
      } else {
        // HTTP request failed
        errorMessage = VcardGroup.getCouponsCall.message(response.jsonBody) ??
            'Network error occurred';
        coupons = [];
      }
    } catch (e) {
      errorMessage = 'Error loading coupons: $e';
      coupons = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh coupons
  Future<void> refreshCoupons() async {
    await _loadCoupons();
  }

  /// Additional helper methods are added here.
}
