import 'dart:async';

import 'package:MeU/features/main/vcard/presentation/social_network_widget.dart';
import 'package:MeU/features/main/vcard/presentation/update_vcard_screen_model.dart';
import 'package:MeU/features/main/vcard/presentation/vcard_template_widget.dart';
import 'package:MeU/features/main/vcard/repository/vcard_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../../../../custom_code/actions/custom_snackbar.dart';
import 'basic_infomation_widget.dart';

class UpdateVcardScreenWidget extends StatefulWidget {
  const UpdateVcardScreenWidget({super.key, required this.vcardID});

  final int vcardID;

  @override
  State<UpdateVcardScreenWidget> createState() =>
      _UpdateVcardScreenWidgetState();
}

class _UpdateVcardScreenWidgetState extends State<UpdateVcardScreenWidget> {
  late UpdateVcardScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdateVcardScreenModel());

    _model.aliasController = TextEditingController();
    _model.nameController = TextEditingController();
    _model.occupationController = TextEditingController();
    _model.descriptionController = TextEditingController();

    _model.firstNameController = TextEditingController();
    _model.lastNameController = TextEditingController();
    _model.emailController = TextEditingController();
    _model.phoneController = TextEditingController();
    _model.addressController = TextEditingController();
    _model.dateOfBirthController = TextEditingController();
    _model.companyController = TextEditingController();
    _model.positionController = TextEditingController();

    _model.websiteController = TextEditingController();
    _model.facebookController = TextEditingController();
    _model.zaloController = TextEditingController();
    _model.tiktokController = TextEditingController();
    _model.instagramController = TextEditingController();
    _model.youtubeController = TextEditingController();
    _model.linkedinController = TextEditingController();
    _model.whatsappController = TextEditingController();

    _model.aliasFocusNode = FocusNode();
    _model.nameFocusNode = FocusNode();
    _model.occupationFocusNode = FocusNode();
    _model.descriptionFocusNode = FocusNode();

    _model.firstNameFocusNode = FocusNode();
    _model.lastNameFocusNode = FocusNode();
    _model.emailFocusNode = FocusNode();
    _model.phoneFocusNode = FocusNode();
    _model.addressFocusNode = FocusNode();
    _model.dateOfBirthFocusNode = FocusNode();
    _model.companyFocusNode = FocusNode();
    _model.positionFocusNode = FocusNode();

    init();

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        FFAppState().isAPILoading = true;
      });

      setState(() {
        FFAppState().isAPILoading = false;
      });
    });
  }

  Future<void> init() async {
    final response = await VcardRepository.getAdminVcardDetails(
      authToken: FFAppState().authToken,
      id: widget.vcardID,
    );

    _model.aliasController.text = response.data?.alias ?? '';

    _model.nameController.text = response.data?.name ?? '';

    _model.occupationController.text = response.data?.occupation ?? '';

    _model.descriptionController.text = response.data?.description ?? '';

    _model.firstNameController.text = response.data?.firstName ?? '';

    _model.lastNameController.text = response.data?.lastName ?? '';

    _model.emailController.text = response.data?.email ?? '';

    _model.phoneController.text = response.data?.phone ?? '';

    _model.addressController.text = response.data?.location ?? '';

    _model.dateOfBirthController.text = response.data?.dob ?? '';

    _model.companyController.text = response.data?.company ?? '';

    _model.positionController.text = response.data?.position ?? '';

    _model.avatarImage = response.data?.avatar ?? '';

    _model.backgroundImage = response.data?.background ?? '';

    _model.selectedTemplateID = response.data?.templateID ?? 1;

    _model.websiteController.text = response.data?.website ?? '';

    _model.facebookController.text = response.data?.facebook ?? '';

    _model.zaloController.text = response.data?.zalo ?? '';

    _model.tiktokController.text = response.data?.tiktok ?? '';

    _model.instagramController.text = response.data?.instagram ?? '';

    _model.youtubeController.text = response.data?.youtube ?? '';

    _model.linkedinController.text = response.data?.linkedin ?? '';

    _model.whatsappController.text = response.data?.whatsapp ?? '';

    setState(() {});
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
        appBar: AppBar(
          backgroundColor: const Color(0xff333333),
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.pop(true);
            },
            child: Container(
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    12.0, 17.0, 25.0, 17.0),
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'czqtua39' /* Information */,
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
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Dialog(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      child: CupertinoActivityIndicator(color: Colors.white),
                    );
                  },
                );
                await _model.save(context, widget.vcardID);

                await customSnackbar(
                  context,
                  FFLocalizations.of(context).getVariableText(
                    viText: 'Cập nhật thẻ thành công',
                    enText: 'Update card successful',
                  ),
                  FlutterFlowTheme.of(context).success,
                );
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'nl3mfnja' /* Business Cards */,
                    ),
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Nunito Sans',
                          color: const Color(0xFF1F69F6),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          useGoogleFonts:
                              GoogleFonts.asMap().containsKey('Nunito Sans'),
                        ),
                  ),
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 1.0,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      10.0, 0.0, 10.0, 10.0),
                  child: Builder(
                    builder: (context) {
                      final data = functions
                          .generateVcardGroupList(
                              FFAppState().vcardGroupList.toList())
                          .toList();
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: List.generate(data.length, (dataIndex) {
                            final dataItem = data[dataIndex];
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  FFAppState().selectedVcardGroupIndex =
                                      dataIndex;
                                });
                              },
                              child: Container(
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: dataIndex ==
                                          FFAppState().selectedVcardGroupIndex
                                      ? const Color(0x1A1F69F6)
                                      : Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: dataIndex ==
                                            FFAppState().selectedVcardGroupIndex
                                        ? const Color(0xFF1F69F6)
                                        : const Color(0x00FFFFFF),
                                  ),
                                ),
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      25.0, 0.0, 25.0, 0.0),
                                  child: Text(
                                    getJsonField(
                                      dataItem,
                                      r'''$''',
                                    ).toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito Sans',
                                          color: dataIndex ==
                                                  FFAppState()
                                                      .selectedVcardGroupIndex
                                              ? const Color(0xFF1F69F6)
                                              : Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey('Nunito Sans'),
                                        ),
                                  ),
                                ),
                              ),
                            );
                          })
                              .divide(const SizedBox(width: 10.0))
                              .addToStart(const SizedBox(width: 5.0))
                              .addToEnd(const SizedBox(width: 5.0)),
                        ),
                      );
                    },
                  ),
                ),
                Flexible(
                  child: Form(
                    key: _model.formKey,
                    child: Builder(
                      builder: (context) {
                        if (FFAppState().selectedVcardGroupIndex == 0) {
                          return Builder(
                            builder: (context) {
                              return BasicInformationWidget(model: _model);
                            },
                          );
                        } else if (FFAppState().selectedVcardGroupIndex == 1) {
                          return Builder(
                            builder: (context) {
                              return VcardTemplateWidget(model: _model);
                            },
                          );
                        } else if (FFAppState().selectedVcardGroupIndex == 2) {
                          return SocialNetworkWidget(model: _model);
                        }
                        return const SizedBox();
                      },
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
}
