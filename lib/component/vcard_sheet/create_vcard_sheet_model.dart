import 'dart:async';

import 'package:doorlink_mobile/backend/api_requests/api_calls.dart';
import 'package:doorlink_mobile/component/vcard_sheet/create_vcard_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import '/flutter_flow/flutter_flow_util.dart';

class CreateVcardSheetModel extends FlutterFlowModel<CreateVcardSheetWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (Vcard Qr code)] action in Row widget.
  final formKey = GlobalKey<FormState>();

  final unfocusNode = FocusNode();

  TextEditingController? aliasController;
  FocusNode? aliasFocusNode;

  TextEditingController? nameController;
  FocusNode? nameFocusNode;

  TextEditingController? firstNameController;
  FocusNode? firstNameFocusNode;

  TextEditingController? lastNameController;
  FocusNode? lastNameFocusNode;

  String? Function(BuildContext, String?)? aliasControllerValidator;
  String? Function(BuildContext, String?)? nameControllerValidator;
  String? Function(BuildContext, String?)? occupationControllerValidator;
  String? Function(BuildContext, String?)? descriptionControllerValidator;
  String? Function(BuildContext, String?)? firstNameControllerValidator;
  String? Function(BuildContext, String?)? lastNameControllerValidator;

  FFUploadedFile avatarUploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  FFUploadedFile backgroundUploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading = false;

  bool isFailed = false;

  Map map = {};

  @override
  void initState(BuildContext context) {
    aliasControllerValidator = (p0, value) {
      if (value == null || value.isEmpty) {
        return FFLocalizations.of(context).getVariableText(
          viText: 'Vui lòng nhập tên ngừoi dùng',
          enText: 'Please enter your alias',
        );
      }
      if (value.length < 6) {
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
          enText: 'Please enter your name',
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
    aliasController?.dispose();
    nameController?.dispose();
    firstNameController?.dispose();
    lastNameController?.dispose();
  }

  Future<void> save(BuildContext context) async {
    final urlAlias = aliasController.text.trim();
    final name = nameController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();

    if (formKey.currentState?.validate() == true) {
      if (avatarUploadedLocalFile.bytes?.isEmpty == true) {
        String assetPath = 'assets/images/default_avatar.png';
        Uint8List bytes =
            (await rootBundle.load(assetPath)).buffer.asUint8List();

        avatarUploadedLocalFile = FFUploadedFile(
          name: assetPath.split('/').last,
          bytes: bytes,
          height: (img.decodeImage(bytes)?.height ?? 0).toDouble(),
          width: (img.decodeImage(bytes)?.width ?? 0).toDouble(),
        );
      }
      if (backgroundUploadedLocalFile.bytes?.isEmpty == true) {
        String assetPath = 'assets/images/cover_photo.png';
        Uint8List bytes =
            (await rootBundle.load(assetPath)).buffer.asUint8List();

        backgroundUploadedLocalFile = FFUploadedFile(
          name: assetPath.split('/').last,
          bytes: bytes,
          height: (img.decodeImage(bytes)?.height ?? 0).toDouble(),
          width: (img.decodeImage(bytes)?.width ?? 0).toDouble(),
        );
      }
      final result = await VcardGroup.createAdminVcardCall.call(
        authToken: FFAppState().authToken,
        urlAlias: urlAlias,
        name: name,
        firstName: firstName,
        lastName: lastName,
        avatar: avatarUploadedLocalFile,
        background: backgroundUploadedLocalFile,
      );

      map = jsonDecode(result.response?.body ?? '');

      if (map['success'] == true) {
        final id = map['data']['id'];

        final shouldReload = await context.pushNamed<bool>(
          'update_vcard_screen',
          queryParameters: {"vcardID": '$id'},
        );

        context.pop(shouldReload);
      } else {
        isFailed = true;
      }
    }
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
