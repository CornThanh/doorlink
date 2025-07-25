import 'dart:async';

import 'package:doorlink_mobile/features/auth/phone_number/repository/phone_number_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';

import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'phone_number_screen_model.dart';

export 'phone_number_screen_model.dart';

class PhoneNumberScreenWidget extends StatefulWidget {
  const PhoneNumberScreenWidget({super.key});

  @override
  State<PhoneNumberScreenWidget> createState() =>
      _PhoneNumberScreenWidgetState();
}

class _PhoneNumberScreenWidgetState extends State<PhoneNumberScreenWidget> {
  late PhoneNumberScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhoneNumberScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.height = MediaQuery.sizeOf(context).height;
      });
    });

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        setState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    _model.phoneNumberController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/BG_(2).png',
                ).image,
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 0.0),
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  0,
                  70.0,
                  0,
                  (isWeb
                          ? MediaQuery.viewInsetsOf(context).bottom > 0
                          : _isKeyboardVisible)
                      ? 300.0
                      : 20.0,
                ),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/login_vector.png',
                        height: MediaQuery.sizeOf(context).height * 0.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 30.0, 0.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '6hyvkz90' /* Login */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Nunito Sans',
                            fontSize: 26.0,
                            fontWeight: FontWeight.w800,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Nunito Sans'),
                          ),
                    ),
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'fgce4hqx' /* Enter your phone number */,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito Sans',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 16.0,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Nunito Sans'),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 40.0, 0.0, 0.0),
                    child: TextFormField(
                      controller: _model.phoneNumberController,
                      focusNode: _model.phoneNumberFocusNode,
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Nunito Sans',
                                  color: Colors.black,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey('Nunito Sans'),
                                ),
                        hintText: FFLocalizations.of(context).getText(
                          'jznj5x2j' /* Enter Your First Name */,
                        ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey('Nunito Sans'),
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0x0079818A),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFF6F8F9),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.1),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium,
                      validator: _model.phoneNumberControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 80.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () => _onPressedSend(),
                      text: FFLocalizations.of(context).getText(
                        'bj2tmfun' /* Send */,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: const Color(0xFF1A4572),
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
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 12.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        context.pop();
                      },
                      text: FFLocalizations.of(context).getText(
                        'y9tifkv3' /* Back */,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 0.0),
                        color: const Color(0xFFE9F0FF),
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Nunito Sans',
                                  color: const Color(0xFF1A4572),
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
                ].addToEnd(SizedBox(
                    height: (isWeb
                            ? MediaQuery.viewInsetsOf(context).bottom > 0
                            : _isKeyboardVisible)
                        ? 300.0
                        : 20.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPressedSend() async {
    if ((_model.phoneNumberController.text != '') &&
        await actions
            .vietnamPhoneValidation(_model.phoneNumberController.text)) {
      _model.phoneNumberRes = await PhoneNumberRepository.verify(
        verificationPhone: _model.phoneNumberController.text,
      );

      if (mounted) {
        if ((_model.phoneNumberRes?.succeeded ?? true)) {
          context.pushNamed(
            'otp',
            queryParameters: {
              'phoneNumber': serializeParam(
                _model.phoneNumberController.text,
                ParamType.String,
              ),
            }.withoutNulls,
            extra: <String, dynamic>{
              kTransitionInfoKey: const TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 400),
              ),
            },
          );
        } else {
          await actions.customSnackbar(
            context,
            valueOrDefault<String>(
              getJsonField(
                (_model.phoneNumberRes?.jsonBody ?? ''),
                r'''$.message''',
              )?.toString(),
              'Registration failed.',
            ),
            FlutterFlowTheme.of(context).error,
          );
        }
      }
    } else {
      if (mounted) {
        await actions.customSnackbar(
          context,
          FFLocalizations.of(context).getVariableText(
            viText: 'Vui lòng nhập đúng số điện thoại.',
            enText: 'Please enter correct phone number.',
          ),
          FlutterFlowTheme.of(context).error,
        );
      }
    }

    setState(() {});
  }
}
