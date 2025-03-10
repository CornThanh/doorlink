import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

import '/backend/api_requests/api_calls.dart';
import '/component/delete_dialog_box/delete_dialog_box_widget.dart';
import '/component/nfc_write_sheet/nfc_write_sheet_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'vcard_sheet_model.dart';

export 'vcard_sheet_model.dart';

class VcardSheetWidget extends StatefulWidget {
  const VcardSheetWidget({
    super.key,
    required this.vcardId,
    required this.url,
  });

  final int? vcardId;
  final String? url;

  @override
  State<VcardSheetWidget> createState() => _VcardSheetWidgetState();
}

class _VcardSheetWidgetState extends State<VcardSheetWidget> {
  late VcardSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VcardSheetModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: 305.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<ApiCallResponse>(
          future: VcardGroup.singleVcardsCall.call(
            authToken: FFAppState().authToken,
            id: widget.vcardId,
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return const Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CupertinoActivityIndicator(color: Colors.white),
                ),
              );
            }
            final columnSingleVcardsResponse = snapshot.data!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
                  child: Container(
                    width: 80.0,
                    height: 3.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFE5E8),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0),
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ),
                        child: Image.network(
                          VcardGroup.singleVcardsCall.image(
                            columnSingleVcardsResponse.jsonBody,
                          )!,
                          width: 60.0,
                          height: 60.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                VcardGroup.singleVcardsCall.name(
                                  columnSingleVcardsResponse.jsonBody,
                                ),
                                'name',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    color: Colors.black,
                                    fontFamily: 'Nunito Sans',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey('Nunito Sans'),
                                  ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  VcardGroup.singleVcardsCall.occupation(
                                    columnSingleVcardsResponse.jsonBody,
                                  ),
                                  'occupation',
                                ).maybeHandleOverflow(
                                  maxChars: 30,
                                  replacement: '…',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito Sans',
                                      color: const Color(0xFF79818A),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Nunito Sans'),
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 0.0),
                              child: Text(
                                'Ngày tạo: ${functions.formatDate(valueOrDefault<String>(
                                  VcardGroup.singleVcardsCall.createdAt(
                                    columnSingleVcardsResponse.jsonBody,
                                  ),
                                  'date',
                                ))}',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito Sans',
                                      color: const Color(0xFF79818A),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Nunito Sans'),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (FFAppState().role == 'Admin') {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 25.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 100.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF6F8F9),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: Builder(
                                        builder: (context) {
                                          if (!FFAppState().isLoading) {
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                setState(() {
                                                  FFAppState().isLoading = true;
                                                });
                                                _model.qrCodeRes =
                                                    await VcardGroup
                                                        .vcardQrCodeCall
                                                        .call(
                                                  authToken:
                                                      FFAppState().authToken,
                                                  id: widget.vcardId,
                                                );
                                                if ((_model
                                                        .qrCodeRes?.succeeded ??
                                                    true)) {
                                                  if (isAndroid) {
                                                    _model.res = await actions
                                                        .downloadQrcode(
                                                      getJsonField(
                                                        (_model.qrCodeRes
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.data[0].url''',
                                                      ).toString(),
                                                      VcardGroup
                                                          .singleVcardsCall
                                                          .name(
                                                        columnSingleVcardsResponse
                                                            .jsonBody,
                                                      )!,
                                                    );
                                                    if (_model.res != '') {
                                                      await actions
                                                          .downloadNotification(
                                                        context,
                                                        'Success',
                                                        _model.res!,
                                                        const Color(0xFF46A44D),
                                                      );
                                                    } else {
                                                      await actions
                                                          .downloadNotification(
                                                        context,
                                                        'Error',
                                                        'Something went wrong.',
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .error,
                                                      );
                                                    }
                                                  } else {
                                                    _model.iosRes =
                                                        await actions
                                                            .downloadQrInIOS(
                                                      getJsonField(
                                                        (_model.qrCodeRes
                                                                ?.jsonBody ??
                                                            ''),
                                                        r'''$.data[0].url''',
                                                      ).toString(),
                                                    );
                                                    if (_model.iosRes != '') {
                                                      await actions
                                                          .downloadNotification(
                                                        context,
                                                        'Success',
                                                        _model.iosRes!,
                                                        const Color(0xFF46A44D),
                                                      );
                                                    } else {
                                                      await actions
                                                          .downloadNotification(
                                                        context,
                                                        'Error',
                                                        'Something went wrong.',
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .error,
                                                      );
                                                    }
                                                  }
                                                } else {
                                                  await actions.customSnackbar(
                                                    context,
                                                    'Something went Wrong.',
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                  );
                                                }

                                                setState(() {
                                                  FFAppState().isLoading =
                                                      false;
                                                });

                                                setState(() {});
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(10.0,
                                                            12.0, 0.0, 12.0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                      child: Image.asset(
                                                        'assets/images/vcard_qr.png',
                                                        width: 30.0,
                                                        height: 200.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(10.0, 0.0,
                                                            0.0, 0.0),
                                                    child: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'czqtua31' /* QR Code */,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'Nunito Sans',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts:
                                                                GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        'Nunito Sans'),
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return const SizedBox(
                                              width: double.infinity,
                                              height: double.infinity,
                                              child:
                                                  custom_widgets.DownloadLoader(
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    width: 100.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF6F8F9),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            'appointment_screen',
                                            queryParameters: {
                                              'vcardID': serializeParam(
                                                VcardGroup.singleVcardsCall.id(
                                                  columnSingleVcardsResponse
                                                      .jsonBody,
                                                ),
                                                ParamType.int,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  const TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 300),
                                              ),
                                            },
                                          );

                                          FFAppState().isVcardAppointment =
                                              true;
                                          FFAppState().selectedDrawerPage =
                                              'Appointments';
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      10.0, 12.0, 0.0, 12.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                child: Image.asset(
                                                  'assets/images/vcard_appointment.png',
                                                  width: 30.0,
                                                  height: 200.0,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      10.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'pjqehk70' /* Appointment */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      color: Colors.black,
                                                      fontFamily: 'Nunito Sans',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      useGoogleFonts:
                                                          GoogleFonts.asMap()
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
                              ].divide(const SizedBox(width: 15.0)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: 100.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF6F8F9),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Align(
                                      alignment:
                                          const AlignmentDirectional(0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                            'enquiries_screen',
                                            queryParameters: {
                                              'vcardID': serializeParam(
                                                VcardGroup.singleVcardsCall.id(
                                                  columnSingleVcardsResponse
                                                      .jsonBody,
                                                ),
                                                ParamType.int,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  const TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                                duration:
                                                    Duration(milliseconds: 300),
                                              ),
                                            },
                                          );

                                          FFAppState().isVcardEnquiry = true;
                                          FFAppState().selectedDrawerPage =
                                              'Enquiries';
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      10.0, 12.0, 0.0, 12.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                child: Image.asset(
                                                  'assets/images/vcard_enquiry.png',
                                                  width: 30.0,
                                                  height: 200.0,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      10.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'scgrnjh5' /* Enquiries */,
                                                ),
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      color: Colors.black,
                                                      fontFamily: 'Nunito Sans',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      useGoogleFonts:
                                                          GoogleFonts.asMap()
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
                                Expanded(
                                  child: Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        final success = await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 1,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  const AlignmentDirectional(
                                                          0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: DeleteDialogBoxWidget(
                                                titile:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  '8qp2hsel' /* Delete Vcard */,
                                                ),
                                                subtitle:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'rjtl9wlc' /* Are you sure want to delete th... */,
                                                ),
                                                deleteId: VcardGroup
                                                    .singleVcardsCall
                                                    .id(
                                                  columnSingleVcardsResponse
                                                      .jsonBody,
                                                )!,
                                                deleteType: 'Vcard',
                                              ),
                                            );
                                          },
                                        );

                                        context.pop(success);
                                      },
                                      child: Container(
                                        width: 100.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF6F8F9),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Align(
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        10.0, 12.0, 0.0, 12.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                  child: Image.asset(
                                                    'assets/images/vcard_delete.png',
                                                    width: 30.0,
                                                    height: 200.0,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'nbadcbhy' /* Delete */,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'Nunito Sans',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        useGoogleFonts:
                                                            GoogleFonts.asMap()
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
                              ].divide(const SizedBox(width: 15.0)),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 15.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          height: 45.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6F8F9),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                if (!FFAppState().isLoading) {
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      setState(() {
                                        FFAppState().isLoading = true;
                                      });
                                      _model.qrCodeRes1 =
                                          await VcardGroup.vcardQrCodeCall.call(
                                        authToken: FFAppState().authToken,
                                        id: widget.vcardId,
                                      );
                                      if ((_model.qrCodeRes?.succeeded ??
                                          true)) {
                                        if (isAndroid) {
                                          _model.res1 =
                                              await actions.downloadQrcode(
                                            getJsonField(
                                              (_model.qrCodeRes?.jsonBody ??
                                                  ''),
                                              r'''$.data[0].url''',
                                            ).toString(),
                                            VcardGroup.singleVcardsCall.name(
                                              columnSingleVcardsResponse
                                                  .jsonBody,
                                            )!,
                                          );
                                          if (_model.res1 != '') {
                                            await actions.downloadNotification(
                                              context,
                                              'Success',
                                              _model.res1!,
                                              const Color(0xFF46A44D),
                                            );
                                          } else {
                                            await actions.downloadNotification(
                                              context,
                                              'Error',
                                              'Something went wrong.',
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                            );
                                          }
                                        } else {
                                          _model.iosRes1 =
                                              await actions.downloadQrInIOS(
                                            getJsonField(
                                              (_model.qrCodeRes?.jsonBody ??
                                                  ''),
                                              r'''$.data[0].url''',
                                            ).toString(),
                                          );
                                          if (_model.iosRes1 != '') {
                                            await actions.downloadNotification(
                                              context,
                                              'Success',
                                              _model.iosRes1!,
                                              const Color(0xFF46A44D),
                                            );
                                          } else {
                                            await actions.downloadNotification(
                                              context,
                                              'Error',
                                              'Something went wrong.',
                                              FlutterFlowTheme.of(context)
                                                  .error,
                                            );
                                          }
                                        }
                                      } else {
                                        await actions.customSnackbar(
                                          context,
                                          'Something went Wrong.',
                                          FlutterFlowTheme.of(context).error,
                                        );
                                      }

                                      setState(() {
                                        FFAppState().isLoading = false;
                                      });

                                      setState(() {});
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10.0, 12.0, 0.0, 12.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0.0),
                                            child: Image.asset(
                                              'assets/images/vcard_qr.png',
                                              width: 30.0,
                                              height: 200.0,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              '5837yt5h' /* QR Code */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  color: Colors.black,
                                                  fontFamily: 'Nunito Sans',
                                                  fontWeight: FontWeight.bold,
                                                  useGoogleFonts:
                                                      GoogleFonts.asMap()
                                                          .containsKey(
                                                              'Nunito Sans'),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: custom_widgets.DownloadLoader(
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                FutureBuilder(
                  future: NfcManager.instance.isAvailable(),
                  builder: ((context, snapshot) {
                    if (snapshot.data == true) {
                      return Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.safePop();
                            await showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: NfcWriteSheetWidget(
                                    url: widget.url!,
                                    name: VcardGroup.singleVcardsCall.name(
                                      columnSingleVcardsResponse.jsonBody,
                                    )!,
                                  ),
                                );
                              },
                            ).then((value) => safeSetState(() {}));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1F69F6),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 12.0, 0.0, 12.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0.0),
                                      child: Image.asset(
                                        'assets/images/nfc.png',
                                        width: 30.0,
                                        height: 200.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'om39cqak' /* Write NFC */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito Sans',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey('Nunito Sans'),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
