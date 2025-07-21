import 'dart:async';
import 'dart:developer';

import 'package:MeU/component/vcard_sheet/create_vcard_sheet_widget.dart';
import 'package:MeU/features/main/vcard/repository/vcard_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/backend/api_requests/api_calls.dart';
import '/component/drawer/drawer_widget.dart';
import '/component/empty_data_component/empty_data_component_widget.dart';
import '/component/scan_component/scan_component_widget.dart';
import '/component/vcard_sheet/vcard_sheet_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'vcard_screen_model.dart';

export 'vcard_screen_model.dart';

class VcardScreenWidget extends StatefulWidget {
  const VcardScreenWidget({
    super.key,
    this.isCreate = false,
  });

  final bool isCreate;

  @override
  State<VcardScreenWidget> createState() => _VcardScreenWidgetState();
}

class _VcardScreenWidgetState extends State<VcardScreenWidget> {
  late VcardScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    log('isCreate ${widget.isCreate}');

    if (widget.isCreate) {
      init();
    }

    _model = createModel(context, () => VcardScreenModel());

    super.initState();
  }

  Future init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final shouldReload = await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.viewInsetsOf(context),
            child: const CreateVcardSheetWidget(),
          );
        },
      );

      if (shouldReload == true) {
        setState(() => _model.apiRequestCompleter2 = null);
        await _model.waitForApiRequestCompleted2();
      }
    });
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
        // drawer: Drawer(
        //   elevation: 16.0,
        //   child: wrapWithModel(
        //     model: _model.drawerModel,
        //     updateCallback: () => setState(() {}),
        //     child: const DrawerWidget(),
        //   ),
        // ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: const Color(0xFF1A4572),
        //   child: const Icon(Icons.add, color: Colors.white, size: 28),
        //   onPressed: () async {
        //     final shouldReload = await showModalBottomSheet(
        //       isScrollControlled: true,
        //       backgroundColor: Colors.transparent,
        //       context: context,
        //       builder: (context) {
        //         return Padding(
        //           padding: MediaQuery.viewInsetsOf(context),
        //           child: const CreateVcardSheetWidget(),
        //         );
        //       },
        //     );

        //     if (shouldReload == true) {
        //       setState(() => _model.apiRequestCompleter2 = null);
        //       await _model.waitForApiRequestCompleted2();
        //     }
        //   },
        // ),
        // appBar: AppBar(
        //   backgroundColor: const Color(0xff333333),
        //   automaticallyImplyLeading: false,
        //   leading: InkWell(
        //     splashColor: Colors.transparent,
        //     focusColor: Colors.transparent,
        //     hoverColor: Colors.transparent,
        //     highlightColor: Colors.transparent,
        //     onTap: () async {
        //       scaffoldKey.currentState!.openDrawer();
        //     },
        //     child: Container(
        //       decoration: const BoxDecoration(),
        //       child: const Padding(
        //         padding: EdgeInsetsDirectional.fromSTEB(12.0, 17.0, 25.0, 17.0),
        //         child: SizedBox(
        //           width: 100.0,
        //           height: 100.0,
        //           child: Icon(Icons.menu),
        //         ),
        //       ),
        //     ),
        //   ),
        //   title: Text(
        //     FFLocalizations.of(context).getText(
        //       'xv0dqfc8' /* VCards */,
        //     ),
        //     style: FlutterFlowTheme.of(context).headlineMedium.override(
        //           fontFamily: 'Nunito Sans',
        //           color: Colors.white,
        //           fontSize: 22.0,
        //           fontWeight: FontWeight.bold,
        //           useGoogleFonts:
        //               GoogleFonts.asMap().containsKey('Nunito Sans'),
        //         ),
        //   ),
        //   actions: [
        //     wrapWithModel(
        //       model: _model.scanComponentModel,
        //       updateCallback: () => setState(() {}),
        //       child: const ScanComponentWidget(),
        //     ),
        //   ],
        //   centerTitle: true,
        //   elevation: 1.0,
        // ),
        body: SafeArea(
          child: Builder(
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
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: (_model.apiRequestCompleter2 ??=
                                Completer<ApiCallResponse>()
                                  ..complete(VcardRepository.getAdminVcardList(
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
                          final listViewAdminVcardResponse = snapshot.data!;
                          return Builder(
                            builder: (context) {
                              final data = functions
                                  .sortListData(VcardRepository.data(
                                    listViewAdminVcardResponse.jsonBody,
                                  )!
                                      .toList())
                                  .toList();
                              if (data.isEmpty) {
                                return const EmptyDataComponentWidget();
                              }
                              return RefreshIndicator(
                                key: const Key('RefreshIndicator_j38o1upx'),
                                onRefresh: () async {
                                  setState(
                                      () => _model.apiRequestCompleter2 = null);
                                  await _model.waitForApiRequestCompleted2();
                                },
                                child: ListView.separated(
                                  padding: const EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    0,
                                    10.0,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 10.0),
                                  itemBuilder: (context, dataIndex) {
                                    final dataItem = data[dataIndex];
                                    return Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5.0, 0.0, 2.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          final result =
                                              await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            barrierColor:
                                                const Color(0x27000000),
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () => _model.unfocusNode
                                                        .canRequestFocus
                                                    ? FocusScope.of(context)
                                                        .requestFocus(
                                                            _model.unfocusNode)
                                                    : FocusScope.of(context)
                                                        .unfocus(),
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: VcardSheetWidget(
                                                    vcardId: getJsonField(
                                                      dataItem,
                                                      r'''$.id''',
                                                    ),
                                                    url: getJsonField(
                                                      dataItem,
                                                      r'''$.url_alias''',
                                                    ).toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                          );

                                          if (result == true) {
                                            setState(() => _model
                                                .apiRequestCompleter2 = null);
                                            await _model
                                                .waitForApiRequestCompleted2();
                                          }
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 1.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Container(
                                            width: double.infinity,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 0.0,
                                                  color: Color(0xFF1A4572),
                                                  offset: Offset(-5.0, 0.0),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      10.0, 0.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(50.0),
                                                      bottomRight:
                                                          Radius.circular(50.0),
                                                      topLeft:
                                                          Radius.circular(50.0),
                                                      topRight:
                                                          Radius.circular(50.0),
                                                    ),
                                                    child: Image.network(
                                                      getJsonField(
                                                        dataItem,
                                                        r'''$.image''',
                                                      ).toString(),
                                                      width: 50.0,
                                                      height: 50.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                            0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          getJsonField(
                                                            dataItem,
                                                            r'''$.name''',
                                                          )
                                                              .toString()
                                                              .maybeHandleOverflow(
                                                                maxChars: 20,
                                                                replacement:
                                                                    '…',
                                                              ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'Nunito Sans',
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Nunito Sans'),
                                                              ),
                                                        ),
                                                        Text(
                                                          getJsonField(
                                                                dataItem,
                                                                r'''$.occupation''',
                                                              )
                                                                  ?.toString()
                                                                  .maybeHandleOverflow(
                                                                    maxChars:
                                                                        20,
                                                                    replacement:
                                                                        '…',
                                                                  ) ??
                                                              "",
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito Sans',
                                                                color: const Color(
                                                                    0xFF79818A),
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Nunito Sans'),
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, -1.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0,
                                                              0.0, 0.0, 5.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          int? id =
                                                              getJsonField(
                                                            dataItem,
                                                            r'''$.id''',
                                                          );

                                                          final shouldReload =
                                                              await context
                                                                  .pushNamed<
                                                                      bool>(
                                                            'update_vcard_screen',
                                                            queryParameters: {
                                                              "vcardID": "$id"
                                                            },
                                                          );

                                                          if (shouldReload ==
                                                              true) {
                                                            setState(() => _model
                                                                    .apiRequestCompleter2 =
                                                                null);
                                                            await _model
                                                                .waitForApiRequestCompleted2();
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 40.0,
                                                          height: 40.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  Image.asset(
                                                                'assets/images/ic_vcard_edit.png',
                                                              ).image,
                                                            ),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      15.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      0.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10.0),
                                                            ),
                                                          ),
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  0.0, 0.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        const AlignmentDirectional(
                                                            0.0, -1.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(1.0,
                                                              1.0, 1.0, 5.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          await launchURL(
                                                              getJsonField(
                                                            dataItem,
                                                            r'''$.url_alias''',
                                                          ).toString());
                                                        },
                                                        child: Container(
                                                          width: 40.0,
                                                          height: 40.0,
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      15.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      0.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10.0),
                                                            ),
                                                          ),
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: const Icon(
                                                            Icons
                                                                .visibility_outlined,
                                                            color: Colors.blue,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
