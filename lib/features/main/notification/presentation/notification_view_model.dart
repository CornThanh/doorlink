import 'package:flutter/material.dart';

import '/backend/api_requests/api_calls.dart';
import '/component/drawer/drawer_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../model/notification.dart';
import 'notification_screen_widget.dart' show NotificationScreenWidget;

class NotificationViewModel extends FlutterFlowModel<NotificationScreenWidget>
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

  // Notification state
  List<NotificationModel> notifications = [];
  bool isLoading = false;
  String? errorMessage;
  ApiCallResponse? getNotificationsRes;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    drawerModel = createModel(context, () => DrawerModel());
    _loadNotifications();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    drawerModel.dispose();
    super.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  Future<void> _loadNotifications() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await VcardGroup.getFcmNotificationsCall.call(
        authToken: FFAppState().authToken,
      );
      getNotificationsRes = response;

      if (response.succeeded) {
        final success =
            VcardGroup.getFcmNotificationsCall.success(response.jsonBody);
        if (success == true) {
          final notificationsData =
              VcardGroup.getFcmNotificationsCall.data(response.jsonBody);
          if (notificationsData != null && notificationsData.isNotEmpty) {
            notifications = notificationsData
                .map((json) => NotificationModel.fromJson(json))
                .toList();
          } else {
            notifications = [];
          }
        } else {
          errorMessage =
              VcardGroup.getFcmNotificationsCall.message(response.jsonBody) ??
                  'Failed to load notifications';
          notifications = [];
        }
      } else {
        errorMessage =
            VcardGroup.getFcmNotificationsCall.message(response.jsonBody) ??
                'Network error occurred';
        notifications = [];
      }
    } catch (e) {
      errorMessage = 'Error loading notifications: $e';
      notifications = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshNotifications() async {
    await _loadNotifications();
  }
}
