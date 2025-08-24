import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

/// Start Vcard Group Code

class VcardGroup {
  static String baseUrl = 'https://doorlinkconnect.com/api';
  static Map<String, String> headers = {};
  static NotificationCall notificationCall = NotificationCall();
  static LogoutCall logoutCall = LogoutCall();
  static CreateAdminVcardCall createAdminVcardCall = CreateAdminVcardCall();
  static SingleAppointmentCall singleAppointmentCall = SingleAppointmentCall();
  static DeleteAppointmentCall deleteAppointmentCall = DeleteAppointmentCall();
  static SingleEnquiryCall singleEnquiryCall = SingleEnquiryCall();
  static DeleteEnquiryCall deleteEnquiryCall = DeleteEnquiryCall();
  static ProfileCall profileCall = ProfileCall();
  static SingleVcardsCall singleVcardsCall = SingleVcardsCall();
  static DeleteVcardCall deleteVcardCall = DeleteVcardCall();
  static AdminGroupCall adminGroupCall = AdminGroupCall();
  static BusinessCardCreateCall businessCardCreateCall =
      BusinessCardCreateCall();
  static VcardEnquiryCall vcardEnquiryCall = VcardEnquiryCall();
  static AppointmentCompletedCall appointmentCompletedCall =
      AppointmentCompletedCall();
  static VcardQrCodeCall vcardQrCodeCall = VcardQrCodeCall();
  static DeleteGroupCall deleteGroupCall = DeleteGroupCall();
  static AdminGroupCreateCall adminGroupCreateCall = AdminGroupCreateCall();
  static GetDealsCall getDealsCall = GetDealsCall();
  static GetBannersCall getBannersCall = GetBannersCall();
  static GetCouponsCall getCouponsCall = GetCouponsCall();
  static GetMailsCall getMailsCall = GetMailsCall();
  static GetFcmNotificationsCall getFcmNotificationsCall =
      GetFcmNotificationsCall();
  static UpdateMailboxStatusCall updateMailboxStatusCall =
      UpdateMailboxStatusCall();
}

class LogoutCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    String? email = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "$email"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Logout',
      apiUrl: '${VcardGroup.baseUrl}/logout',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class CreateAdminVcardCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    required String urlAlias,
    required String name,
    String? firstName,
    String? lastName,
    FFUploadedFile? avatar,
    FFUploadedFile? background,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Admin Vcard Update',
      apiUrl: '${VcardGroup.baseUrl}/admin/vcard-create',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'url_alias': urlAlias,
        'name': name,
        'first_name': firstName,
        'last_name': lastName,
        'profile_img': avatar,
        'cover_img': background,
        'hide_stickybar': "1",
        'enable_contact': "1",
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].message''',
      ));
}

class SingleAppointmentCall {
  Future<ApiCallResponse> call({
    int? id,
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Single Appointment',
      apiUrl: '${VcardGroup.baseUrl}/admin/appointment/$id',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'auth_token': authToken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].name''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].email''',
      ));
  String? phone(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].phone''',
      ));
  String? date(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].date''',
      ));
  String? from(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].from_time''',
      ));
  String? to(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].to_time''',
      ));
  int? status(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].status''',
      ));
  String? paidamount(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].paid_amount''',
      ));
  String? vcardName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].vcard_name''',
      ));
}

class DeleteAppointmentCall {
  Future<ApiCallResponse> call({
    int? id,
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete Appointment',
      apiUrl: '${VcardGroup.baseUrl}/admin/appointment-delete/$id',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'auth_token': authToken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class SingleEnquiryCall {
  Future<ApiCallResponse> call({
    int? id,
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Single Enquiry',
      apiUrl: '${VcardGroup.baseUrl}/admin/enquiries/$id',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'auth_token': authToken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].id''',
      ));
  String? vcardName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].vcard_name''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].name''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].email''',
      ));
  int? phone(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].phone''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].message''',
      ));
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].created_at''',
      ));
}

class DeleteEnquiryCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete Enquiry',
      apiUrl: '${VcardGroup.baseUrl}/admin/enquiries-delete/$id',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'auth_token': authToken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class ProfileCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Profile',
      apiUrl: '${VcardGroup.baseUrl}/profile-edit',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'auth_token': authToken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  String? firstName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].first_name''',
      ));
  String? lastName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].last_name''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].email''',
      ));
  String? contact(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].contact''',
      ));
  String? image(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].profile_image''',
      ));
  String? language(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].language''',
      ));
  String? regionCode(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].region_code''',
      ));
}

class SingleVcardsCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Single Vcards',
      apiUrl: '${VcardGroup.baseUrl}/vcard/$id',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'auth_token': authToken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].id''',
      ));
  String? alias(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].url_alias''',
      ));
  String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].name''',
      ));
  String? occupation(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].occupation''',
      ));
  String? description(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].description''',
      ));
  String? image(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].image''',
      ));
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].created_at''',
      ));
}

class DeleteVcardCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete Vcard',
      apiUrl: '${VcardGroup.baseUrl}/admin/vcard-delete/$id',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'auth_token': authToken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class NotificationCall {
  Future<ApiCallResponse> call(
      {String? authToken = '', int? userId, String? fcmToken = ''}) async {
    final ffApiRequestBody = '''
{
  "user_id": $userId,
  "fcm_token": "$fcmToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'FCM Token',
      apiUrl: '${VcardGroup.baseUrl}/update-device-token',
      callType: ApiCallType.PUT,
      // headers: {
      //   'Authorization': 'Bearer $authToken',
      // },
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class AdminGroupCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Admin Group',
      apiUrl: '${VcardGroup.baseUrl}/admin/groups',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'auth_token': authToken,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class BusinessCardCreateCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    String? urlAlias = '',
    String? groupId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "url_alias": "$urlAlias",
  "group_id": "$groupId"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Business Card Create',
      apiUrl: '${VcardGroup.baseUrl}/business-cards-create',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class VcardEnquiryCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Vcard Enquiry',
      apiUrl: '${VcardGroup.baseUrl}/admin/vcard-enquires/$id',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class AppointmentCompletedCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    int? id,
    int? status,
  }) async {
    final ffApiRequestBody = '''
{
  "status": $status
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Appointment Completed',
      apiUrl: '${VcardGroup.baseUrl}/admin/appointment-completed/$id',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class VcardQrCodeCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Vcard Qr code',
      apiUrl: '${VcardGroup.baseUrl}/vcard-qrcode/$id',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].url''',
      ));
}

class DeleteGroupCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete Group',
      apiUrl: '${VcardGroup.baseUrl}/group-delete/$id',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class AdminGroupCreateCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    String? name = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Admin Group Create',
      apiUrl: '${VcardGroup.baseUrl}/admin/groups-create?name=$name',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class GetDealsCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Deals',
      apiUrl: '${VcardGroup.baseUrl}/news',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  List<dynamic>? data(dynamic response) =>
      castToType<List<dynamic>>(getJsonField(
        response,
        r'''$.data''',
      ));

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class GetBannersCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Banners',
      apiUrl: '${VcardGroup.baseUrl}/app-banners',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  List<dynamic>? data(dynamic response) =>
      castToType<List<dynamic>>(getJsonField(
        response,
        r'''$.data''',
      ));

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class GetCouponsCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Coupons',
      apiUrl: '${VcardGroup.baseUrl}/coupon-codes',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  List<dynamic>? data(dynamic response) =>
      castToType<List<dynamic>>(getJsonField(
        response,
        r'''$.data''',
      ));

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class GetMailsCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Mails',
      apiUrl: '${VcardGroup.baseUrl}/mailboxes',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  List<dynamic>? data(dynamic response) =>
      castToType<List<dynamic>>(getJsonField(
        response,
        r'''$.data''',
      ));

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class GetFcmNotificationsCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get FCM Notifications',
      apiUrl: '${VcardGroup.baseUrl}/fcm-notifications',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  List<dynamic>? data(dynamic response) =>
      castToType<List<dynamic>>(getJsonField(
        response,
        r'''$.data''',
      ));

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

class UpdateMailboxStatusCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
    required int mailboxId,
    required String status,
  }) async {
    final ffApiRequestBody = '''
{
  "status": "$status"
}''';

    return ApiManager.instance.makeApiCall(
      callName: 'Update Mailbox Status',
      apiUrl: '${VcardGroup.baseUrl}/mailboxes/$mailboxId',
      callType: ApiCallType.PATCH,
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));

  Map<String, dynamic>? data(dynamic response) =>
      castToType<Map<String, dynamic>>(getJsonField(
        response,
        r'''$.data''',
      ));

  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
}

/// End Vcard Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}
