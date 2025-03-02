import 'package:MeU/backend/api_requests/api_calls.dart';
import 'package:MeU/backend/api_requests/api_manager.dart';
import 'package:MeU/flutter_flow/uploaded_file.dart';

class EditProfileRepository {
  static Future<ApiCallResponse> update({
    String? firstName = '',
    String? contact = '',
    String? regionCode = '',
    String? email = '',
    FFUploadedFile? profile,
    String? authToken = '',
    String? lastName = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Profile Update',
      apiUrl: '${VcardGroup.baseUrl}/profile-update',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer $authToken',
      },
      params: {
        'first_name': firstName,
        'contact': contact,
        'region_code': regionCode,
        'email': email,
        'profile': profile,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}
