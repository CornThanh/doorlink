import 'package:flutter/material.dart';

import '/backend/api_requests/api_calls.dart';
import '/component/drawer/drawer_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../coupon/model/coupon.dart';
import '../../deal/model/deal.dart';
import 'home_screen_widget.dart' show HomeScreenWidget;

class HomeViewModel extends FlutterFlowModel<HomeScreenWidget>
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

  // Deal-related state for News & Deals section
  List<Deal> deals = [];
  bool isLoadingDeals = false;
  String? dealsErrorMessage;
  ApiCallResponse? getDealsRes;

  // Banner-related state for carousel section
  List<dynamic> banners = [];
  bool isLoadingBanners = false;
  String? bannersErrorMessage;
  ApiCallResponse? getBannersRes;

  // Coupon-related state for Hot Coupons section
  List<Coupon> coupons = [];
  bool isLoadingCoupons = false;
  String? couponsErrorMessage;
  ApiCallResponse? getCouponsRes;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    drawerModel = createModel(context, () => DrawerModel());
    _loadDeals();
    _loadBanners();
    _loadCoupons();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    drawerModel.dispose();
    super.dispose();
  }

  /// Action blocks are added here.

  /// Load deals from API for News & Deals section
  Future<void> _loadDeals() async {
    isLoadingDeals = true;
    dealsErrorMessage = null;
    notifyListeners();

    try {
      final response = await VcardGroup.getDealsCall.call(
        authToken: FFAppState().authToken,
      );

      getDealsRes = response;

      if (response.succeeded) {
        // Check if the API call was successful using the same pattern as login
        final success = VcardGroup.getDealsCall.success(response.jsonBody);

        if (success == true) {
          final dealsData = VcardGroup.getDealsCall.data(response.jsonBody);

          if (dealsData != null && dealsData.isNotEmpty) {
            deals = dealsData.map((json) => Deal.fromJson(json)).toList();
          } else {
            // Fallback to empty list if no data
            deals = [];
          }
        } else {
          // API returned success: false
          dealsErrorMessage =
              VcardGroup.getDealsCall.message(response.jsonBody) ??
                  'Failed to load deals';
          deals = [];
        }
      } else {
        // HTTP request failed
        dealsErrorMessage =
            VcardGroup.getDealsCall.message(response.jsonBody) ??
                'Network error occurred';
        deals = [];
      }
    } catch (e) {
      dealsErrorMessage = 'Error loading deals: $e';
      deals = [];
    } finally {
      isLoadingDeals = false;
      notifyListeners();
    }
  }

  /// Load banners from API for carousel section
  Future<void> _loadBanners() async {
    isLoadingBanners = true;
    bannersErrorMessage = null;
    notifyListeners();

    try {
      final response = await VcardGroup.getBannersCall.call(
        authToken: FFAppState().authToken,
      );

      getBannersRes = response;

      if (response.succeeded) {
        // Check if the API call was successful using the same pattern as login
        final success = VcardGroup.getBannersCall.success(response.jsonBody);

        if (success == true) {
          final bannersData = VcardGroup.getBannersCall.data(response.jsonBody);

          if (bannersData != null && bannersData.isNotEmpty) {
            banners = bannersData;
          } else {
            // Fallback to empty list if no data
            banners = [];
          }
        } else {
          // API returned success: false
          bannersErrorMessage =
              VcardGroup.getBannersCall.message(response.jsonBody) ??
                  'Failed to load banners';
          banners = [];
        }
      } else {
        // HTTP request failed
        bannersErrorMessage =
            VcardGroup.getBannersCall.message(response.jsonBody) ??
                'Network error occurred';
        banners = [];
      }
    } catch (e) {
      bannersErrorMessage = 'Error loading banners: $e';
      banners = [];
    } finally {
      isLoadingBanners = false;
      notifyListeners();
    }
  }

  /// Refresh deals
  Future<void> refreshDeals() async {
    await _loadDeals();
  }

  /// Refresh banners
  Future<void> refreshBanners() async {
    await _loadBanners();
  }

  /// Load coupons from API for Hot Coupons section
  Future<void> _loadCoupons() async {
    isLoadingCoupons = true;
    couponsErrorMessage = null;
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
          couponsErrorMessage =
              VcardGroup.getCouponsCall.message(response.jsonBody) ??
                  'Failed to load coupons';
          coupons = [];
        }
      } else {
        // HTTP request failed
        couponsErrorMessage =
            VcardGroup.getCouponsCall.message(response.jsonBody) ??
                'Network error occurred';
        coupons = [];
      }
    } catch (e) {
      couponsErrorMessage = 'Error loading coupons: $e';
      coupons = [];
    } finally {
      isLoadingCoupons = false;
      notifyListeners();
    }
  }

  /// Refresh coupons
  Future<void> refreshCoupons() async {
    await _loadCoupons();
  }

  /// Additional helper methods are added here.
}
