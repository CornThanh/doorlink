import 'package:MeU/features/main/business_card/presentation/business_card_screen.dart'
    show BusinessCardScreen;

import '/backend/api_requests/api_calls.dart';
import '/component/drawer/drawer_widget.dart';
import '/component/scan_component/scan_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class BusinessCardScreenModel extends FlutterFlowModel<BusinessCardScreen> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Groups)] action in business_card_screen widget.
  ApiCallResponse? groupRes;
  // Stores action output result for [Backend Call - API (Business Card)] action in business_card_screen widget.
  ApiCallResponse? businesscardRes;
  // Stores action output result for [Backend Call - API (Admin Group)] action in business_card_screen widget.
  ApiCallResponse? adminGroupRes;
  // Stores action output result for [Backend Call - API (Admin Business Card)] action in business_card_screen widget.
  ApiCallResponse? adminBusinesscardRes;
  // Model for scan_component component.
  late ScanComponentModel scanComponentModel;
  // Model for drawer component.
  late DrawerModel drawerModel;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    scanComponentModel = createModel(context, () => ScanComponentModel());
    drawerModel = createModel(context, () => DrawerModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    scanComponentModel.dispose();
    drawerModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
