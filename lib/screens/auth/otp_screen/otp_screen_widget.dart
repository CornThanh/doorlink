import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '/backend/api_requests/api_calls.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '../../../auth/custom_auth/auth_util.dart';
import 'otp_screen_model.dart';

export 'otp_screen_model.dart';

class OtpScreenWidget extends StatefulWidget {
  const OtpScreenWidget({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;

  @override
  State<OtpScreenWidget> createState() => _OtpScreenWidgetState();
}

class _OtpScreenWidgetState extends State<OtpScreenWidget> {
  late OtpScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OtpScreenModel());

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

    _model.otpController ??= TextEditingController();
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
                        '7n1kbue5' /* Login */,
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
                      'j2119ttc' /* OTP code has been sent */,
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
                        0.0, 16.0, 0.0, 8.0),
                    child: PinCodeTextField(
                      autoDisposeControllers: false,
                      appContext: context,
                      length: 6,
                      textStyle: FlutterFlowTheme.of(context)
                          .bodyLarge
                          .override(
                            fontFamily: 'Nunito Sans',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Nunito Sans'),
                          ),
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      enableActiveFill: false,
                      autoFocus: true,
                      errorTextSpace: 16.0,
                      showCursor: true,
                      cursorColor: FlutterFlowTheme.of(context).secondary,
                      hintCharacter: '-',
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        fieldHeight: 50.0,
                        fieldWidth: 50.0,
                        borderWidth: 1.0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        shape: PinCodeFieldShape.box,
                        activeColor: FlutterFlowTheme.of(context).secondary,
                        inactiveColor: FlutterFlowTheme.of(context).secondary,
                        selectedColor: FlutterFlowTheme.of(context).secondary,
                      ),
                      controller: _model.otpController,
                      onChanged: (_) {},
                      autovalidateMode: AutovalidateMode.always,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 80.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        Function() navigate = () {};
                        if (_model.otpController.text != '') {
                          _model.otpRes = await VcardGroup.verifiedOTPCall.call(
                              verificationPhone: widget.phoneNumber,
                              verificationCode: _model.otpController.text);

                          if ((_model.otpRes?.succeeded ?? true)) {
                            if (getJsonField(
                              (_model.otpRes?.jsonBody ?? ''),
                              r'''$.success''',
                            )) {
                              setState(() {
                                FFAppState().authToken = getJsonField(
                                  (_model.otpRes?.jsonBody ?? ''),
                                  r'''$.data.token''',
                                ).toString();
                                FFAppState().role = getJsonField(
                                  (_model.otpRes?.jsonBody ?? ''),
                                  r'''$.data.role''',
                                ).toString();
                                FFAppState().selectedDrawerPage = 'Dashboard';
                              });
                              _model.profileRes =
                                  await VcardGroup.profileCall.call(
                                authToken: getJsonField(
                                  (_model.otpRes?.jsonBody ?? ''),
                                  r'''$.data.token''',
                                ).toString(),
                              );
                              if ((_model.profileRes?.succeeded ?? true)) {
                                if (VcardGroup.profileCall.language(
                                      (_model.profileRes?.jsonBody ?? ''),
                                    ) ==
                                    'Arabic') {
                                  setAppLanguage(context, 'ar');
                                  setState(() {
                                    FFAppState().selectLanguageIndex = 0;
                                  });
                                } else {
                                  if (VcardGroup.profileCall.language(
                                        (_model.profileRes?.jsonBody ?? ''),
                                      ) ==
                                      'VietNam') {
                                    setAppLanguage(context, 'vi');
                                    setState(() {
                                      FFAppState().selectLanguageIndex = 1;
                                    });
                                  } else {
                                    if (VcardGroup.profileCall.language(
                                          (_model.profileRes?.jsonBody ?? ''),
                                        ) ==
                                        'English') {
                                      setAppLanguage(context, 'en');
                                      setState(() {
                                        FFAppState().selectLanguageIndex = 2;
                                      });
                                    } else {
                                      if (VcardGroup.profileCall.language(
                                            (_model.profileRes?.jsonBody ?? ''),
                                          ) ==
                                          'French') {
                                        setAppLanguage(context, 'fr');
                                        setState(() {
                                          FFAppState().selectLanguageIndex = 3;
                                        });
                                      } else {
                                        if (VcardGroup.profileCall.language(
                                              (_model.profileRes?.jsonBody ??
                                                  ''),
                                            ) ==
                                            'German') {
                                          setAppLanguage(context, 'de');
                                          setState(() {
                                            FFAppState().selectLanguageIndex =
                                                4;
                                          });
                                        } else {
                                          if (VcardGroup.profileCall.language(
                                                (_model.profileRes?.jsonBody ??
                                                    ''),
                                              ) ==
                                              'Portuguese') {
                                            setAppLanguage(context, 'pt');
                                            setState(() {
                                              FFAppState().selectLanguageIndex =
                                                  5;
                                            });
                                          } else {
                                            if (VcardGroup.profileCall.language(
                                                  (_model.profileRes
                                                          ?.jsonBody ??
                                                      ''),
                                                ) ==
                                                'Russian') {
                                              setAppLanguage(context, 'ru');
                                              setState(() {
                                                FFAppState()
                                                    .selectLanguageIndex = 6;
                                              });
                                            } else {
                                              if (VcardGroup.profileCall
                                                      .language(
                                                    (_model.profileRes
                                                            ?.jsonBody ??
                                                        ''),
                                                  ) ==
                                                  'Spanish') {
                                                setAppLanguage(context, 'es');
                                                setState(() {
                                                  FFAppState()
                                                      .selectLanguageIndex = 7;
                                                });
                                              } else {
                                                if (VcardGroup.profileCall
                                                        .language(
                                                      (_model.profileRes
                                                              ?.jsonBody ??
                                                          ''),
                                                    ) ==
                                                    'Turkish') {
                                                  setAppLanguage(context, 'tr');
                                                  setState(() {
                                                    FFAppState()
                                                        .selectLanguageIndex = 8;
                                                  });
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              } else {
                                await actions.customSnackbar(
                                  context,
                                  FFLocalizations.of(context).getVariableText(
                                    viText: 'Lỗi hồ sơ.',
                                    enText: 'Profile Error.',
                                  ),
                                  FlutterFlowTheme.of(context).error,
                                );
                              }

                              GoRouter.of(context).prepareAuthEvent();
                              await authManager.signIn(
                                authenticationToken: FFAppState().authToken,
                              );
                              navigate = () => context.goNamedAuth(
                                  'dashboard', context.mounted);
                            } else {
                              setState(() {
                                _model.otpController?.clear();
                              });
                              await actions.customSnackbar(
                                context,
                                getJsonField(
                                  (_model.otpRes?.jsonBody ?? ''),
                                  r'''$.message''',
                                ).toString(),
                                FlutterFlowTheme.of(context).error,
                              );
                            }
                          } else {
                            await actions.customSnackbar(
                              context,
                              getJsonField(
                                (_model.otpRes?.jsonBody ?? ''),
                                r'''$.message''',
                              ).toString(),
                              FlutterFlowTheme.of(context).error,
                            );
                          }
                        } else {
                          await actions.customSnackbar(
                            context,
                            FFLocalizations.of(context).getVariableText(
                              viText: 'Vui lòng nhập mã OTP.',
                              enText: 'Please Enter OTP Code.',
                            ),
                            FlutterFlowTheme.of(context).error,
                          );
                        }

                        navigate();

                        setState(() {});
                      },
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
                                  color: const Color(0xFF1F69F6),
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
}
