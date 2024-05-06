import '/backend/api_requests/api_calls.dart';
import '/component/drawer/drawer_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'setting_screen_model.dart';
export 'setting_screen_model.dart';

class SettingScreenWidget extends StatefulWidget {
  const SettingScreenWidget({super.key});

  @override
  State<SettingScreenWidget> createState() => _SettingScreenWidgetState();
}

class _SettingScreenWidgetState extends State<SettingScreenWidget> {
  late SettingScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        FFAppState().isLoading = true;
      });
      await Future.delayed(const Duration(milliseconds: 3000));
      setState(() {
        FFAppState().isLoading = false;
      });
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Drawer(
          elevation: 16.0,
          child: wrapWithModel(
            model: _model.drawerModel,
            updateCallback: () => setState(() {}),
            child: const DrawerWidget(),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              scaffoldKey.currentState!.openDrawer();
            },
            child: Container(
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    12.0, 17.0, 25.0, 17.0),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: const Color(0x00FFFFFF),
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      image: Image.asset(
                        'assets/images/drawer.png',
                      ).image,
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              '2vqrk4yt' /* Settings */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Nunito Sans',
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts:
                      GoogleFonts.asMap().containsKey('Nunito Sans'),
                ),
          ),
          centerTitle: true,
          elevation: 2.0,
        ),
        body: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FutureBuilder<ApiCallResponse>(
                      future: VcardGroup.profileCall.call(
                        authToken: FFAppState().authToken,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final columnProfileResponse = snapshot.data!;
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(50.0),
                                  bottomRight: Radius.circular(50.0),
                                  topLeft: Radius.circular(50.0),
                                  topRight: Radius.circular(50.0),
                                ),
                                child: Image.network(
                                  VcardGroup.profileCall.image(
                                    columnProfileResponse.jsonBody,
                                  )!,
                                  width: 90.0,
                                  height: 90.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Text(
                                valueOrDefault<String>(
                                  VcardGroup.profileCall.firstName(
                                    columnProfileResponse.jsonBody,
                                  ),
                                  'firstName',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito Sans',
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey('Nunito Sans'),
                                    ),
                              ),
                            ),
                            Text(
                              valueOrDefault<String>(
                                VcardGroup.profileCall.email(
                                  columnProfileResponse.jsonBody,
                                ),
                                'email',
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
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 20.0, 0.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'edit_profile_screen',
                                    queryParameters: {
                                      'profileData': serializeParam(
                                        getJsonField(
                                          columnProfileResponse.jsonBody,
                                          r'''$.data[0]''',
                                        ),
                                        ParamType.JSON,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: const TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 300),
                                      ),
                                    },
                                  );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.38,
                                  height: 35.0,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1F69F6),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  alignment:
                                      const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 10.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'mg8rhguv' /* Edit Profile */,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito Sans',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey(
                                                            'Nunito Sans'),
                                              ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 0.0, 0.0, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.white,
                                            size: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 30.0, 0.0, 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'y9n16027' /* Language */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito Sans',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Nunito Sans'),
                                        ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'language_screen',
                                        queryParameters: {
                                          'isChange': serializeParam(
                                            true,
                                            ParamType.bool,
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

                                      if (VcardGroup.profileCall.language(
                                            columnProfileResponse.jsonBody,
                                          ) ==
                                          'Arabic') {
                                        setState(() {
                                          FFAppState().selectLanguageIndex = 0;
                                        });
                                      } else {
                                        if (VcardGroup.profileCall.language(
                                              columnProfileResponse.jsonBody,
                                            ) ==
                                            'Chinese') {
                                          setState(() {
                                            FFAppState().selectLanguageIndex =
                                                1;
                                          });
                                        } else {
                                          if (VcardGroup.profileCall.language(
                                                columnProfileResponse.jsonBody,
                                              ) ==
                                              'English') {
                                            setState(() {
                                              FFAppState().selectLanguageIndex =
                                                  2;
                                            });
                                          } else {
                                            if (VcardGroup.profileCall.language(
                                                  columnProfileResponse
                                                      .jsonBody,
                                                ) ==
                                                'French') {
                                              setState(() {
                                                FFAppState()
                                                    .selectLanguageIndex = 3;
                                              });
                                            } else {
                                              if (VcardGroup.profileCall
                                                      .language(
                                                    columnProfileResponse
                                                        .jsonBody,
                                                  ) ==
                                                  'German') {
                                                setState(() {
                                                  FFAppState()
                                                      .selectLanguageIndex = 4;
                                                });
                                              } else {
                                                if (VcardGroup.profileCall
                                                        .language(
                                                      columnProfileResponse
                                                          .jsonBody,
                                                    ) ==
                                                    'Portuguese') {
                                                  setState(() {
                                                    FFAppState()
                                                        .selectLanguageIndex = 5;
                                                  });
                                                } else {
                                                  if (VcardGroup.profileCall
                                                          .language(
                                                        columnProfileResponse
                                                            .jsonBody,
                                                      ) ==
                                                      'Russian') {
                                                    setState(() {
                                                      FFAppState()
                                                          .selectLanguageIndex = 6;
                                                    });
                                                  } else {
                                                    if (VcardGroup.profileCall
                                                            .language(
                                                          columnProfileResponse
                                                              .jsonBody,
                                                        ) ==
                                                        'Spanish') {
                                                      setState(() {
                                                        FFAppState()
                                                            .selectLanguageIndex = 7;
                                                      });
                                                    } else {
                                                      if (VcardGroup.profileCall
                                                              .language(
                                                            columnProfileResponse
                                                                .jsonBody,
                                                          ) ==
                                                          'Turkish') {
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
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            VcardGroup.profileCall.language(
                                              columnProfileResponse.jsonBody,
                                            ),
                                            'language',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito Sans',
                                                color: const Color(0xFF79818A),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts:
                                                    GoogleFonts.asMap()
                                                        .containsKey(
                                                            'Nunito Sans'),
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10.0, 0.0, 0.0, 0.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1.0,
                              color: Color(0xFFAAB0B8),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 8.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'change_password_screen',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: const TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 300),
                                      ),
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'i7c0zshr' /* Change Password */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito Sans',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey('Nunito Sans'),
                                          ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      size: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Builder(
                      builder: (context) {
                        if (FFAppState().role == 'Admin') {
                          return FutureBuilder<ApiCallResponse>(
                            future: VcardGroup.settingsCall.call(
                              authToken: FFAppState().authToken,
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 40.0,
                                    height: 40.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final columnSettingsResponse = snapshot.data!;
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Divider(
                                    thickness: 1.0,
                                    color: Color(0xFFAAB0B8),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'lgxuhg43' /* Enable Affiliation */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito Sans',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                          'Nunito Sans'),
                                            ),
                                      ),
                                      Switch.adaptive(
                                        value: _model.switchValue1 ??=
                                            VcardGroup.settingsCall
                                                    .enableAffiliation(
                                                  columnSettingsResponse
                                                      .jsonBody,
                                                ) ==
                                                '1',
                                        onChanged: (newValue) async {
                                          setState(() =>
                                              _model.switchValue1 = newValue);
                                          if (newValue) {
                                            _model.affiliationOnRes =
                                                await VcardGroup
                                                    .settingUpdateCall
                                                    .call(
                                              authToken: FFAppState().authToken,
                                              enableAffiliation: '1',
                                              enableContact: VcardGroup
                                                  .settingsCall
                                                  .enableContact(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              hideStickybar: VcardGroup
                                                  .settingsCall
                                                  .hideStickybar(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              whatsappShare: VcardGroup
                                                  .settingsCall
                                                  .whatsappShare(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              timeFormat:
                                                  VcardGroup.settingsCall.time(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                            );
                                            if ((_model.affiliationOnRes
                                                    ?.succeeded ??
                                                true)) {
                                              setState(() {});
                                            }

                                            setState(() {});
                                          } else {
                                            _model.affiliationOffRes =
                                                await VcardGroup
                                                    .settingUpdateCall
                                                    .call(
                                              authToken: FFAppState().authToken,
                                              enableAffiliation: '0',
                                              enableContact: VcardGroup
                                                  .settingsCall
                                                  .enableContact(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              hideStickybar: VcardGroup
                                                  .settingsCall
                                                  .hideStickybar(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              whatsappShare: VcardGroup
                                                  .settingsCall
                                                  .whatsappShare(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              timeFormat:
                                                  VcardGroup.settingsCall.time(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                            );
                                            if ((_model.affiliationOffRes
                                                    ?.succeeded ??
                                                true)) {
                                              setState(() {});
                                            }

                                            setState(() {});
                                          }
                                        },
                                        activeColor: const Color(0xFF1F69F6),
                                        activeTrackColor:
                                            FlutterFlowTheme.of(context)
                                                .accent1,
                                        inactiveTrackColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                        inactiveThumbColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1.0,
                                    color: Color(0xFFAAB0B8),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'xcggpv4p' /* Enable Add to contact */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito Sans',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                          'Nunito Sans'),
                                            ),
                                      ),
                                      Switch.adaptive(
                                        value: _model.switchValue2 ??=
                                            VcardGroup.settingsCall
                                                    .enableContact(
                                                  columnSettingsResponse
                                                      .jsonBody,
                                                ) ==
                                                '1',
                                        onChanged: (newValue) async {
                                          setState(() =>
                                              _model.switchValue2 = newValue);
                                          if (newValue) {
                                            _model.contactOnRes =
                                                await VcardGroup
                                                    .settingUpdateCall
                                                    .call(
                                              authToken: FFAppState().authToken,
                                              enableAffiliation: VcardGroup
                                                  .settingsCall
                                                  .enableAffiliation(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              enableContact: '1',
                                              hideStickybar: VcardGroup
                                                  .settingsCall
                                                  .hideStickybar(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              whatsappShare: VcardGroup
                                                  .settingsCall
                                                  .whatsappShare(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              timeFormat:
                                                  VcardGroup.settingsCall.time(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                            );
                                            if ((_model
                                                    .contactOnRes?.succeeded ??
                                                true)) {
                                              setState(() {});
                                            }

                                            setState(() {});
                                          } else {
                                            _model.contactOffRes =
                                                await VcardGroup
                                                    .settingUpdateCall
                                                    .call(
                                              authToken: FFAppState().authToken,
                                              enableAffiliation: VcardGroup
                                                  .settingsCall
                                                  .enableAffiliation(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              enableContact: '0',
                                              hideStickybar: VcardGroup
                                                  .settingsCall
                                                  .hideStickybar(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              whatsappShare: VcardGroup
                                                  .settingsCall
                                                  .whatsappShare(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              timeFormat:
                                                  VcardGroup.settingsCall.time(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                            );
                                            if ((_model
                                                    .contactOffRes?.succeeded ??
                                                true)) {
                                              setState(() {});
                                            }

                                            setState(() {});
                                          }
                                        },
                                        activeColor: const Color(0xFF1F69F6),
                                        activeTrackColor:
                                            FlutterFlowTheme.of(context)
                                                .accent1,
                                        inactiveTrackColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                        inactiveThumbColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1.0,
                                    color: Color(0xFFAAB0B8),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'qbhjmxyf' /* Hide vCard Sticky Bar */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito Sans',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                          'Nunito Sans'),
                                            ),
                                      ),
                                      Switch.adaptive(
                                        value: _model.switchValue3 ??=
                                            VcardGroup.settingsCall
                                                    .hideStickybar(
                                                  columnSettingsResponse
                                                      .jsonBody,
                                                ) ==
                                                '1',
                                        onChanged: (newValue) async {
                                          setState(() =>
                                              _model.switchValue3 = newValue);
                                          if (newValue) {
                                            _model.stickybarOnRes =
                                                await VcardGroup
                                                    .settingUpdateCall
                                                    .call(
                                              authToken: FFAppState().authToken,
                                              enableAffiliation: VcardGroup
                                                  .settingsCall
                                                  .enableAffiliation(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              enableContact: VcardGroup
                                                  .settingsCall
                                                  .enableContact(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              hideStickybar: '1',
                                              whatsappShare: VcardGroup
                                                  .settingsCall
                                                  .whatsappShare(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              timeFormat:
                                                  VcardGroup.settingsCall.time(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                            );
                                            if ((_model.stickybarOffRes
                                                    ?.succeeded ??
                                                true)) {
                                              setState(() {});
                                            }

                                            setState(() {});
                                          } else {
                                            _model.stickybarOffRes =
                                                await VcardGroup
                                                    .settingUpdateCall
                                                    .call(
                                              authToken: FFAppState().authToken,
                                              enableAffiliation: VcardGroup
                                                  .settingsCall
                                                  .enableAffiliation(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              enableContact: VcardGroup
                                                  .settingsCall
                                                  .enableContact(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              hideStickybar: '0',
                                              whatsappShare: VcardGroup
                                                  .settingsCall
                                                  .whatsappShare(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              timeFormat:
                                                  VcardGroup.settingsCall.time(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                            );
                                            if ((_model.stickybarOffRes
                                                    ?.succeeded ??
                                                true)) {
                                              setState(() {});
                                            }

                                            setState(() {});
                                          }
                                        },
                                        activeColor: const Color(0xFF1F69F6),
                                        activeTrackColor:
                                            FlutterFlowTheme.of(context)
                                                .accent1,
                                        inactiveTrackColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                        inactiveThumbColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1.0,
                                    color: Color(0xFFAAB0B8),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          '0n5cykg2' /* WhatsApp Share */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito Sans',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                          'Nunito Sans'),
                                            ),
                                      ),
                                      Switch.adaptive(
                                        value: _model.switchValue4 ??=
                                            VcardGroup.settingsCall
                                                    .whatsappShare(
                                                  columnSettingsResponse
                                                      .jsonBody,
                                                ) ==
                                                '1',
                                        onChanged: (newValue) async {
                                          setState(() =>
                                              _model.switchValue4 = newValue);
                                          if (newValue) {
                                            _model.whatsappOnRes =
                                                await VcardGroup
                                                    .settingUpdateCall
                                                    .call(
                                              authToken: FFAppState().authToken,
                                              enableAffiliation: VcardGroup
                                                  .settingsCall
                                                  .enableAffiliation(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              enableContact: VcardGroup
                                                  .settingsCall
                                                  .enableContact(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              hideStickybar: VcardGroup
                                                  .settingsCall
                                                  .hideStickybar(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              whatsappShare: '1',
                                              timeFormat:
                                                  VcardGroup.settingsCall.time(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                            );
                                            if ((_model
                                                    .whatsappOnRes?.succeeded ??
                                                true)) {
                                              setState(() {});
                                            }

                                            setState(() {});
                                          } else {
                                            _model.whatsappOffRes =
                                                await VcardGroup
                                                    .settingUpdateCall
                                                    .call(
                                              authToken: FFAppState().authToken,
                                              enableAffiliation: VcardGroup
                                                  .settingsCall
                                                  .enableAffiliation(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              enableContact: VcardGroup
                                                  .settingsCall
                                                  .enableContact(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              hideStickybar: VcardGroup
                                                  .settingsCall
                                                  .hideStickybar(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                              whatsappShare: '0',
                                              timeFormat:
                                                  VcardGroup.settingsCall.time(
                                                columnSettingsResponse.jsonBody,
                                              ),
                                            );
                                            if ((_model.whatsappOffRes
                                                    ?.succeeded ??
                                                true)) {
                                              setState(() {});
                                            }

                                            setState(() {});
                                          }
                                        },
                                        activeColor: const Color(0xFF1F69F6),
                                        activeTrackColor:
                                            FlutterFlowTheme.of(context)
                                                .accent1,
                                        inactiveTrackColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                        inactiveThumbColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          return Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (FFAppState().isLoading)
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: const Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: custom_widgets.CustomLoader(
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
