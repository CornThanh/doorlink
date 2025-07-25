import 'package:doorlink_mobile/backend/api_requests/api_calls.dart';
import 'package:doorlink_mobile/backend/api_requests/api_manager.dart';
import 'package:doorlink_mobile/flutter_flow/flutter_flow_util.dart';

class RegisterRepository {
  static Future<ApiCallResponse> register({
    String? firstName = '',
    String? lastName = '',
    String? email = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
  "first_name": "$firstName",
  "last_name": "$lastName",
  "email": "$email",
  "password": "$password"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Register',
      apiUrl: '${VcardGroup.baseUrl}/register',
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

  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}
