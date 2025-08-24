import 'package:flutter/material.dart';

import '/backend/api_requests/api_calls.dart';
import '/component/drawer/drawer_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../model/deal.dart';
import 'deal_screen_widget.dart' show DealScreenWidget;

class DealViewModel extends FlutterFlowModel<DealScreenWidget>
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

  // Deal-related state
  List<Deal> deals = [];
  bool isLoading = false;
  String? errorMessage;
  ApiCallResponse? getDealsRes;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    drawerModel = createModel(context, () => DrawerModel());
    _loadDeals();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    drawerModel.dispose();
    super.dispose();
  }

  /// Action blocks are added here.

  /// Load deals from API
  Future<void> _loadDeals() async {
    isLoading = true;
    errorMessage = null;
    // Trigger UI update
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
          errorMessage = VcardGroup.getDealsCall.message(response.jsonBody) ??
              'Failed to load deals';
          deals = [];
        }
      } else {
        // HTTP request failed
        errorMessage = VcardGroup.getDealsCall.message(response.jsonBody) ??
            'Network error occurred';
        deals = [];
      }
    } catch (e) {
      errorMessage = 'Error loading deals: $e';
      deals = [];
    } finally {
      isLoading = false;
      // Trigger UI update
      notifyListeners();
    }
  }

  /// Refresh deals
  Future<void> refreshDeals() async {
    await _loadDeals();
  }

  /// Additional helper methods are added here.
}
