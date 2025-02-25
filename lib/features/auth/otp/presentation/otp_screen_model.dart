import 'package:flutter/material.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'otp_screen_widget.dart' show OtpScreenWidget;

class OtpScreenModel extends FlutterFlowModel<OtpScreenWidget> {
  ///  Local state fields for this page.

  double? height = 0.0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  // State field(s) for otp widget.
  FocusNode? otpFocusNode;
  TextEditingController? otpController;
  String? Function(BuildContext, String?)? otpControllerValidator;

  // Stores action output result for [Backend Call - API (PhoneLogin)] action in Button widget.
  ApiCallResponse? otpRes;

  // Stores action output result for [Backend Call - API (Profile)] action in Button widget.
  ApiCallResponse? profileRes;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    otpController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
