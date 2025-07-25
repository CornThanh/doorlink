import 'package:doorlink_mobile/backend/api_requests/api_calls.dart';
import 'package:doorlink_mobile/backend/api_requests/api_manager.dart';
import 'package:doorlink_mobile/flutter_flow/flutter_flow_util.dart';

class LanguageRepository {
  static Future<ApiCallResponse> updateLanguage({
    String? authToken = '',
    String? language = '',
  }) async {
    final ffApiRequestBody = '''
{
  "language": "$language"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Language Update',
      apiUrl: '${VcardGroup.baseUrl}/language-update',
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
}
