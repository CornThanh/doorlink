import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'delete_dialog_box_model.dart';
export 'delete_dialog_box_model.dart';

class DeleteDialogBoxWidget extends StatefulWidget {
  const DeleteDialogBoxWidget({
    super.key,
    required this.titile,
    required this.subtitle,
    required this.deleteId,
    required this.deleteType,
  });

  final String? titile;
  final String? subtitle;
  final int? deleteId;
  final String? deleteType;

  @override
  State<DeleteDialogBoxWidget> createState() => _DeleteDialogBoxWidgetState();
}

class _DeleteDialogBoxWidgetState extends State<DeleteDialogBoxWidget> {
  late DeleteDialogBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeleteDialogBoxModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 0.0),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 350.0,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.asset(
                    'assets/images/delete.png',
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.titile,
                      'title',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito Sans',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Nunito Sans'),
                        ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.subtitle,
                      'subtitle',
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito Sans',
                          color: const Color(0xFF79818A),
                          fontWeight: FontWeight.normal,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Nunito Sans'),
                        ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.safePop();
                          },
                          text: FFLocalizations.of(context).getText(
                            'vs9ndxz8' /* Cancel */,
                          ),
                          options: FFButtonOptions(
                            width: 145.0,
                            height: 45.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: const Color(0xFFF6F8F9),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Nunito Sans',
                                  color: const Color(0xFF79818A),
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey('Nunito Sans'),
                                ),
                            elevation: 1.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (widget.deleteType == 'Appointment') {
                              _model.appointmentRes =
                                  await VcardGroup.deleteAppointmentCall.call(
                                id: widget.deleteId,
                                authToken: FFAppState().authToken,
                              );
                              if (VcardGroup.deleteAppointmentCall.success(
                                (_model.appointmentRes?.jsonBody ?? ''),
                              )!) {
                                context.pop(true);
                                FFAppState().update(() {
                                  FFAppState().isLoading = true;
                                });
                                await actions.customSnackbar(
                                  context,
                                  FFLocalizations.of(context).getVariableText(
                                    viText: 'Xóa cuộc hẹn thành công.',
                                    enText: 'Appointment Delete Successfully.',
                                  ),
                                  const Color(0xFF46A44D),
                                );
                                await Future.delayed(
                                    const Duration(milliseconds: 100));
                                FFAppState().update(() {
                                  FFAppState().isLoading = false;
                                });
                              } else {
                                context.pop(false);
                                await actions.customSnackbar(
                                  context,
                                  FFLocalizations.of(context).getVariableText(
                                    viText: 'Không thể xóa cuộc hẹn.',
                                    enText: 'Failed to Delete Appointment.',
                                  ),
                                  FlutterFlowTheme.of(context).error,
                                );
                              }
                            } else {
                              if (widget.deleteType == 'Enquiry') {
                                _model.enquiryRes =
                                    await VcardGroup.deleteEnquiryCall.call(
                                  authToken: FFAppState().authToken,
                                  id: widget.deleteId,
                                );
                                if (VcardGroup.deleteEnquiryCall.success(
                                  (_model.enquiryRes?.jsonBody ?? ''),
                                )!) {
                                  Navigator.pop(context);
                                  FFAppState().update(() {
                                    FFAppState().isLoading = true;
                                  });
                                  await actions.customSnackbar(
                                    context,
                                    FFLocalizations.of(context).getVariableText(
                                      viText: 'Xóa yêu cầu thành công.',
                                      enText: 'Enquiry Delete Successfully.',
                                    ),
                                    const Color(0xFF46A44D),
                                  );
                                  await Future.delayed(
                                      const Duration(milliseconds: 100));
                                  FFAppState().update(() {
                                    FFAppState().isLoading = false;
                                  });
                                } else {
                                  context.safePop();
                                  await actions.customSnackbar(
                                    context,
                                    FFLocalizations.of(context).getVariableText(
                                      viText: 'Không thể xóa yêu cầu.',
                                      enText: 'Failed to Delete Enquiry.',
                                    ),
                                    FlutterFlowTheme.of(context).error,
                                  );
                                }
                              } else {
                                if (widget.deleteType == 'Vcard') {
                                  _model.apiResult510 =
                                      await VcardGroup.deleteVcardCall.call(
                                    authToken: FFAppState().authToken,
                                    id: widget.deleteId,
                                  );
                                  if (VcardGroup.deleteVcardCall.success(
                                    (_model.apiResult510?.jsonBody ?? ''),
                                  )!) {
                                    Navigator.pop(context, true);
                                    FFAppState().update(() {
                                      FFAppState().isLoading = true;
                                    });
                                    await actions.customSnackbar(
                                      context,
                                      FFLocalizations.of(context)
                                          .getVariableText(
                                        viText: 'Xóa Vcard thành công.',
                                        enText: 'Vcard Delete Successfully.',
                                      ),
                                      const Color(0xFF46A44D),
                                    );
                                    await Future.delayed(
                                        const Duration(milliseconds: 100));
                                    FFAppState().update(() {
                                      FFAppState().isLoading = false;
                                    });
                                  } else {
                                    context.safePop();
                                    await actions.customSnackbar(
                                      context,
                                      FFLocalizations.of(context)
                                          .getVariableText(
                                        viText: 'Không thể xóa Vcard.',
                                        enText: 'Failed to Delete Vcard.',
                                      ),
                                      FlutterFlowTheme.of(context).error,
                                    );
                                  }
                                }
                              }
                            }

                            setState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'l72rvcpp' /* Delete */,
                          ),
                          options: FFButtonOptions(
                            width: 145.0,
                            height: 45.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: const Color(0xFF1F69F6),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Nunito Sans',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey('Nunito Sans'),
                                ),
                            elevation: 1.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ]
                        .divide(const SizedBox(width: 15.0))
                        .addToStart(const SizedBox(width: 5.0))
                        .addToEnd(const SizedBox(width: 5.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
