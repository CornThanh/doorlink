import 'package:flutter/material.dart';

import '/backend/api_requests/api_calls.dart';
import '/component/drawer/drawer_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../model/mail.dart';
import 'mail_screen_widget.dart' show MailScreenWidget;

class MailViewModel extends FlutterFlowModel<MailScreenWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Switch widget.
  bool? switchValue1;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? affiliationOffRes;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? affiliationOnRes;
  // State field(s) for Switch widget.
  bool? switchValue2;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? contactOnRes;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? contactOffRes;
  // State field(s) for Switch widget.
  bool? switchValue3;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? stickybarOffRes;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? stickybarOnRes;
  // State field(s) for Switch widget.
  bool? switchValue4;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? whatsappOnRes;
  // Stores action output result for [Backend Call - API (Setting Update)] action in Switch widget.
  ApiCallResponse? whatsappOffRes;
  // Model for drawer component.
  late DrawerModel drawerModel;

  // Mail-related state
  List<Mail> allMails = [];
  List<Mail> filteredMails = [];
  bool isLoading = false;
  String? errorMessage;
  ApiCallResponse? getMailsRes;
  String selectedType = 'All Mail';

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    drawerModel = createModel(context, () => DrawerModel());
    _loadMails();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    drawerModel.dispose();
  }

  /// Action blocks are added here.

  /// Load mails from API
  Future<void> _loadMails() async {
    isLoading = true;
    errorMessage = null;
    updatePage(() {});

    try {
      final response = await VcardGroup.getMailsCall.call(
        authToken: FFAppState().authToken,
      );

      getMailsRes = response;

      if (response.succeeded) {
        final success = VcardGroup.getMailsCall.success(response.jsonBody);

        if (success == true) {
          final mailsData = VcardGroup.getMailsCall.data(response.jsonBody);

          if (mailsData != null && mailsData.isNotEmpty) {
            allMails = mailsData.map((json) => Mail.fromJson(json)).toList();
            _applyFilter();
          } else {
            allMails = [];
            filteredMails = [];
          }
        } else {
          errorMessage = VcardGroup.getMailsCall.message(response.jsonBody) ??
              'Failed to load mails';
          allMails = [];
          filteredMails = [];
        }
      } else {
        errorMessage = VcardGroup.getMailsCall.message(response.jsonBody) ??
            'Network error occurred';
        allMails = [];
        filteredMails = [];
      }
    } catch (e) {
      errorMessage = 'Error loading mails: $e';
      allMails = [];
      filteredMails = [];
    } finally {
      isLoading = false;
      updatePage(() {});
    }
  }

  /// Apply filter based on selected type
  void _applyFilter() {
    if (selectedType == 'All Mail') {
      filteredMails = allMails
          .where((mail) => mail.status.toLowerCase() == 'unread')
          .toList();
    } else if (selectedType == 'Archived / Deleted') {
      // Show only archived or deleted mails
      filteredMails = allMails
          .where((mail) =>
              mail.status.toLowerCase() == 'archived' ||
              mail.status.toLowerCase() == 'deleted')
          .toList();
    } else if (selectedType == 'Government & City Updates') {
      // Show only unread mails of this type
      filteredMails = allMails
          .where((mail) =>
              mail.status.toLowerCase() == 'unread' &&
              (mail.type.toLowerCase().contains('government') ||
                  mail.type.toLowerCase().contains('city') ||
                  mail.type.toLowerCase().contains('update')))
          .toList();
    } else if (selectedType == 'Offers & Promotions') {
      // Show only unread mails of this type
      filteredMails = allMails
          .where((mail) =>
              mail.status.toLowerCase() == 'unread' &&
              (mail.type.toLowerCase().contains('offer') ||
                  mail.type.toLowerCase().contains('promotion') ||
                  mail.type.toLowerCase().contains('deal')))
          .toList();
    } else if (selectedType == 'Alerts') {
      // Show only unread mails of this type
      filteredMails = allMails
          .where((mail) =>
              mail.status.toLowerCase() == 'unread' &&
              (mail.type.toLowerCase().contains('alert') ||
                  mail.type.toLowerCase().contains('notification') ||
                  mail.type.toLowerCase().contains('warning')))
          .toList();
    } else {
      // Fallback: try exact match with unread status
      filteredMails = allMails
          .where((mail) =>
              mail.type == selectedType &&
              mail.status.toLowerCase() == 'unread')
          .toList();
    }
    updatePage(() {});
  }

  /// Change selected type and apply filter
  void changeType(String newType) {
    selectedType = newType;
    _applyFilter();
  }

  /// Refresh mails
  Future<void> refreshMails() async {
    await _loadMails();
  }

  /// Get mail by ID from the current list
  Mail? getMailById(String mailId) {
    try {
      final id = int.tryParse(mailId);
      if (id != null) {
        return allMails.firstWhere((mail) => mail.id == id);
      }
    } catch (e) {
      // Mail not found
    }
    return null;
  }

  /// Additional helper methods are added here.

  /// Update mailbox status (archive/delete)
  Future<bool> updateMailboxStatus(int mailboxId, String status) async {
    try {
      final response = await VcardGroup.updateMailboxStatusCall.call(
        authToken: FFAppState().authToken,
        mailboxId: mailboxId,
        status: status,
      );

      if (response.succeeded) {
        final success =
            VcardGroup.updateMailboxStatusCall.success(response.jsonBody);
        if (success == true) {
          // Refresh the entire list from API to get updated data
          await _loadMails();
          return true;
        } else {
          errorMessage =
              VcardGroup.updateMailboxStatusCall.message(response.jsonBody) ??
                  'Failed to update status';
          return false;
        }
      } else {
        errorMessage =
            VcardGroup.updateMailboxStatusCall.message(response.jsonBody) ??
                'Network error occurred';
        return false;
      }
    } catch (e) {
      errorMessage = 'Error updating status: $e';
      return false;
    }
  }

  /// Archive a mailbox
  Future<bool> archiveMailbox(int mailboxId) async {
    return await updateMailboxStatus(mailboxId, 'archived');
  }

  /// Delete a mailbox
  Future<bool> deleteMailbox(int mailboxId) async {
    return await updateMailboxStatus(mailboxId, 'deleted');
  }
}
