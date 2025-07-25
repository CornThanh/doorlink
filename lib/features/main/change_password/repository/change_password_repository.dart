import 'package:doorlink_mobile/backend/api_requests/api_calls.dart';
import 'package:doorlink_mobile/backend/api_requests/api_manager.dart';
import 'package:doorlink_mobile/flutter_flow/flutter_flow_util.dart';

class ChangePasswordRepository {
  static Future<ApiCallResponse> changePassword({
    String? authToken = '',
    String? email = '',
    String? oldPassword = '',
    String? newPassword = '',
    String? confirmPassword = '',
  }) async {
    final ffApiRequestBody = '''
{
  "email": "$email",
  "old_password": "$oldPassword",
  "password": "$newPassword",
  "password_conformation": "$confirmPassword"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Change Password',
      apiUrl: '${VcardGroup.baseUrl}/reset-password',
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
