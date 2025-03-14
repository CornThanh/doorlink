import 'dart:developer';
import 'package:MeU/features/main/change_password/repository/change_password_repository.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'change_password_screen_model.dart';
export 'change_password_screen_model.dart';

class ChangePasswordScreenWidget extends StatefulWidget {
  const ChangePasswordScreenWidget({super.key});

  @override
  State<ChangePasswordScreenWidget> createState() =>
      _ChangePasswordScreenWidgetState();
}

class _ChangePasswordScreenWidgetState
    extends State<ChangePasswordScreenWidget> {
  late ChangePasswordScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangePasswordScreenModel());

    _model.currentPasswordController ??= TextEditingController();
    _model.currentPasswordFocusNode ??= FocusNode();

    _model.newPasswordController ??= TextEditingController();
    _model.newPasswordFocusNode ??= FocusNode();

    _model.confirmPasswordController ??= TextEditingController();
    _model.confirmPasswordFocusNode ??= FocusNode();
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
          backgroundColor: const Color(0xff333333),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 24.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'malgoxmk' /* Change Password */,
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
          centerTitle: true,
          elevation: 1.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: _buildRichText(
                  FFLocalizations.of(context).getText(
                    'xcayyr1i' /* Current Password: */,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: TextFormField(
                  controller: _model.currentPasswordController,
                  focusNode: _model.currentPasswordFocusNode,
                  obscureText: !_model.currentPasswordVisibility,
                  decoration: InputDecoration(
                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                    hintText: FFLocalizations.of(context).getText(
                      'rm8akjbc' /* Current Password */,
                    ),
                    hintStyle: FlutterFlowTheme.of(context).labelMedium,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFE0E3E7),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: InkWell(
                      onTap: () => setState(
                        () => _model.currentPasswordVisibility =
                            !_model.currentPasswordVisibility,
                      ),
                      focusNode: FocusNode(skipTraversal: true),
                      child: Icon(
                        _model.currentPasswordVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF79818A),
                        size: 20.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x0079818A),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                  validator: _model.currentPasswordControllerValidator
                      .asValidator(context),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: _buildRichText(
                  FFLocalizations.of(context).getText(
                    '3h03ny4j' /* New Password: */,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: TextFormField(
                  controller: _model.newPasswordController,
                  focusNode: _model.newPasswordFocusNode,
                  obscureText: !_model.newPasswordVisibility,
                  decoration: InputDecoration(
                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                    hintText: FFLocalizations.of(context).getText(
                      '38oe3q7h' /* New Password */,
                    ),
                    hintStyle: FlutterFlowTheme.of(context).labelMedium,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x0079818A),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: InkWell(
                      onTap: () => setState(
                        () => _model.newPasswordVisibility =
                            !_model.newPasswordVisibility,
                      ),
                      focusNode: FocusNode(skipTraversal: true),
                      child: Icon(
                        _model.newPasswordVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF79818A),
                        size: 20.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                  validator: _model.newPasswordControllerValidator
                      .asValidator(context),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: _buildRichText(
                  FFLocalizations.of(context).getText(
                    '7aycies1' /* Confirm Password: */,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: TextFormField(
                  controller: _model.confirmPasswordController,
                  focusNode: _model.confirmPasswordFocusNode,
                  obscureText: !_model.confirmPasswordVisibility,
                  decoration: InputDecoration(
                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                    hintText: FFLocalizations.of(context).getText(
                      'a73s21iu' /* Confirm Password */,
                    ),
                    hintStyle: FlutterFlowTheme.of(context).labelMedium,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x0079818A),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: InkWell(
                      onTap: () => setState(
                        () => _model.confirmPasswordVisibility =
                            !_model.confirmPasswordVisibility,
                      ),
                      focusNode: FocusNode(skipTraversal: true),
                      child: Icon(
                        _model.confirmPasswordVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF79818A),
                        size: 20.0,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                  validator: _model.confirmPasswordControllerValidator
                      .asValidator(context),
                ),
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () => _onPressedSave(),
                        text: FFLocalizations.of(context).getText(
                          '9jxexqm3' /* Save */,
                        ),
                        options: FFButtonOptions(
                          width: 175.0,
                          height: 50.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: const Color(0xFF1F69F6),
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.safePop();
                        },
                        text: FFLocalizations.of(context).getText(
                          '6dvjt0n2' /* Cancel */,
                        ),
                        options: FFButtonOptions(
                          width: 175.0,
                          height: 50.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: const Color(0xFFF6F8F9),
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .titleSmallFamily,
                                color: const Color(0xFF79818A),
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .titleSmallFamily),
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
                  ].divide(const SizedBox(width: 15.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRichText(String text) {
    return RichText(
      textScaler: MediaQuery.of(context).textScaler,
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Nunito Sans',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts:
                      GoogleFonts.asMap().containsKey('Nunito Sans'),
                ),
          ),
          TextSpan(
            text: FFLocalizations.of(context).getText(
              'gj7gq0fk' /*  * */,
            ),
            style: const TextStyle(
              color: Color(0xFFF35050),
              fontSize: 18.0,
            ),
          )
        ],
        style: FlutterFlowTheme.of(context).bodyMedium,
      ),
    );
  }

  Future<void> _onPressedSave() async {
    try {
      if (_model.currentPasswordController.text != '') {
        if (_model.newPasswordController.text != '') {
          if (_model.confirmPasswordController.text != '') {
            if (_model.newPasswordController.text ==
                _model.confirmPasswordController.text) {
              _model.apiResult141 =
                  await ChangePasswordRepository.changePassword(
                authToken: FFAppState().authToken,
                email: FFAppState().email,
                oldPassword: _model.currentPasswordController.text,
                newPassword: _model.newPasswordController.text,
                confirmPassword: _model.confirmPasswordController.text,
              );

              if ((_model.apiResult141?.succeeded ?? true) && mounted) {
                context.safePop();
                await actions.customSnackbar(
                  context,
                  FFLocalizations.of(context).getVariableText(
                    viText: 'Thay đổi mật khẩu thành công.',
                    enText: 'Password Changed Successfully.',
                  ),
                  const Color(0xFF46A44D),
                );
              } else {
                if (mounted) {
                  await actions.customSnackbar(
                    context,
                    FFLocalizations.of(context).getVariableText(
                      viText: 'Thay đổi mật khẩu thất bại.',
                      enText: 'Password change failed.',
                    ),
                    FlutterFlowTheme.of(context).error,
                  );
                }
              }
            } else {
              await actions.customSnackbar(
                context,
                FFLocalizations.of(context).getVariableText(
                  viText: 'Vui lòng nhập đúng mật khẩu.',
                  enText: 'Please enter correct password.',
                ),
                FlutterFlowTheme.of(context).error,
              );
            }
          } else {
            await actions.customSnackbar(
              context,
              FFLocalizations.of(context).getVariableText(
                viText: 'Vui lòng Nhập Xác nhận Mật khẩu.',
                enText: 'Please Enter Confirm Password.',
              ),
              FlutterFlowTheme.of(context).error,
            );
          }
        } else {
          await actions.customSnackbar(
            context,
            FFLocalizations.of(context).getVariableText(
              viText: 'Vui lòng nhập mật khẩu mới.',
              enText: 'Please Enter New Password.',
            ),
            FlutterFlowTheme.of(context).error,
          );
        }
      } else {
        await actions.customSnackbar(
          context,
          FFLocalizations.of(context).getVariableText(
            viText: 'Please Enter Password.',
            enText: 'Please Enter Password.',
          ),
          FlutterFlowTheme.of(context).error,
        );
      }

      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }
}
