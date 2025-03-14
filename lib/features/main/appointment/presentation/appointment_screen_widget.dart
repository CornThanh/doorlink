import 'package:MeU/features/main/appointment/presentation/widget/appointment_item.dart';
import 'package:MeU/features/main/appointment/presentation/widget/appointment_vcard_item.dart';
import 'package:MeU/features/main/appointment/repository/appointment_repository.dart';
import 'package:flutter/cupertino.dart';

import '/backend/api_requests/api_calls.dart';
import '/component/appointment_sheet/appointment_sheet_widget.dart';
import '/component/drawer/drawer_widget.dart';
import '/component/empty_data_component/empty_data_component_widget.dart';
import '/component/scan_component/scan_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
export 'appointment_screen_model.dart';

class AppointmentScreenWidget extends StatefulWidget {
  const AppointmentScreenWidget({
    super.key,
    this.vcardID,
  });

  final int? vcardID;

  @override
  State<AppointmentScreenWidget> createState() =>
      _AppointmentScreenWidgetState();
}

class _AppointmentScreenWidgetState extends State<AppointmentScreenWidget> {
  late AppointmentScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppointmentScreenModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primary,
        drawer: Drawer(
          elevation: 16.0,
          child: wrapWithModel(
            model: _model.drawerModel,
            updateCallback: () => setState(() {}),
            child: const DrawerWidget(),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xff333333),
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: FFAppState().isVcardAppointment
                ? () {
                    context.pop();
                  }
                : () async {
                    scaffoldKey.currentState!.openDrawer();
                  },
            child: Container(
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    12.0, 17.0, 12.0, 17.0),
                child: SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Icon(FFAppState().isVcardAppointment
                      ? Icons.arrow_back_ios
                      : Icons.menu),
                ),
              ),
            ),
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'gzd51k3u' /* Appointments */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Nunito Sans',
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts:
                      GoogleFonts.asMap().containsKey('Nunito Sans'),
                ),
          ),
          actions: [
            Builder(
              builder: (context) {
                if (!FFAppState().isVcardAppointment) {
                  return wrapWithModel(
                    model: _model.scanComponentModel,
                    updateCallback: () => setState(() {}),
                    child: const ScanComponentWidget(),
                  );
                } else {
                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      setState(() {
                        FFAppState().isVcardAppointment = false;
                      });
                    },
                    child: Container(
                      width: 60.0,
                      constraints: const BoxConstraints(
                        minWidth: 50.0,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Icon(
                        Icons.restart_alt,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
          centerTitle: true,
          elevation: 1.0,
        ),
        body: Builder(
          builder: (context) {
            if (FFAppState().isLoading) {
              return const Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: custom_widgets.CustomLoader(
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              );
            } else {
              return Builder(
                builder: (context) {
                  if (!FFAppState().isVcardAppointment) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 0.0, 12.0, 0.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: (_model.apiRequestCompleter2 ??= Completer<
                                ApiCallResponse>()
                              ..complete(AppointmentRepository.getAppointment(
                                authToken: FFAppState().authToken,
                              )))
                            .future,
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return const Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CupertinoActivityIndicator(
                                    color: Colors.white),
                              ),
                            );
                          }
                          final listViewAppointmentResponse = snapshot.data!;
                          return Builder(
                            builder: (context) {
                              final data = functions
                                  .sortListData(AppointmentRepository.data(
                                    listViewAppointmentResponse.jsonBody,
                                  )!
                                      .toList())
                                  .toList();
                              if (data.isEmpty) {
                                return const Center(
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: EmptyDataComponentWidget(),
                                  ),
                                );
                              }
                              return RefreshIndicator(
                                key: const Key('RefreshIndicator_bcyq1nu3'),
                                onRefresh: () async {
                                  setState(
                                      () => _model.apiRequestCompleter2 = null);
                                  await _model.waitForApiRequestCompleted2();
                                },
                                child: ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    10.0,
                                    0,
                                    10.0,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.length,
                                  itemBuilder: (context, dataIndex) {
                                    final dataItem = data[dataIndex];
                                    return AppointmentVcardItem(
                                      onPressed: () {},
                                      vCardName: getJsonField(
                                        dataItem,
                                        r'''$.vcard_name''',
                                      ).toString(),
                                      name: getJsonField(
                                        dataItem,
                                        r'''$.name''',
                                      ).toString(),
                                      isFree: functions
                                          .getAppointmentPaidInfo(getJsonField(
                                        dataItem,
                                        r'''$.paid_amount''',
                                      )),
                                      status:
                                          functions.getAppointmentStatusInfo(
                                              getJsonField(
                                        dataItem,
                                        r'''$.status''',
                                      )),
                                      fromTime: getJsonField(
                                        dataItem,
                                        r'''$.from_time''',
                                      ).toString(),
                                      toTime: getJsonField(
                                        dataItem,
                                        r'''$.to_time''',
                                      ).toString(),
                                      date: getJsonField(
                                        dataItem,
                                        r'''$.date''',
                                      ).toString(),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          4.0, 0.0, 4.0, 0.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: (_model.apiRequestCompleter1 ??=
                                Completer<ApiCallResponse>()
                                  ..complete(
                                    AppointmentRepository.getVcardAppointment(
                                      authToken: FFAppState().authToken,
                                      id: widget.vcardID,
                                    ),
                                  ))
                            .future,
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return const Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CupertinoActivityIndicator(
                                    color: Colors.white),
                              ),
                            );
                          }
                          final listViewVcardAppointmentResponse =
                              snapshot.data!;
                          return Builder(
                            builder: (context) {
                              final data = functions
                                  .sortListData(AppointmentRepository.data(
                                    listViewVcardAppointmentResponse.jsonBody,
                                  )!
                                      .toList())
                                  .toList();
                              if (data.isEmpty) {
                                return const SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: EmptyDataComponentWidget(),
                                );
                              }
                              return RefreshIndicator(
                                key: const Key('RefreshIndicator_znsqio3x'),
                                onRefresh: () async {
                                  setState(
                                      () => _model.apiRequestCompleter1 = null);
                                  await _model.waitForApiRequestCompleted1();
                                },
                                child: ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    10.0,
                                    0,
                                    10.0,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.length,
                                  itemBuilder: (context, dataIndex) {
                                    final dataItem = data[dataIndex];
                                    return AppointmentItem(
                                      onPressed: () =>
                                          _onPressedAppointment(dataItem),
                                      vcardName: getJsonField(
                                        dataItem,
                                        r'''$.vcard_name''',
                                      ).toString(),
                                      status:
                                          functions.getAppointmentStatusInfo(
                                              getJsonField(
                                        dataItem,
                                        r'''$.status''',
                                      )),
                                      isFree: functions
                                          .getAppointmentPaidInfo(getJsonField(
                                        dataItem,
                                        r'''$.paid_amount''',
                                      )),
                                      name: getJsonField(
                                        dataItem,
                                        r'''$.name''',
                                      ).toString(),
                                      date: getJsonField(
                                        dataItem,
                                        r'''$.date''',
                                      ).toString(),
                                      fromTime: getJsonField(
                                        dataItem,
                                        r'''$.from_time''',
                                      ).toString(),
                                      toTime: getJsonField(
                                        dataItem,
                                        r'''$.to_time''',
                                      ).toString(),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _onPressedAppointment(dynamic dataItem) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: SizedBox(
              height: 430.0,
              child: AppointmentSheetWidget(
                id: getJsonField(
                  dataItem,
                  r'''$.id''',
                ),
                status: getJsonField(
                  dataItem,
                  r'''$.status''',
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) => safeSetState(() {}));
  }
}
