import 'package:flutter/material.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'phone_number_screen_widget.dart' show PhoneNumberScreenWidget;

class PhoneNumberScreenModel extends FlutterFlowModel<PhoneNumberScreenWidget> {
  ///  Local state fields for this page.

  double? height = 0.0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberController;
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;

  String? Function(BuildContext, String?)? confirmPasswordControllerValidator;

  // Stores action output result for [Backend Call - API (PhoneLogin)] action in Button widget.
  ApiCallResponse? phoneNumberRes;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    phoneNumberFocusNode?.dispose();
    phoneNumberController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
