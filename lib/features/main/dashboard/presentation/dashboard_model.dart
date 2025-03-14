import '/component/drawer/drawer_widget.dart';
import '/component/scan_component/scan_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dashboard_screen_widget.dart' show DashboardScreenWidget;
import 'package:flutter/material.dart';

class DashboardModel extends FlutterFlowModel<DashboardScreenWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
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
