import 'package:MeU/backend/api_requests/api_calls.dart';
import 'package:MeU/backend/api_requests/api_manager.dart';
import 'package:MeU/flutter_flow/flutter_flow_util.dart';

class DashboardRepository {
  static Future<ApiCallResponse> getTodayAppointment({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Today Appointment',
      apiUrl: '${VcardGroup.baseUrl}/admin/today-appointment',
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

  static Future<ApiCallResponse> getAdminDashboard({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Admin Dashboard',
      apiUrl: '${VcardGroup.baseUrl}/admin/dashboard',
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

  static Future<ApiCallResponse> getSuperDashboard({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Super Dashboard',
      apiUrl: '${VcardGroup.baseUrl}/dashboard',
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

  static Future<ApiCallResponse> getAdminIncomeChart({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Admin Income Chart',
      apiUrl: '${VcardGroup.baseUrl}/admin/income-chart',
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

  static List<String>? weeklyLabel(dynamic response) => (getJsonField(
        response,
        r'''$.data.weeklyLabels''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data.data''',
        true,
      ) as List?;
}
