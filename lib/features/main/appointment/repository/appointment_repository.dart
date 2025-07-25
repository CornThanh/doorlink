import 'package:doorlink_mobile/backend/api_requests/api_calls.dart';
import 'package:doorlink_mobile/backend/api_requests/api_manager.dart';
import 'package:doorlink_mobile/flutter_flow/flutter_flow_util.dart';

class AppointmentRepository {
  static Future<ApiCallResponse> getVcardAppointment({
    String? authToken = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Vcard Appointment',
      apiUrl: '${VcardGroup.baseUrl}/admin/vcard-appointment/$id',
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

  static Future<ApiCallResponse> getAppointment({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Appointment',
      apiUrl: '${VcardGroup.baseUrl}/admin/appointment',
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
}
