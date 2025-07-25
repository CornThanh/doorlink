import 'package:doorlink_mobile/component/delete_dialog_box/delete_dialog_box_widget.dart';
import 'package:doorlink_mobile/component/logout_dialog_box/logout_dialog_box_widget.dart';
import 'package:flutter/cupertino.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'setting_screen_model.dart';
export 'setting_screen_model.dart';

enum SettingScreenItems {
  logout,
  deleteAccount,
  // editProfile,
  // language,
  // changePassword,
}

class SettingScreenWidget extends StatefulWidget {
  const SettingScreenWidget({super.key});

  @override
  State<SettingScreenWidget> createState() => _SettingScreenWidgetState();
}

class _SettingScreenWidgetState extends State<SettingScreenWidget> {
  late SettingScreenViewModel _viewModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic columnProfileResponse = {};

  @override
  void initState() {
    super.initState();
    _viewModel = createModel(context, () => SettingScreenViewModel());

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
    _viewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _viewModel.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_viewModel.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Profile',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'Nunito Sans',
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts:
                      GoogleFonts.asMap().containsKey('Nunito Sans'),
                ),
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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    15.0, 20.0, 15.0, 20.0),
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
                                    FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                ),
                              ),
                            );
                          }
                          columnProfileResponse = snapshot.data!;
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
                                        ) ??
                                        '',
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
                                  onTap: () => _onPressedEditProfile(
                                      columnProfileResponse.jsonBody),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.38,
                                    height: 35.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1A4572),
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
                              const SizedBox(height: 32),
                              ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: _itemBuilder,
                                separatorBuilder: _separatorBuilder,
                                itemCount: SettingScreenItems.values.length,
                              )
                            ],
                          );
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
                    color: FlutterFlowTheme.of(context).primaryBackground,
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
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    String code = switch (SettingScreenItems.values[index]) {
      // SettingScreenItems.editProfile => 'y9n16127' /* Edit profile */,
      // SettingScreenItems.language => 'y9n16027' /* MyQR */,
      // SettingScreenItems.changePassword => 'i7c0zshr' /* Change Password */,
      // TODO: Handle this case.
      SettingScreenItems.logout => 'Logout' /* Logout */,
      // TODO: Handle this case.
      SettingScreenItems.deleteAccount => 'Delete Account' /* Delete Account */,
    };

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        switch (SettingScreenItems.values[index]) {
          // case SettingScreenItems.language:
          //   _onPressedLanguage();
          //   break;

          // case SettingScreenItems.changePassword:
          //   _onPressedChangePassword();
          //   break;
          // case SettingScreenItems.editProfile:
          //   _onPressedEditProfile(columnProfileResponse.jsonBody);
          //   break;
          case SettingScreenItems.logout:
            // TODO: Handle this case.
            await showDialog(
              context: context,
              builder: (dialogContext) {
                return Dialog(
                  elevation: 1,
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alignment: const AlignmentDirectional(0.0, 0.0)
                      .resolve(Directionality.of(context)),
                  child: const LogoutDialogBoxWidget(),
                );
              },
            );
            break;
          case SettingScreenItems.deleteAccount:
            await showDialog(
              context: context,
              builder: (dialogContext) {
                return Dialog(
                  elevation: 1,
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alignment: const AlignmentDirectional(0.0, 0.0)
                      .resolve(Directionality.of(context)),
                  child: DeleteDialogBoxWidget(
                    titile: 'Delete Account',
                    subtitle: 'Do you want to delete your account?',
                    deleteId: null,
                    deleteType: '',
                  ),
                );
              },
            );
            break;
        }
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              code,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Nunito Sans',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    useGoogleFonts:
                        GoogleFonts.asMap().containsKey('Nunito Sans'),
                  ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return Divider(
      thickness: 0.5,
      color: Colors.white.withValues(alpha: .2),
    );
  }

  // void _onPressedLanguage() {
  //   context.pushNamed(
  //     'language_screen',
  //     queryParameters: {
  //       'isChange': serializeParam(
  //         true,
  //         ParamType.bool,
  //       ),
  //     }.withoutNulls,
  //     extra: <String, dynamic>{
  //       kTransitionInfoKey: const TransitionInfo(
  //         hasTransition: true,
  //         transitionType: PageTransitionType.fade,
  //         duration: Duration(milliseconds: 300),
  //       ),
  //     },
  //   );
  // }

  // _onPressedChangePassword() {
  //   context.pushNamed(
  //     'notification_screen',
  //     extra: <String, dynamic>{
  //       kTransitionInfoKey: const TransitionInfo(
  //         hasTransition: true,
  //         transitionType: PageTransitionType.fade,
  //         duration: Duration(milliseconds: 300),
  //       ),
  //     },
  //   );
  // }

  void _onPressedEditProfile(dynamic body) {
    context.pushNamed(
      'edit_profile_screen',
      queryParameters: {
        'profileData': serializeParam(
          getJsonField(
            body,
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
  }
}
