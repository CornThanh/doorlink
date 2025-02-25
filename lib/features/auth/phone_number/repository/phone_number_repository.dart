import 'package:MeU/backend/api_requests/api_calls.dart';
import 'package:MeU/backend/api_requests/api_manager.dart';
import 'package:MeU/flutter_flow/flutter_flow_util.dart';

class PhoneNumberRepository {
  static Future<ApiCallResponse> verify({
    String? verificationPhone = '',
  }) async {
    final ffApiRequestBody = '''
{
  "verification_phone": "+84$verificationPhone"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Phone Number',
      apiUrl: '${VcardGroup.baseUrl}/login-phone',
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
