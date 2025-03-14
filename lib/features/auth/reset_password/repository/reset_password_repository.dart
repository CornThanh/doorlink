import 'package:MeU/backend/api_requests/api_calls.dart';
import 'package:MeU/backend/api_requests/api_manager.dart';

class ResetPasswordRepository {
  static Future<ApiCallResponse> reset({
    String? token = '',
    String? email = '',
    String? password = '',
    String? confirmPassword = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Reset Password',
      apiUrl:
          '${VcardGroup.baseUrl}/password?token=$token&email=$email&password=$password&password_confirmation=$confirmPassword',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}
