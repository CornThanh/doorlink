import 'package:doorlink_mobile/features/main/dashboard/repository/dashboard_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/backend/api_requests/api_calls.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dashboard_model.dart';

export 'dashboard_model.dart';

class DashboardScreenWidget extends StatefulWidget {
  const DashboardScreenWidget({super.key});

  @override
  State<DashboardScreenWidget> createState() => _DashboardScreenWidgetState();
}

class _DashboardScreenWidgetState extends State<DashboardScreenWidget> {
  late DashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardModel());
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
          child: Builder(
            builder: (context) {
              return FutureBuilder<ApiCallResponse>(
                future: DashboardRepository.getTodayAppointment(
                  authToken: FFAppState().authToken,
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return const Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CupertinoActivityIndicator(color: Colors.grey),
                      ),
                    );
                  }
                  // final containerTodayAppointmentResponse = snapshot.data!;
                  return Container(
                    decoration: const BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          12.0, 0.0, 12.0, 0.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: DashboardRepository.getAdminDashboard(
                          authToken: FFAppState().authToken,
                        ),
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
                          final listViewAdminDashboardResponse = snapshot.data!;
                          return ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            scrollDirection: Axis.vertical,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 5.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () => _onPressedVCards(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      5.0, 0.0, 6.0, 0.0),
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1.0, -1.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                            0.0, 12.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              getJsonField(
                                                                listViewAdminDashboardResponse
                                                                    .jsonBody,
                                                                r'''$.data.activeVcard''',
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    color: const Color(
                                                                        0xFF1A4572),
                                                                    fontSize:
                                                                        26.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            'Nunito Sans'),
                                                                  ),
                                                            ),
                                                            Container(
                                                              width: 60.0,
                                                              height: 50.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0x1A1F69F6),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 0.0
                                                                        : 300.0,
                                                                    0.0,
                                                                  )),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 300.0
                                                                        : 0.0,
                                                                    0.0,
                                                                  )),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 50.0
                                                                        : 0.0,
                                                                    0.0,
                                                                  )),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 0.0
                                                                        : 50.0,
                                                                    0.0,
                                                                  )),
                                                                ),
                                                              ),
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        0.0,
                                                                        10.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/user-solid_1.png',
                                                                    width: 30.0,
                                                                    height:
                                                                        20.0,
                                                                    fit: BoxFit
                                                                        .fitHeight,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0.0,
                                                                  8.0,
                                                                  5.0,
                                                                  0.0),
                                                          child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              '6hsy28xo' /* Total Active
                                              Vcards */
                                                              ,
                                                            ),
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito Sans',
                                                                  color: const Color(
                                                                      0xFF1E2935),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          'Nunito Sans'),
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () => _onPressedVCards(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      6.0, 0.0, 5.0, 0.0),
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1.0, -1.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                            0.0, 12.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              getJsonField(
                                                                listViewAdminDashboardResponse
                                                                    .jsonBody,
                                                                r'''$.data.deActiveVcard''',
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    color: const Color(
                                                                        0xFFF35050),
                                                                    fontSize:
                                                                        26.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            'Nunito Sans'),
                                                                  ),
                                                            ),
                                                            Container(
                                                              width: 60.0,
                                                              height: 50.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0x1AF35050),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 0.0
                                                                        : 300.0,
                                                                    0.0,
                                                                  )),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 300.0
                                                                        : 0.0,
                                                                    0.0,
                                                                  )),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 50.0
                                                                        : 0.0,
                                                                    0.0,
                                                                  )),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 0.0
                                                                        : 50.0,
                                                                    0.0,
                                                                  )),
                                                                ),
                                                              ),
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        0.0,
                                                                        10.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/deactivate.png',
                                                                    width: 30.0,
                                                                    height:
                                                                        20.0,
                                                                    fit: BoxFit
                                                                        .fitHeight,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0.0,
                                                                  8.0,
                                                                  5.0,
                                                                  0.0),
                                                          child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'eck7f7xr' /* Total Deactivated
                                              Vcards */
                                                              ,
                                                            ),
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito Sans',
                                                                  color: const Color(
                                                                      0xFF1E2935),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          'Nunito Sans'),
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () => _onPressedEnquiries(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      5.0, 0.0, 6.0, 0.0),
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1.0, -1.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                            0.0, 12.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              getJsonField(
                                                                listViewAdminDashboardResponse
                                                                    .jsonBody,
                                                                r'''$.data.enquiry''',
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    color: const Color(
                                                                        0xFFFF9900),
                                                                    fontSize:
                                                                        26.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            'Nunito Sans'),
                                                                  ),
                                                            ),
                                                            Container(
                                                              width: 60.0,
                                                              height: 50.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0x1AFF9900),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 0.0
                                                                        : 300.0,
                                                                    0.0,
                                                                  )),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 300.0
                                                                        : 0.0,
                                                                    0.0,
                                                                  )),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 50.0
                                                                        : 0.0,
                                                                    0.0,
                                                                  )),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 0.0
                                                                        : 50.0,
                                                                    0.0,
                                                                  )),
                                                                ),
                                                              ),
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        0.0,
                                                                        10.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/enquire.png',
                                                                    width: 30.0,
                                                                    height:
                                                                        20.0,
                                                                    fit: BoxFit
                                                                        .fitHeight,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0.0,
                                                                  8.0,
                                                                  5.0,
                                                                  0.0),
                                                          child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'rxccenn6' /* Today 
                                              Enquiries */
                                                              ,
                                                            ),
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito Sans',
                                                                  color: const Color(
                                                                      0xFF1E2935),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          'Nunito Sans'),
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () =>
                                                _onPressedAppointments(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      6.0, 0.0, 5.0, 0.0),
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1.0, -1.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(12.0, 0.0,
                                                            0.0, 12.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              getJsonField(
                                                                listViewAdminDashboardResponse
                                                                    .jsonBody,
                                                                r'''$.data.appointment''',
                                                              ).toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito Sans',
                                                                    color: const Color(
                                                                        0xFF00B96D),
                                                                    fontSize:
                                                                        26.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            'Nunito Sans'),
                                                                  ),
                                                            ),
                                                            Container(
                                                              width: 60.0,
                                                              height: 50.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0x1900B96D),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 0.0
                                                                        : 300.0,
                                                                    0.0,
                                                                  )),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 300.0
                                                                        : 0.0,
                                                                    0.0,
                                                                  )),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 50.0
                                                                        : 0.0,
                                                                    0.0,
                                                                  )),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          valueOrDefault<
                                                                              double>(
                                                                    FFAppState().selectLanguageIndex ==
                                                                            0
                                                                        ? 0.0
                                                                        : 50.0,
                                                                    0.0,
                                                                  )),
                                                                ),
                                                              ),
                                                              alignment:
                                                                  const AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        12.0,
                                                                        0.0,
                                                                        0.0,
                                                                        10.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/appointment.png',
                                                                    width: 30.0,
                                                                    height:
                                                                        20.0,
                                                                    fit: BoxFit
                                                                        .fitHeight,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0.0,
                                                                  8.0,
                                                                  5.0,
                                                                  0.0),
                                                          child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'u6g2qwc5' /* Today 
                                              Appointments */
                                                              ,
                                                            ),
                                                            maxLines: 2,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito Sans',
                                                                  color: const Color(
                                                                      0xFF1E2935),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          'Nunito Sans'),
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 10.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'xdgkk7kf' /* VCard Analytics */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey('Nunito Sans'),
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 5.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 240.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: .1),
                                        blurRadius: 1,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: FutureBuilder<ApiCallResponse>(
                                    future:
                                        DashboardRepository.getAdminIncomeChart(
                                      authToken: FFAppState().authToken,
                                    ),
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
                                      final containerAdminIncomeChartResponse =
                                          snapshot.data!;
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: custom_widgets.LineChartWidget(
                                            width: double.infinity,
                                            height: double.infinity,
                                            weeklyLabels:
                                                DashboardRepository.weeklyLabel(
                                                      containerAdminIncomeChartResponse
                                                          .jsonBody,
                                                    ) ??
                                                    [],
                                            chartData: DashboardRepository.data(
                                              containerAdminIncomeChartResponse
                                                  .jsonBody,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsetsDirectional.fromSTEB(
                              //       0.0, 20.0, 0.0, 10.0),
                              //   child: Row(
                              //     mainAxisSize: MainAxisSize.max,
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         FFLocalizations.of(context).getText(
                              //           '721dm1ol' /* Today’s Appointments */,
                              //         ),
                              //         style: FlutterFlowTheme.of(context)
                              //             .bodyMedium
                              //             .override(
                              //               fontFamily: 'Nunito Sans',
                              //               fontSize: 18.0,
                              //               fontWeight: FontWeight.bold,
                              //               useGoogleFonts: GoogleFonts.asMap()
                              //                   .containsKey('Nunito Sans'),
                              //             ),
                              //       ),
                              //       InkWell(
                              //         splashColor: Colors.transparent,
                              //         focusColor: Colors.transparent,
                              //         hoverColor: Colors.transparent,
                              //         highlightColor: Colors.transparent,
                              //         onTap: () async {
                              //           context.pushNamed('appointment_screen');

                              //           setState(() {
                              //             FFAppState().selectedDrawerPage =
                              //                 'Appointments';
                              //             FFAppState().isVcardAppointment =
                              //                 false;
                              //           });
                              //         },
                              //         child: Text(
                              //           FFLocalizations.of(context).getText(
                              //             'ryoxyyzt' /* View All */,
                              //           ),
                              //           style: FlutterFlowTheme.of(context)
                              //               .bodyMedium
                              //               .override(
                              //                 fontFamily: 'Nunito Sans',
                              //                 color: const Color(0xFF1A4572),
                              //                 fontWeight: FontWeight.bold,
                              //                 useGoogleFonts:
                              //                     GoogleFonts.asMap()
                              //                         .containsKey(
                              //                             'Nunito Sans'),
                              //               ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsetsDirectional.fromSTEB(
                              //       0.0, 10.0, 0.0, 0.0),
                              //   child: Builder(
                              //     builder: (context) {
                              //       final data = getJsonField(
                              //         containerTodayAppointmentResponse
                              //             .jsonBody,
                              //         r'''$.data''',
                              //       ).toList();
                              //       if (data.isEmpty) {
                              //         return const SizedBox(
                              //           width: double.infinity,
                              //           child: EmptyDataComponentWidget(),
                              //         );
                              //       }
                              //       return SingleChildScrollView(
                              //         child: Column(
                              //           mainAxisSize: MainAxisSize.max,
                              //           children: List.generate(data.length,
                              //               (dataIndex) {
                              //             final dataItem = data[dataIndex];
                              //             return Padding(
                              //               padding: const EdgeInsetsDirectional
                              //                   .fromSTEB(3.0, 0.0, 3.0, 0.0),
                              //               child: Builder(
                              //                 builder: (context) {
                              //                   if (FFAppState()
                              //                           .selectLanguageIndex ==
                              //                       0) {
                              //                     return Padding(
                              //                       padding:
                              //                           const EdgeInsetsDirectional
                              //                               .fromSTEB(2.0, 0.0,
                              //                               5.0, 10.0),
                              //                       child: InkWell(
                              //                         splashColor:
                              //                             Colors.transparent,
                              //                         focusColor:
                              //                             Colors.transparent,
                              //                         hoverColor:
                              //                             Colors.transparent,
                              //                         highlightColor:
                              //                             Colors.transparent,
                              //                         onTap: () async {
                              //                           await showModalBottomSheet(
                              //                             isScrollControlled:
                              //                                 true,
                              //                             backgroundColor:
                              //                                 Colors
                              //                                     .transparent,
                              //                             enableDrag: false,
                              //                             context: context,
                              //                             builder: (context) {
                              //                               return GestureDetector(
                              //                                 onTap: () => _model
                              //                                         .unfocusNode
                              //                                         .canRequestFocus
                              //                                     ? FocusScope.of(
                              //                                             context)
                              //                                         .requestFocus(
                              //                                             _model
                              //                                                 .unfocusNode)
                              //                                     : FocusScope.of(
                              //                                             context)
                              //                                         .unfocus(),
                              //                                 child: Padding(
                              //                                   padding: MediaQuery
                              //                                       .viewInsetsOf(
                              //                                           context),
                              //                                   child: SizedBox(
                              //                                     height: 430.0,
                              //                                     child:
                              //                                         AppointmentSheetWidget(
                              //                                       id: getJsonField(
                              //                                         dataItem,
                              //                                         r'''$.id''',
                              //                                       ),
                              //                                       status:
                              //                                           getJsonField(
                              //                                         dataItem,
                              //                                         r'''$.status''',
                              //                                       ),
                              //                                     ),
                              //                                   ),
                              //                                 ),
                              //                               );
                              //                             },
                              //                           ).then((value) =>
                              //                               safeSetState(
                              //                                   () {}));
                              //                         },
                              //                         child: Material(
                              //                           color:
                              //                               Colors.transparent,
                              //                           elevation: 1.0,
                              //                           shape:
                              //                               RoundedRectangleBorder(
                              //                             borderRadius:
                              //                                 BorderRadius
                              //                                     .circular(
                              //                                         10.0),
                              //                           ),
                              //                           child: Container(
                              //                             width:
                              //                                 double.infinity,
                              //                             height: 120.0,
                              //                             decoration:
                              //                                 BoxDecoration(
                              //                               color: FlutterFlowTheme
                              //                                       .of(context)
                              //                                   .primary,
                              //                               boxShadow: const [
                              //                                 BoxShadow(
                              //                                   blurRadius: 0.0,
                              //                                   color: Color(
                              //                                       0xFF1A4572),
                              //                                   offset: Offset(
                              //                                       -5.0, 0.0),
                              //                                 )
                              //                               ],
                              //                               borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(
                              //                                           10.0),
                              //                             ),
                              //                             child: Padding(
                              //                               padding:
                              //                                   const EdgeInsetsDirectional
                              //                                       .fromSTEB(
                              //                                       0.0,
                              //                                       0.0,
                              //                                       15.0,
                              //                                       0.0),
                              //                               child: Column(
                              //                                 mainAxisSize:
                              //                                     MainAxisSize
                              //                                         .max,
                              //                                 crossAxisAlignment:
                              //                                     CrossAxisAlignment
                              //                                         .end,
                              //                                 children: [
                              //                                   Row(
                              //                                     mainAxisSize:
                              //                                         MainAxisSize
                              //                                             .max,
                              //                                     mainAxisAlignment:
                              //                                         MainAxisAlignment
                              //                                             .spaceBetween,
                              //                                     crossAxisAlignment:
                              //                                         CrossAxisAlignment
                              //                                             .end,
                              //                                     children: [
                              //                                       Padding(
                              //                                         padding: const EdgeInsetsDirectional
                              //                                             .fromSTEB(
                              //                                             0.0,
                              //                                             0.0,
                              //                                             0.0,
                              //                                             5.0),
                              //                                         child:
                              //                                             Container(
                              //                                           width:
                              //                                               55.0,
                              //                                           height:
                              //                                               35.0,
                              //                                           decoration:
                              //                                               BoxDecoration(
                              //                                             color: functions.getAppointmentPaidInfo(getJsonField(
                              //                                               dataItem,
                              //                                               r'''$.paid_amount''',
                              //                                             ))
                              //                                                 ? const Color(0xFF1A4572)
                              //                                                 : const Color(0xFFFF9900),
                              //                                             borderRadius:
                              //                                                 const BorderRadius.only(
                              //                                               bottomLeft:
                              //                                                   Radius.circular(15.0),
                              //                                               bottomRight:
                              //                                                   Radius.circular(0.0),
                              //                                               topLeft:
                              //                                                   Radius.circular(0.0),
                              //                                               topRight:
                              //                                                   Radius.circular(10.0),
                              //                                             ),
                              //                                           ),
                              //                                           alignment: const AlignmentDirectional(
                              //                                               0.0,
                              //                                               0.0),
                              //                                           child:
                              //                                               Text(
                              //                                             functions.getAppointmentPaidInfo(getJsonField(
                              //                                               dataItem,
                              //                                               r'''$.paid_amount''',
                              //                                             ))
                              //                                                 ? 'Free'
                              //                                                 : 'Paid',
                              //                                             style: FlutterFlowTheme.of(context)
                              //                                                 .bodyMedium
                              //                                                 .override(
                              //                                                   fontFamily: 'Nunito Sans',
                              //                                                   color: Colors.white,
                              //                                                   fontSize: 14.0,
                              //                                                   fontWeight: FontWeight.bold,
                              //                                                   useGoogleFonts: GoogleFonts.asMap().containsKey('Nunito Sans'),
                              //                                                 ),
                              //                                           ),
                              //                                         ),
                              //                                       ),
                              //                                       Text(
                              //                                         getJsonField(
                              //                                           dataItem,
                              //                                           r'''$.vcard_name''',
                              //                                         ).toString(),
                              //                                         style: FlutterFlowTheme.of(
                              //                                                 context)
                              //                                             .bodyMedium
                              //                                             .override(
                              //                                               fontFamily:
                              //                                                   'Nunito Sans',
                              //                                               fontSize:
                              //                                                   16.0,
                              //                                               fontWeight:
                              //                                                   FontWeight.bold,
                              //                                               useGoogleFonts:
                              //                                                   GoogleFonts.asMap().containsKey('Nunito Sans'),
                              //                                             ),
                              //                                       ),
                              //                                     ],
                              //                                   ),
                              //                                   Padding(
                              //                                     padding:
                              //                                         const EdgeInsetsDirectional
                              //                                             .fromSTEB(
                              //                                             0.0,
                              //                                             5.0,
                              //                                             0.0,
                              //                                             0.0),
                              //                                     child:
                              //                                         RichText(
                              //                                       textScaler:
                              //                                           MediaQuery.of(context)
                              //                                               .textScaler,
                              //                                       text:
                              //                                           TextSpan(
                              //                                         children: [
                              //                                           TextSpan(
                              //                                             text:
                              //                                                 functions.getAppointmentStatusInfo(getJsonField(
                              //                                               dataItem,
                              //                                               r'''$.status''',
                              //                                             )),
                              //                                             style: FlutterFlowTheme.of(context)
                              //                                                 .bodyMedium
                              //                                                 .override(
                              //                                                   fontFamily: 'Nunito Sans',
                              //                                                   color: functions.getAppointmentStatusInfo(getJsonField(
                              //                                                             dataItem,
                              //                                                             r'''$.status''',
                              //                                                           )) ==
                              //                                                           'Pending'
                              //                                                       ? const Color(0xFFFF9900)
                              //                                                       : const Color(0xFF00B96D),
                              //                                                   fontWeight: FontWeight.bold,
                              //                                                   useGoogleFonts: GoogleFonts.asMap().containsKey('Nunito Sans'),
                              //                                                 ),
                              //                                           ),
                              //                                           TextSpan(
                              //                                             text:
                              //                                                 FFLocalizations.of(context).getText(
                              //                                               'm929v9xi' /*   |   */,
                              //                                             ),
                              //                                             style:
                              //                                                 const TextStyle(
                              //                                               color:
                              //                                                   Color(0xFF79818A),
                              //                                             ),
                              //                                           ),
                              //                                           TextSpan(
                              //                                             text:
                              //                                                 getJsonField(
                              //                                               dataItem,
                              //                                               r'''$.name''',
                              //                                             ).toString(),
                              //                                             style:
                              //                                                 GoogleFonts.getFont(
                              //                                               'Nunito Sans',
                              //                                               color:
                              //                                                   const Color(0xFF79818A),
                              //                                               fontWeight:
                              //                                                   FontWeight.bold,
                              //                                             ),
                              //                                           )
                              //                                         ],
                              //                                         style: FlutterFlowTheme.of(
                              //                                                 context)
                              //                                             .bodyMedium,
                              //                                       ),
                              //                                       textAlign:
                              //                                           TextAlign
                              //                                               .start,
                              //                                     ),
                              //                                   ),
                              //                                   Padding(
                              //                                     padding:
                              //                                         const EdgeInsetsDirectional
                              //                                             .fromSTEB(
                              //                                             0.0,
                              //                                             10.0,
                              //                                             0.0,
                              //                                             0.0),
                              //                                     child:
                              //                                         Container(
                              //                                       height:
                              //                                           35.0,
                              //                                       decoration:
                              //                                           BoxDecoration(
                              //                                         color: const Color(
                              //                                             0xFFF6F8F9),
                              //                                         borderRadius:
                              //                                             BorderRadius.circular(
                              //                                                 10.0),
                              //                                       ),
                              //                                       child:
                              //                                           Padding(
                              //                                         padding: const EdgeInsetsDirectional
                              //                                             .fromSTEB(
                              //                                             10.0,
                              //                                             0.0,
                              //                                             10.0,
                              //                                             0.0),
                              //                                         child:
                              //                                             Row(
                              //                                           mainAxisSize:
                              //                                               MainAxisSize.min,
                              //                                           mainAxisAlignment:
                              //                                               MainAxisAlignment.end,
                              //                                           children: [
                              //                                             Text(
                              //                                               functions.getAppointmentFormatedTime(
                              //                                                   getJsonField(
                              //                                                     dataItem,
                              //                                                     r'''$.from_time''',
                              //                                                   ).toString(),
                              //                                                   getJsonField(
                              //                                                     dataItem,
                              //                                                     r'''$.to_time''',
                              //                                                   ).toString()),
                              //                                               style: FlutterFlowTheme.of(context).bodyMedium.override(
                              //                                                     fontFamily: 'Nunito Sans',
                              //                                                     color: const Color(0xFF79818A),
                              //                                                     fontWeight: FontWeight.bold,
                              //                                                     useGoogleFonts: GoogleFonts.asMap().containsKey('Nunito Sans'),
                              //                                                   ),
                              //                                             ),
                              //                                             Padding(
                              //                                               padding: const EdgeInsetsDirectional.fromSTEB(
                              //                                                   8.0,
                              //                                                   0.0,
                              //                                                   8.0,
                              //                                                   0.0),
                              //                                               child:
                              //                                                   Text(
                              //                                                 FFLocalizations.of(context).getText(
                              //                                                   'tkru2ovh' /* • */,
                              //                                                 ),
                              //                                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                              //                                                       fontFamily: 'Nunito Sans',
                              //                                                       color: const Color(0xFF79818A),
                              //                                                       fontWeight: FontWeight.bold,
                              //                                                       useGoogleFonts: GoogleFonts.asMap().containsKey('Nunito Sans'),
                              //                                                     ),
                              //                                               ),
                              //                                             ),
                              //                                             Text(
                              //                                               getJsonField(
                              //                                                 dataItem,
                              //                                                 r'''$.date''',
                              //                                               ).toString(),
                              //                                               style: FlutterFlowTheme.of(context).bodyMedium.override(
                              //                                                     fontFamily: 'Nunito Sans',
                              //                                                     color: const Color(0xFF79818A),
                              //                                                     fontWeight: FontWeight.bold,
                              //                                                     useGoogleFonts: GoogleFonts.asMap().containsKey('Nunito Sans'),
                              //                                                   ),
                              //                                             ),
                              //                                             const Padding(
                              //                                               padding: EdgeInsetsDirectional.fromSTEB(
                              //                                                   8.0,
                              //                                                   0.0,
                              //                                                   0.0,
                              //                                                   0.0),
                              //                                               child:
                              //                                                   Icon(
                              //                                                 Icons.watch_later_outlined,
                              //                                                 color: Color(0xFF1A4572),
                              //                                                 size: 24.0,
                              //                                               ),
                              //                                             ),
                              //                                           ],
                              //                                         ),
                              //                                       ),
                              //                                     ),
                              //                                   ),
                              //                                 ],
                              //                               ),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     );
                              //                   } else {
                              //                     return Padding(
                              //                       padding:
                              //                           const EdgeInsetsDirectional
                              //                               .fromSTEB(5.0, 0.0,
                              //                               0.0, 10.0),
                              //                       child: InkWell(
                              //                         splashColor:
                              //                             Colors.transparent,
                              //                         focusColor:
                              //                             Colors.transparent,
                              //                         hoverColor:
                              //                             Colors.transparent,
                              //                         highlightColor:
                              //                             Colors.transparent,
                              //                         onTap: () async {
                              //                           await showModalBottomSheet(
                              //                             isScrollControlled:
                              //                                 true,
                              //                             backgroundColor:
                              //                                 Colors
                              //                                     .transparent,
                              //                             enableDrag: false,
                              //                             context: context,
                              //                             builder: (context) {
                              //                               return GestureDetector(
                              //                                 onTap: () => _model
                              //                                         .unfocusNode
                              //                                         .canRequestFocus
                              //                                     ? FocusScope.of(
                              //                                             context)
                              //                                         .requestFocus(
                              //                                             _model
                              //                                                 .unfocusNode)
                              //                                     : FocusScope.of(
                              //                                             context)
                              //                                         .unfocus(),
                              //                                 child: Padding(
                              //                                   padding: MediaQuery
                              //                                       .viewInsetsOf(
                              //                                           context),
                              //                                   child: SizedBox(
                              //                                     height: 430.0,
                              //                                     child:
                              //                                         AppointmentSheetWidget(
                              //                                       id: getJsonField(
                              //                                         dataItem,
                              //                                         r'''$.id''',
                              //                                       ),
                              //                                       status:
                              //                                           getJsonField(
                              //                                         dataItem,
                              //                                         r'''$.status''',
                              //                                       ),
                              //                                     ),
                              //                                   ),
                              //                                 ),
                              //                               );
                              //                             },
                              //                           ).then((value) =>
                              //                               safeSetState(
                              //                                   () {}));
                              //                         },
                              //                         child: Material(
                              //                           color:
                              //                               Colors.transparent,
                              //                           elevation: 1.0,
                              //                           shape:
                              //                               RoundedRectangleBorder(
                              //                             borderRadius:
                              //                                 BorderRadius
                              //                                     .circular(
                              //                                         10.0),
                              //                           ),
                              //                           child: Container(
                              //                             width:
                              //                                 double.infinity,
                              //                             height: 120.0,
                              //                             decoration:
                              //                                 BoxDecoration(
                              //                               color: FlutterFlowTheme
                              //                                       .of(context)
                              //                                   .primary,
                              //                               boxShadow: const [
                              //                                 BoxShadow(
                              //                                   blurRadius: 0.0,
                              //                                   color: Color(
                              //                                       0xFF1A4572),
                              //                                   offset: Offset(
                              //                                       -5.0, 0.0),
                              //                                 )
                              //                               ],
                              //                               borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(
                              //                                           10.0),
                              //                             ),
                              //                             child: Padding(
                              //                               padding:
                              //                                   const EdgeInsetsDirectional
                              //                                       .fromSTEB(
                              //                                       15.0,
                              //                                       0.0,
                              //                                       0.0,
                              //                                       0.0),
                              //                               child: Column(
                              //                                 mainAxisSize:
                              //                                     MainAxisSize
                              //                                         .max,
                              //                                 crossAxisAlignment:
                              //                                     CrossAxisAlignment
                              //                                         .start,
                              //                                 children: [
                              //                                   Row(
                              //                                     mainAxisSize:
                              //                                         MainAxisSize
                              //                                             .max,
                              //                                     mainAxisAlignment:
                              //                                         MainAxisAlignment
                              //                                             .spaceBetween,
                              //                                     crossAxisAlignment:
                              //                                         CrossAxisAlignment
                              //                                             .end,
                              //                                     children: [
                              //                                       Text(
                              //                                         getJsonField(
                              //                                           dataItem,
                              //                                           r'''$.vcard_name''',
                              //                                         ).toString(),
                              //                                         style: FlutterFlowTheme.of(
                              //                                                 context)
                              //                                             .bodyMedium
                              //                                             .override(
                              //                                               fontFamily:
                              //                                                   'Nunito Sans',
                              //                                               fontSize:
                              //                                                   16.0,
                              //                                               fontWeight:
                              //                                                   FontWeight.bold,
                              //                                               useGoogleFonts:
                              //                                                   GoogleFonts.asMap().containsKey('Nunito Sans'),
                              //                                             ),
                              //                                       ),
                              //                                       Padding(
                              //                                         padding: const EdgeInsetsDirectional
                              //                                             .fromSTEB(
                              //                                             0.0,
                              //                                             0.0,
                              //                                             0.0,
                              //                                             5.0),
                              //                                         child:
                              //                                             Container(
                              //                                           width:
                              //                                               55.0,
                              //                                           height:
                              //                                               35.0,
                              //                                           decoration:
                              //                                               BoxDecoration(
                              //                                             color: functions.getAppointmentPaidInfo(getJsonField(
                              //                                               dataItem,
                              //                                               r'''$.paid_amount''',
                              //                                             ))
                              //                                                 ? const Color(0xFF1A4572)
                              //                                                 : const Color(0xFFFF9900),
                              //                                             borderRadius:
                              //                                                 const BorderRadius.only(
                              //                                               bottomLeft:
                              //                                                   Radius.circular(15.0),
                              //                                               bottomRight:
                              //                                                   Radius.circular(0.0),
                              //                                               topLeft:
                              //                                                   Radius.circular(0.0),
                              //                                               topRight:
                              //                                                   Radius.circular(10.0),
                              //                                             ),
                              //                                           ),
                              //                                           alignment: const AlignmentDirectional(
                              //                                               0.0,
                              //                                               0.0),
                              //                                           child:
                              //                                               Text(
                              //                                             functions.getAppointmentPaidInfo(getJsonField(
                              //                                               dataItem,
                              //                                               r'''$.paid_amount''',
                              //                                             ))
                              //                                                 ? 'Free'
                              //                                                 : 'Paid',
                              //                                             style: FlutterFlowTheme.of(context)
                              //                                                 .bodyMedium
                              //                                                 .override(
                              //                                                   fontFamily: 'Nunito Sans',
                              //                                                   color: Colors.white,
                              //                                                   fontSize: 14.0,
                              //                                                   fontWeight: FontWeight.bold,
                              //                                                   useGoogleFonts: GoogleFonts.asMap().containsKey('Nunito Sans'),
                              //                                                 ),
                              //                                           ),
                              //                                         ),
                              //                                       ),
                              //                                     ],
                              //                                   ),
                              //                                   Padding(
                              //                                     padding:
                              //                                         const EdgeInsetsDirectional
                              //                                             .fromSTEB(
                              //                                             0.0,
                              //                                             5.0,
                              //                                             0.0,
                              //                                             0.0),
                              //                                     child:
                              //                                         RichText(
                              //                                       textScaler:
                              //                                           MediaQuery.of(context)
                              //                                               .textScaler,
                              //                                       text:
                              //                                           TextSpan(
                              //                                         children: [
                              //                                           TextSpan(
                              //                                             text:
                              //                                                 functions.getAppointmentStatusInfo(getJsonField(
                              //                                               dataItem,
                              //                                               r'''$.status''',
                              //                                             )),
                              //                                             style: FlutterFlowTheme.of(context)
                              //                                                 .bodyMedium
                              //                                                 .override(
                              //                                                   fontFamily: 'Nunito Sans',
                              //                                                   color: functions.getAppointmentStatusInfo(getJsonField(
                              //                                                             dataItem,
                              //                                                             r'''$.status''',
                              //                                                           )) ==
                              //                                                           'Pending'
                              //                                                       ? const Color(0xFFFF9900)
                              //                                                       : const Color(0xFF00B96D),
                              //                                                   fontWeight: FontWeight.bold,
                              //                                                   useGoogleFonts: GoogleFonts.asMap().containsKey('Nunito Sans'),
                              //                                                 ),
                              //                                           ),
                              //                                           TextSpan(
                              //                                             text:
                              //                                                 FFLocalizations.of(context).getText(
                              //                                               'sro4bcxg' /*   |   */,
                              //                                             ),
                              //                                             style:
                              //                                                 const TextStyle(
                              //                                               color:
                              //                                                   Color(0xFF79818A),
                              //                                             ),
                              //                                           ),
                              //                                           TextSpan(
                              //                                             text:
                              //                                                 getJsonField(
                              //                                               dataItem,
                              //                                               r'''$.name''',
                              //                                             ).toString(),
                              //                                             style:
                              //                                                 GoogleFonts.getFont(
                              //                                               'Nunito Sans',
                              //                                               color:
                              //                                                   const Color(0xFF79818A),
                              //                                               fontWeight:
                              //                                                   FontWeight.bold,
                              //                                             ),
                              //                                           )
                              //                                         ],
                              //                                         style: FlutterFlowTheme.of(
                              //                                                 context)
                              //                                             .bodyMedium,
                              //                                       ),
                              //                                       textAlign:
                              //                                           TextAlign
                              //                                               .start,
                              //                                     ),
                              //                                   ),
                              //                                   Padding(
                              //                                     padding:
                              //                                         const EdgeInsetsDirectional
                              //                                             .fromSTEB(
                              //                                             0.0,
                              //                                             10.0,
                              //                                             0.0,
                              //                                             0.0),
                              //                                     child:
                              //                                         Container(
                              //                                       height:
                              //                                           35.0,
                              //                                       decoration:
                              //                                           BoxDecoration(
                              //                                         color: const Color(
                              //                                             0xFFF6F8F9),
                              //                                         borderRadius:
                              //                                             BorderRadius.circular(
                              //                                                 10.0),
                              //                                       ),
                              //                                       child:
                              //                                           Padding(
                              //                                         padding: const EdgeInsetsDirectional
                              //                                             .fromSTEB(
                              //                                             10.0,
                              //                                             0.0,
                              //                                             10.0,
                              //                                             0.0),
                              //                                         child:
                              //                                             Row(
                              //                                           mainAxisSize:
                              //                                               MainAxisSize.min,
                              //                                           mainAxisAlignment:
                              //                                               MainAxisAlignment.start,
                              //                                           children: [
                              //                                             const Icon(
                              //                                               Icons.watch_later_outlined,
                              //                                               color:
                              //                                                   Color(0xFF1A4572),
                              //                                               size:
                              //                                                   24.0,
                              //                                             ),
                              //                                             Padding(
                              //                                               padding: const EdgeInsetsDirectional.fromSTEB(
                              //                                                   8.0,
                              //                                                   0.0,
                              //                                                   0.0,
                              //                                                   0.0),
                              //                                               child:
                              //                                                   Text(
                              //                                                 getJsonField(
                              //                                                   dataItem,
                              //                                                   r'''$.date''',
                              //                                                 ).toString(),
                              //                                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                              //                                                       fontFamily: 'Nunito Sans',
                              //                                                       color: const Color(0xFF79818A),
                              //                                                       fontWeight: FontWeight.bold,
                              //                                                       useGoogleFonts: GoogleFonts.asMap().containsKey('Nunito Sans'),
                              //                                                     ),
                              //                                               ),
                              //                                             ),
                              //                                             Padding(
                              //                                               padding: const EdgeInsetsDirectional.fromSTEB(
                              //                                                   8.0,
                              //                                                   0.0,
                              //                                                   8.0,
                              //                                                   0.0),
                              //                                               child:
                              //                                                   Text(
                              //                                                 FFLocalizations.of(context).getText(
                              //                                                   '00bqlnlz' /* • */,
                              //                                                 ),
                              //                                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                              //                                                       fontFamily: 'Nunito Sans',
                              //                                                       color: const Color(0xFF79818A),
                              //                                                       fontWeight: FontWeight.bold,
                              //                                                       useGoogleFonts: GoogleFonts.asMap().containsKey('Nunito Sans'),
                              //                                                     ),
                              //                                               ),
                              //                                             ),
                              //                                             Text(
                              //                                               functions.getAppointmentFormatedTime(
                              //                                                   getJsonField(
                              //                                                     dataItem,
                              //                                                     r'''$.from_time''',
                              //                                                   ).toString(),
                              //                                                   getJsonField(
                              //                                                     dataItem,
                              //                                                     r'''$.to_time''',
                              //                                                   ).toString()),
                              //                                               style: FlutterFlowTheme.of(context).bodyMedium.override(
                              //                                                     fontFamily: 'Nunito Sans',
                              //                                                     color: const Color(0xFF79818A),
                              //                                                     fontWeight: FontWeight.bold,
                              //                                                     useGoogleFonts: GoogleFonts.asMap().containsKey('Nunito Sans'),
                              //                                                   ),
                              //                                             ),
                              //                                           ],
                              //                                         ),
                              //                                       ),
                              //                                     ),
                              //                                   ),
                              //                                 ],
                              //                               ),
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     );
                              //                   }
                              //                 },
                              //               ),
                              //             );
                              //           }),
                              //         ),
                              //       );
                              //     },
                              //   ),
                              // ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // void _onPressedFloatingButton() {
  //   if (FFAppState().selectedDrawerPage != 'VCards') {
  //     context.goNamed(
  //       'vcard_screen',
  //       queryParameters: {'isCreate': 'true'},
  //       extra: <String, dynamic>{
  //         kTransitionInfoKey: const TransitionInfo(
  //           hasTransition: true,
  //           transitionType: PageTransitionType.fade,
  //           duration: Duration(milliseconds: 300),
  //         ),
  //       },
  //     );
  //   }
  //   FFAppState().selectedDrawerPage = 'VCards';
  // }

  void _onPressedVCards() {
    // if (FFAppState().selectedDrawerPage != 'VCards') {
    // context.goNamed(
    //   'vcard_screen',
    //   extra: <String, dynamic>{
    //     kTransitionInfoKey: const TransitionInfo(
    //       hasTransition: true,
    //       transitionType: PageTransitionType.fade,
    //       duration: Duration(milliseconds: 300),
    //     ),
    //   },
    // );
    // }
    // FFAppState().selectedDrawerPage = 'VCards';
  }

  void _onPressedEnquiries() {
    // if (FFAppState().selectedDrawerPage != 'Enquiries') {
    //   context.goNamed(
    //     'enquiries_screen',
    //     extra: <String, dynamic>{
    //       kTransitionInfoKey: const TransitionInfo(
    //         hasTransition: true,
    //         transitionType: PageTransitionType.fade,
    //         duration: Duration(milliseconds: 300),
    //       ),
    //     },
    //   );
    // }
    // FFAppState().selectedDrawerPage = 'Enquiries';
    // FFAppState().isVcardEnquiry = false;
  }

  void _onPressedAppointments() {
    // if (FFAppState().selectedDrawerPage != 'Appointments') {
    //   context.goNamed(
    //     'appointment_screen',
    //     extra: <String, dynamic>{
    //       kTransitionInfoKey: const TransitionInfo(
    //         hasTransition: true,
    //         transitionType: PageTransitionType.fade,
    //         duration: Duration(milliseconds: 300),
    //       ),
    //     },
    //   );
    // }
    // FFAppState().selectedDrawerPage = 'Appointments';
    // FFAppState().isVcardAppointment = false;
  }
}
