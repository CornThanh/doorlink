import 'package:MeU/backend/api_requests/api_calls.dart';
import 'package:MeU/backend/api_requests/api_manager.dart';

class ForgotPasswordRepository {
  static Future<ApiCallResponse> forgot({
    String? email = '',
    String? urlDomain = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "$email",
  "url_domain": "$urlDomain"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Forgot Password',
      apiUrl: '${VcardGroup.baseUrl}/forgot-password',
      callType: ApiCallType.POST,
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
