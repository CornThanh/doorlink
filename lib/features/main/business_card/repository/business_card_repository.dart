import 'package:MeU/backend/api_requests/api_calls.dart';
import 'package:MeU/backend/api_requests/api_manager.dart';
import 'package:MeU/flutter_flow/flutter_flow_util.dart';

class BusinessCardRepository {
  static Future<ApiCallResponse> getBusinessCard({
    String? authToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Admin Business Card',
      apiUrl: '${VcardGroup.baseUrl}/admin/business-cards',
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

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}
