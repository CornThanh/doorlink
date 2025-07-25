import 'package:doorlink_mobile/backend/api_requests/api_calls.dart';
import 'package:doorlink_mobile/backend/api_requests/api_manager.dart';
import 'package:doorlink_mobile/flutter_flow/flutter_flow_util.dart';

class EnquiriesRepository {
  static Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Enquiry',
      apiUrl: '${VcardGroup.baseUrl}/admin/enquiries',
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
