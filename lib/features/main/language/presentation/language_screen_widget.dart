import 'dart:developer';

import 'package:doorlink_mobile/backend/schema/structs/index.dart';
import 'package:doorlink_mobile/features/main/language/repository/language_repository.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'language_screen_model.dart';
export 'language_screen_model.dart';

class LanguageScreenWidget extends StatefulWidget {
  const LanguageScreenWidget({
    super.key,
    bool? isChange,
  }) : isChange = isChange ?? false;

  final bool isChange;

  @override
  State<LanguageScreenWidget> createState() => _LanguageScreenWidgetState();
}

class _LanguageScreenWidgetState extends State<LanguageScreenWidget> {
  late LanguageScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<LanguageDataStruct> get data => FFAppState().languages;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LanguageScreenModel());
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
          leading: Container(
            width: 100.0,
            height: 100.0,
            decoration: const BoxDecoration(
              color: Color(0x00FFFFFF),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FlutterFlowIconButton(
                borderRadius: 20.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                fillColor: const Color(0x004B39EF),
                icon: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 22.0,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
            ),
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'k7b696sj' /* Change Language */,
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
          actions: [
            Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => _onPressedSave(),
                child: Container(
                  width: 60.0,
                  height: double.infinity,
                  decoration: const BoxDecoration(),
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 0.0, 10.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'a0fyjqsm' /* Save */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Nunito Sans',
                            color: const Color(0xFF1A4572),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            useGoogleFonts:
                                GoogleFonts.asMap().containsKey('Nunito Sans'),
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8.0, 15.0, 8.0, 15.0),
          child: Builder(
            builder: (context) {
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(
                  0,
                  5.0,
                  0,
                  5.0,
                ),
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                separatorBuilder: _separatorBuilder,
                itemBuilder: _itemBuilder,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final dataItem = data[index];

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          setState(() {
            FFAppState().selectLanguageIndex = index;
          });
        },
        child: Container(
          width: double.infinity,
          height: 55.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 4.0,
                color: Color(0x33000000),
                offset: Offset(0.0, 2.0),
              )
            ],
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: dataItem.id == FFAppState().selectLanguageIndex
                  ? const Color(0xFF1A4572)
                  : FlutterFlowTheme.of(context).primary,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15.0, 8.0, 15.0, 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondary,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.network(
                        dataItem.image,
                      ).image,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    dataItem.name,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito Sans',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Nunito Sans'),
                        ),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    '(${dataItem.isoCode})',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Nunito Sans',
                          color: const Color(0xFF79818A),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Nunito Sans'),
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

  Widget _separatorBuilder(BuildContext context, int index) {
    return const SizedBox(height: 12.0);
  }

  Future<void> _onPressedSave() async {
    try {
      _model.apiResult = await LanguageRepository.updateLanguage(
        authToken: FFAppState().authToken,
        language:
            FFAppState().languages[FFAppState().selectLanguageIndex].isoCode,
      );
      if ((_model.apiResult?.succeeded ?? true) && mounted) {
        if (FFAppState().selectLanguageIndex == 0) {
          setAppLanguage(context, 'vi');
        } else {
          if (FFAppState().selectLanguageIndex == 1) {
            setAppLanguage(context, 'en');
          }
        }
      }

      if (mounted) {
        context.safePop();

        await actions.customSnackbar(
          context,
          'Language Update Successfully.',
          const Color(0xFF46A44D),
        );

        setState(() {});
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
