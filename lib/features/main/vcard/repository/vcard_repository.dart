import 'package:MeU/backend/api_requests/api_calls.dart';
import 'package:MeU/backend/api_requests/api_manager.dart';
import 'package:MeU/features/main/vcard/model/vcard_model.dart';
import 'package:MeU/flutter_flow/flutter_flow_util.dart';

class VcardRepository {
  static Future<ApiCallResponse> getVcard({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Vcards',
      apiUrl: '${VcardGroup.baseUrl}/vcard',
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

  static Future<ApiCallResponse> updateAdminVcard({
    String? authToken = '',
    required int id,
    required String urlAlias,
    required String name,
    required String firstName,
    required String lastName,
    required int templateID,
    String? occupation,
    String? description,
    FFUploadedFile? avatar,
    FFUploadedFile? background,
    String? email,
    String? phone,
    String? location,
    String? company,
    String? position,
    String? dob,
    String? website,
    String? zalo,
    String? facebook,
    String? tiktok,
    String? instagram,
    String? youtube,
    String? linkedin,
    String? whatsapp,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Admin Vcard Update',
      apiUrl: '${VcardGroup.baseUrl}/admin/vcard-update',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'id': id,
        'url_alias': urlAlias,
        'name': name,
        'occupation': occupation,
        'description': description,
        'profile_img': avatar,
        'cover_img': background,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'location': location,
        'dob': dob,
        'company': company,
        'job_title': position,
        'template_id': templateID,
        'website': website,
        'zalo': zalo,
        'facebook': facebook,
        'tiktok': tiktok,
        'instagram': instagram,
        'youtube': youtube,
        'linkedin': linkedin,
        'whatsapp': whatsapp,
        'enable_affiliation': 0,
        'enable_contact': 0,
        'hide_stickybar': 1,
        'whatsapp_share': 0,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static Future<ApiCallResponse<VcardModel>> getAdminVcardDetails({
    String? authToken = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
        callName: 'Single Vcards',
        apiUrl: '${VcardGroup.baseUrl}/admin/vcard/$id',
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
        fromJson: (json) => VcardModel.fromJson(json));
  }

  static Future<ApiCallResponse> getAdminVcardList({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Admin Vcard',
      apiUrl: '${VcardGroup.baseUrl}/admin/vcard',
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

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;

  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}
