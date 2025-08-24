import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'profile_screen_model.dart';

export 'profile_screen_model.dart';

enum SettingScreenItems {
  logout,
  deleteAccount,
  // editProfile,
  // language,
  // changePassword,
}

class ProfileScreenWidget extends StatefulWidget {
  const ProfileScreenWidget({super.key});

  @override
  State<ProfileScreenWidget> createState() => _ProfileScreenWidgetState();
}

class _ProfileScreenWidgetState extends State<ProfileScreenWidget> {
  late ProfileScreenViewModel _viewModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  dynamic columnProfileResponse = {};

  @override
  void initState() {
    super.initState();
    _viewModel = createModel(context, () => ProfileScreenViewModel());

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
          title: Image.asset(
            'assets/images/app_icon_no_bg.png',
            width: 64.0,
            height: 64.0,
            fit: BoxFit.cover,
          ),
          actions: [
            IconButton(
              icon:
                  Icon(CupertinoIcons.settings, color: const Color(0xFF1A4572)),
              onPressed: () {
                context.pushNamed('notification_screen');
              },
            ),
            IconButton(
              icon: Icon(CupertinoIcons.bell, color: const Color(0xFF1A4572)),
              onPressed: () {
                context.pushNamed('notification_screen');
              },
            )
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(15.0, 20.0, 15.0, 20.0),
            child: SingleChildScrollView(
              child: FutureBuilder<ApiCallResponse>(
                future: VcardGroup.profileCall.call(
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
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                            width: MediaQuery.sizeOf(context).width * 0.38,
                            height: 35.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A4572),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Nunito Sans'),
                                        ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Help & Support',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Nunito Sans',
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey('Nunito Sans'),
                                ),
                          ),
                        ),
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String code =
                              switch (SettingScreenItems.values[index]) {
                            SettingScreenItems.logout => 'How DoorLink Works',
                            SettingScreenItems.deleteAccount =>
                              'Report an Issue',
                          };
                          return _itemBuilder(context, index, code);
                        },
                        separatorBuilder: _separatorBuilder,
                        itemCount: SettingScreenItems.values.length,
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'My Account',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Nunito Sans',
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey('Nunito Sans'),
                                ),
                          ),
                        ),
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String code =
                              switch (SettingScreenItems.values[index]) {
                            SettingScreenItems.logout => 'Logout',
                            SettingScreenItems.deleteAccount =>
                              'Delete Account',
                          };
                          return _itemBuilder(context, index, code);
                        },
                        separatorBuilder: _separatorBuilder,
                        itemCount: SettingScreenItems.values.length,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index, String code) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        switch (index) {
          case 0:
            // Logout action
            await _handleLogout(context);
            break;
          case 1:
            context.pushNamed(
              'webview_screen',
              queryParameters: {
                'title': serializeParam(
                  code,
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
            break;
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              code,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Nunito Sans',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
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
      height: 6,
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

  Future<void> _handleLogout(BuildContext context) async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A4572),
              ),
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        // Call logout API
        final response = await VcardGroup.logoutCall.call(
          authToken: FFAppState().authToken,
          email: VcardGroup.profileCall.email(columnProfileResponse.jsonBody),
        );

        // Hide loading indicator
        Navigator.of(context).pop();

        if (response.succeeded) {
          final success = VcardGroup.logoutCall.success(response.jsonBody);
          if (success == true) {
            // Clear auth token and navigate to login
            FFAppState().authToken = '';

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Logged out successfully'),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate to login screen
            context.goNamed('login_screen');
          } else {
            // Show error message
            final errorMsg = VcardGroup.logoutCall.message(response.jsonBody) ??
                'Failed to logout';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMsg),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          // Show network error
          final errorMsg = VcardGroup.logoutCall.message(response.jsonBody) ??
              'Network error occurred';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // Hide loading indicator
        Navigator.of(context).pop();

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
