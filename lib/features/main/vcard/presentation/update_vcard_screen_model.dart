import 'dart:async';

import 'package:MeU/features/main/vcard/repository/vcard_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/flutter_flow/flutter_flow_util.dart';
import 'vcard_screen_widget.dart' show VcardScreenWidget;

class UpdateVcardScreenModel extends FlutterFlowModel<VcardScreenWidget> {
  ///  State fields for stateful widgets in this page.
  ///
  final formKey = GlobalKey<FormState>();

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.
  ///
  ///
  TextEditingController? aliasController;
  FocusNode? aliasFocusNode;

  TextEditingController? nameController;
  FocusNode? nameFocusNode;

  TextEditingController? occupationController;
  FocusNode? occupationFocusNode;

  TextEditingController? descriptionController;
  FocusNode? descriptionFocusNode;

  TextEditingController? firstNameController;
  FocusNode? firstNameFocusNode;

  TextEditingController? lastNameController;
  FocusNode? lastNameFocusNode;

  TextEditingController? emailController;
  FocusNode? emailFocusNode;

  TextEditingController? phoneController;
  FocusNode? phoneFocusNode;

  TextEditingController? addressController;
  FocusNode? addressFocusNode;

  TextEditingController? dateOfBirthController;
  FocusNode? dateOfBirthFocusNode;

  TextEditingController? companyController;
  FocusNode? companyFocusNode;

  TextEditingController? positionController;
  FocusNode? positionFocusNode;

  TextEditingController? websiteController;
  FocusNode? websiteFocusNode;
  TextEditingController? facebookController;
  FocusNode? facebookFocusNode;
  TextEditingController? zaloController;
  FocusNode? zaloFocusNode;
  TextEditingController? tiktokController;
  FocusNode? tiktokFocusNode;
  TextEditingController? instagramController;
  FocusNode? instagramFocusNode;
  TextEditingController? youtubeController;
  FocusNode? youtubeFocusNode;
  TextEditingController? linkedinController;
  FocusNode? linkedinFocusNode;
  TextEditingController? whatsappController;
  FocusNode? whatsappFocusNode;

  String? Function(BuildContext, String?)? aliasControllerValidator;
  String? Function(BuildContext, String?)? nameControllerValidator;
  String? Function(BuildContext, String?)? occupationControllerValidator;
  String? Function(BuildContext, String?)? descriptionControllerValidator;

  String? Function(BuildContext, String?)? firstNameControllerValidator;
  String? Function(BuildContext, String?)? lastNameControllerValidator;
  String? Function(BuildContext, String?)? emailControllerValidator;
  String? Function(BuildContext, String?)? phoneControllerValidator;
  String? Function(BuildContext, String?)? addressControllerValidator;
  String? Function(BuildContext, String?)? dateOfBirthControllerValidator;
  String? Function(BuildContext, String?)? companyControllerValidator;
  String? Function(BuildContext, String?)? positionControllerValidator;

  String? Function(BuildContext, String?)? websiteControllerValidator;
  String? Function(BuildContext, String?)? facebookControllerValidator;
  String? Function(BuildContext, String?)? zaloControllerValidator;
  String? Function(BuildContext, String?)? tiktokControllerValidator;
  String? Function(BuildContext, String?)? instagramControllerValidator;
  String? Function(BuildContext, String?)? youtubeControllerValidator;
  String? Function(BuildContext, String?)? linkedinControllerValidator;
  String? Function(BuildContext, String?)? whatsappControllerValidator;

  bool isDataUploading = false;

  int selectedTemplateID = 1;

  String avatarImage = '';
  String backgroundImage = '';

  FFUploadedFile avatarUploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  FFUploadedFile backgroundUploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  @override
  void initState(BuildContext context) {
    aliasControllerValidator = (p0, value) {
      if (value == null || value.isEmpty) {
        return FFLocalizations.of(context).getVariableText(
          viText: 'Vui lòng nhập đường dẫn',
          enText: 'Please enter your url alias',
        );
      }
      if (value.length < 4) {
        return FFLocalizations.of(context).getVariableText(
          viText: 'Phải ít nhất 6 ký tự',
          enText: 'At least 6 characters',
        );
      }
      return null;
    };

    nameControllerValidator = (p0, value) {
      if (value == null || value.isEmpty) {
        return FFLocalizations.of(context).getVariableText(
          viText: 'Vui lòng nhập tên danh thiếp',
          enText: 'Please enter your card name',
        );
      }
      return null;
    };

    firstNameControllerValidator = (p0, value) {
      if (value == null || value.isEmpty) {
        return FFLocalizations.of(context).getVariableText(
          viText: 'Vui lòng nhập tên của bạn',
          enText: 'Please enter your first name',
        );
      }
      return null;
    };

    lastNameControllerValidator = (p0, value) {
      if (value == null || value.isEmpty) {
        return FFLocalizations.of(context).getVariableText(
          viText: 'Vui lòng nhập họ của bạn',
          enText: 'Please enter your last name',
        );
      }

      return null;
    };
  }

  @override
  void dispose() {
    unfocusNode.dispose();

    aliasController?.dispose();
    nameController?.dispose();
    occupationController?.dispose();
    descriptionController?.dispose();
  }

  Future<void> save(BuildContext context, int id) async {
    final urlAlias = aliasController.text.trim();
    final name = nameController.text.trim();
    final occupation = occupationController.text.trim();
    final description = descriptionController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final location = addressController.text.trim();
    final dob = dateOfBirthController.text.trim();
    final company = companyController.text.trim();
    final position = positionController.text.trim();

    final website = websiteController.text.trim();
    final zalo = zaloController.text.trim();
    final facebook = facebookController.text.trim();
    final tiktok = tiktokController.text.trim();
    final instagram = instagramController.text.trim();
    final youtube = youtubeController.text.trim();
    final linkedin = linkedinController.text.trim();
    final whatsapp = whatsappController.text.trim();

    if (avatarUploadedLocalFile.bytes?.isEmpty == true) {
      final http.Response responseData1 =
          await http.get(Uri.parse(avatarImage));
      final avatarUint8list = responseData1.bodyBytes;

      avatarUploadedLocalFile = FFUploadedFile(
        name: 'avatar',
        bytes: avatarUint8list,
      );
    }

    if (backgroundUploadedLocalFile.bytes?.isEmpty == true) {
      final http.Response responseData2 =
          await http.get(Uri.parse(backgroundImage));
      final backgroundUint8list = responseData2.bodyBytes;

      backgroundUploadedLocalFile = FFUploadedFile(
        name: 'background',
        bytes: backgroundUint8list,
      );
    }

    if (formKey.currentState?.validate() == true) {
      final result = await VcardRepository.updateAdminVcard(
        id: id,
        authToken: FFAppState().authToken,
        urlAlias: urlAlias,
        name: name,
        occupation: occupation,
        description: description,
        avatar: avatarUploadedLocalFile,
        background: backgroundUploadedLocalFile,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        location: location,
        dob: dob,
        company: company,
        position: position,
        templateID: selectedTemplateID,
        website: website,
        facebook: facebook,
        tiktok: tiktok,
        zalo: zalo,
        instagram: instagram,
        youtube: youtube,
        linkedin: linkedin,
        whatsapp: whatsapp,
      );

      context.pop();
      context.pop(result.succeeded);
    }
  }
}
