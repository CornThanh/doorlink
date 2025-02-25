import 'package:MeU/backend/api_requests/api_calls.dart';
import 'package:MeU/backend/api_requests/api_manager.dart';
import 'package:MeU/flutter_flow/flutter_flow_util.dart';

class OtpRepository {
  static Future<ApiCallResponse> verify({
    String? verificationPhone = '',
    String? verificationCode = '',
  }) async {
    final ffApiRequestBody = '''
{
  "verification_phone": "+84$verificationPhone",
  "verification_code": "$verificationCode"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Verify OTP',
      apiUrl: '${VcardGroup.baseUrl}/verify-otp',
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
