import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _selectLanguageIndex =
          prefs.getInt('ff_selectLanguageIndex') ?? _selectLanguageIndex;
    });
    _safeInit(() {
      _authToken = prefs.getString('ff_authToken') ?? _authToken;
    });
    _safeInit(() {
      _email = prefs.getString('ff_email') ?? _email;
    });
    _safeInit(() {
      _role = prefs.getString('ff_role') ?? _role;
    });
    _safeInit(() {
      _isInstructionDialogShow = prefs.getBool('ff_isInstructionDialogShow') ??
          _isInstructionDialogShow;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  int _selectLanguageIndex = 100;
  int get selectLanguageIndex => _selectLanguageIndex;
  set selectLanguageIndex(int value) {
    _selectLanguageIndex = value;
    prefs.setInt('ff_selectLanguageIndex', value);
  }

  String selectedDrawerPage = 'Dashboard';

  String _authToken = '';
  String get authToken => _authToken;
  set authToken(String value) {
    _authToken = value;
    prefs.setString('ff_authToken', value);
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    prefs.setString('ff_email', value);
  }

  List<LanguageDataStruct> languages = [
    LanguageDataStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"0\",\"name\":\"VietNam\",\"iso_code\":\"vi\",\"image\":\"https://doorlink_mobile.ntiot.vn/assets/img/LanguageImage/vietnam.jpg\"}')),
    LanguageDataStruct.fromSerializableMap(jsonDecode(
        '{\"id\":\"1\",\"name\":\"English\",\"iso_code\":\"en\",\"image\":\"https://doorlink_mobile.ntiot.vn/assets/img/LanguageImage/english.png\"}')),
  ];

  void addToLanguages(LanguageDataStruct value) {
    languages.add(value);
  }

  void removeFromLanguages(LanguageDataStruct value) {
    languages.remove(value);
  }

  void removeAtIndexFromLanguages(int index) {
    languages.removeAt(index);
  }

  void updateLanguagesAtIndex(
    int index,
    LanguageDataStruct Function(LanguageDataStruct) updateFn,
  ) {
    languages[index] = updateFn(languages[index]);
  }

  void insertAtIndexInLanguages(int index, LanguageDataStruct value) {
    languages.insert(index, value);
  }

  int selectedGroupIndex = 1000;

  String scannedURL = '';

  String _role = '';
  String get role => _role;
  set role(String value) {
    _role = value;
    prefs.setString('ff_role', value);
  }

  int selectedBusinessGroupIndex = 0;

  int selectedVcardGroupIndex = 0;

  bool isLoading = false;

  String prefixCode = '';

  bool isVcardAppointment = false;

  bool isVcardEnquiry = false;

  bool isAPILoading = false;

  int selectedGroupId = 0;

  bool _isInstructionDialogShow = false;
  bool get isInstructionDialogShow => _isInstructionDialogShow;
  set isInstructionDialogShow(bool value) {
    _isInstructionDialogShow = value;
    prefs.setBool('ff_isInstructionDialogShow', value);
  }

  List<dynamic> businessGroupList = [];

  void addToBusinessGroupList(dynamic value) {
    businessGroupList.add(value);
  }

  void removeFromBusinessGroupList(dynamic value) {
    businessGroupList.remove(value);
  }

  void removeAtIndexFromBusinessGroupList(int index) {
    businessGroupList.removeAt(index);
  }

  void updateBusinessGroupListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    businessGroupList[index] = updateFn(businessGroupList[index]);
  }

  void insertAtIndexInBusinessGroupList(int index, dynamic value) {
    businessGroupList.insert(index, value);
  }

  List<dynamic> vcardGroupList = [];

  void addToVcardGroupList(dynamic value) {
    businessGroupList.add(value);
  }

  void removeFromVcardGroupList(dynamic value) {
    businessGroupList.remove(value);
  }

  void removeAtIndexFromVcardGroupList(int index) {
    businessGroupList.removeAt(index);
  }

  void updateVcardGroupListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    businessGroupList[index] = updateFn(businessGroupList[index]);
  }

  void insertAtIndexInVcardGroupList(int index, dynamic value) {
    businessGroupList.insert(index, value);
  }

  List<dynamic> businessCardList = [];

  void addToBusinessCardList(dynamic value) {
    businessCardList.add(value);
  }

  void removeFromBusinessCardList(dynamic value) {
    businessCardList.remove(value);
  }

  void removeAtIndexFromBusinessCardList(int index) {
    businessCardList.removeAt(index);
  }

  void updateBusinessCardListAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    businessCardList[index] = updateFn(businessCardList[index]);
  }

  void insertAtIndexInBusinessCardList(int index, dynamic value) {
    businessCardList.insert(index, value);
  }

  bool isBusinessScreenSelected = false;

  bool isContactSaving = false;
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}
