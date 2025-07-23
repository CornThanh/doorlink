import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['vi', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty
        ? createLocale(locale)
        : const Locale('vi');
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? viText = '',
    String? enText = '',
  }) =>
      [
        viText,
        enText,
      ][languageIndex] ??
      '';

  static const Set<String> _languagesWithShortCode = {
    'vi',
    'en',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // language_screen
  {
    'k7b696sj': {
      'en': 'Change Language',
      'vi': 'Thay đổi ngôn ngữ',
    },
    'a0fyjqsm': {
      'en': 'Save',
      'vi': 'Lưu',
    },
    'i9m3bsou': {
      'en': 'Change Language',
      'vi': 'Thay đổi ngôn ngữ',
    },
  },
  // login_screen
  {
    'th4sex5e': {
      'en': 'Welcome,',
      'vi': 'Chào mừng',
    },
    'l0fds6fb': {
      'en': 'Sign In to continue',
      'vi': 'Đăng nhập để tiếp tục',
    },
    '6aojv8sy': {
      'en': '',
    },
    'imh1zi9g': {
      'en': 'Email Address',
      'vi': 'Địa chỉ Email',
    },
    'jzokmre4': {
      'en': '',
    },
    '497bukjd': {
      'en': 'Password',
      'vi': 'Mật khẩu',
    },
    'ycnv65i3': {
      'en': 'Forgot Password?',
      'vi': 'Quên mật khẩu?',
    },
    'bltmxua3': {
      'en': 'Login',
      'vi': 'Đăng nhập',
    },
    'anao6v0h': {
      'en': 'Don\'t have an Account?',
      'vi': 'Chưa có tài khoản?',
    },
    'nnbrrxo7': {
      'en': 'Register',
      'vi': 'Đăng ký',
    },
    'nnbxrxo7': {
      'en': 'Log in with phone number',
      'vi': 'Đăng nhập bằng số điện thoại',
    },
    'bqwu8rgt': {
      'en': 'Home',
      'vi': 'Trang chủ',
    },
  },
  // forgot_password_screen
  {
    'rj63thse': {
      'en': 'Forgot Password?',
      'vi': 'Quên mật khẩu?',
    },
    '1n44dlwi': {
      'en': 'Enter email to reset your password',
      'vi': 'Nhập email để đặt lại mật khẩu',
    },
    'l4ruwklp': {
      'en': '',
    },
    '6hhx5jq0': {
      'en': 'Email Address',
      'vi': 'Địa chỉ Email',
    },
    'v0tt8jx2': {
      'en': 'Send Link',
      'vi': 'Gửi link',
    },
    '86r7yo15': {
      'en': 'Home',
      'vi': 'Trang chủ',
    },
  },
  // reset_password_screen
  {
    '63rrj7rl': {
      'en': 'Reset Password',
      'vi': 'Đặt lại mật khẩu',
    },
    'ur3ioc8e': {
      'en': 'Set a new password below',
      'vi': 'Đặt lại mật khẩu mới bên dưới',
    },
    '36ya5tzs': {
      'en': '',
    },
    'kxoh6gx0': {
      'en': 'New Password',
      'vi': 'Mật khẩu mới',
    },
    'rxl94iq1': {
      'en': '',
    },
    'agbevg17': {
      'en': 'Confirm Password',
      'vi': 'Xác nhận mật khẩu',
    },
    'oe5hp570': {
      'en': 'Save',
      'vi': 'Lưu',
    },
    '6mrsvz9d': {
      'en': 'Home',
      'vi': 'Trang chủ',
    },
  },
  // dashboard
  {
    '6hsy28xo': {
      'en': 'Total Active \nUsers',
      'vi': 'Tổng người dùng hoạt động',
    },
    'eck7f7xr': {
      'en': 'Total Deactivated\nUsers',
      'vi': 'Tổng người dùng đã hủy kích hoạt',
    },
    'rxccenn6': {
      'en': 'Total Active\nVcards',
      'vi': 'Danh thiếp hoạt động',
    },
    'u6g2qwc5': {
      'en': 'Total Deactivated\nVcards',
      'vi': 'Danh thiếp hủy kích hoạt',
    },
    'ufd1g8fs': {
      'en': 'VCard Analytics',
      'vi': 'Phân tích VCard',
    },
    'f1noyzo0': {
      'en': 'Month',
      'vi': 'Tháng',
    },
    'lmysjehc': {
      'en': 'Income',
      'vi': 'Thu nhập',
    },
    'w4yi1rza': {
      'en': 'Total Active\nVcards',
      'vi': 'Danh thiếp\nhoạt động',
    },
    'dx7jboeu': {
      'en': 'Total Deactivated\nVcards',
      'vi': 'Danh thiếp\nngừng hoạt động',
    },
    '76c7kx4k': {
      'en': 'Today \nEnquiries',
      'vi': 'Liên hệ\nhôm nay',
    },
    'zvfj14as': {
      'en': 'Today \nAppointments',
      'vi': 'Cuộc hẹn\nhôm nay',
    },
    'xdgkk7kf': {
      'en': 'VCard Analytics',
      'vi': 'Phân tích danh thiếp',
    },
    '721dm1ol': {
      'en': 'Today’s Appointments',
      'vi': 'Cuộc hẹn hôm nay',
    },
    'ryoxyyzt': {
      'en': 'View All',
      'vi': 'Xem tất cả',
    },
    'm929v9xi': {
      'en': '  |  ',
      'vi': '  |  ',
    },
    'tkru2ovh': {
      'en': '•',
      'vi': '•',
    },
    'sro4bcxg': {
      'en': '  |  ',
      'vi': '  |  ',
    },
    '00bqlnlz': {
      'en': '•',
      'vi': '•',
    },
    'nr07wewc': {
      'en': 'Dashboard',
      'vi': 'Tổng quan',
    },
    'i1j111xk': {
      'en': 'Home',
      'vi': 'Trang chủ',
    },
  },
  // vcard_screen
  {
    'xv0dqfc8': {
      'en': 'VCards',
      'vi': 'Danh Thiếp',
    },
    '0b5yuzlp': {
      'en': 'Home',
      'vi': 'Trang chủ',
    },
  },
  // appointment_screen
  {
    'j1qb796r': {
      'en': '   |   ',
      'vi': '   |   ',
    },
    'j0a2339e': {
      'en': '•',
      'vi': '•',
    },
    '7q1plnq9': {
      'en': '  |  ',
      'vi': '  |  ',
    },
    'xa87wpus': {
      'en': '•',
      'vi': '•',
    },
    'gbdiajm8': {
      'en': '   |   ',
      'vi': '   |   ',
    },
    'wz8dh3hs': {
      'en': '•',
      'vi': '•',
    },
    'uz663lz8': {
      'en': '  |  ',
      'vi': '  |  ',
    },
    '6haxvic0': {
      'en': '•',
      'vi': '•',
    },
    'gzd51k3u': {
      'en': 'Appointments',
      'vi': 'Cuộc hẹn',
    },
    'giyqb9oq': {
      'en': 'Home',
      'vi': 'Trang chủ',
    },
  },
  // enquiries_screen
  {
    'o0move6g': {
      'en': 'Enquiries',
      'vi': 'Yêu cầu',
    },
    'hrx9hnj8': {
      'en': '   |   ',
      'vi': '   |   ',
    },
    'bhzpx70d': {
      'en': '   |   ',
      'vi': '   |   ',
    },
    '7wpwdv2a': {
      'en': '   |   ',
      'vi': '   |   ',
    },
    'jnykkpdr': {
      'en': '   |   ',
      'vi': '   |   ',
    },
    'zb2cbx2s': {
      'en': 'Home',
      'vi': 'Trang chủ',
    },
  },
  // setting_screen
  {
    'mg8rhguv': {
      'en': 'Edit Profile',
      'vi': 'Sửa thông tin',
    },
    'y9n16027': {
      'en': 'Language',
      'vi': 'Ngôn ngữ',
    },
    'y9n16127': {
      'en': 'Edit Profile',
      'vi': 'Sửa thông tin',
    },
    'i7c0zshr': {
      'en': 'Change Password',
      'vi': 'Thay đổi mật khẩu',
    },
    'lgxuhg43': {
      'en': 'Enable Affiliation',
      'vi': 'Kích hoạt liên kết',
    },
    'xcggpv4p': {
      'en': 'Enable Add to contact',
      'vi': 'Bật thêm liên hệ',
    },
    'qbhjmxyf': {
      'en': 'Hide vCard Sticky Bar',
      'vi': 'Ẩn Sticky Bar',
    },
    '0n5cykg2': {
      'en': 'WhatsApp Share',
      'vi': 'Chia sẻ WhatsApp',
    },
    '2vqrk4yt': {
      'en': 'Settings',
      'vi': 'Cài đặt',
    },
    'uzddh5zz': {
      'en': 'Home',
      'vi': 'Trang chủ',
    },
  },
  // change_password_screen
  {
    'malgoxmk': {
      'en': 'Change Password',
      'vi': 'Thay đổi mật khẩu',
    },
    'xcayyr1i': {
      'en': 'Current Password:',
      'vi': 'Mật khẩu hiện tại:',
    },
    'gj7gq0fk': {
      'en': ' *',
      'vi': ' *',
    },
    'rm8akjbc': {
      'en': 'Current Password',
      'vi': 'Mật khẩu hiện tại',
    },
    '3h03ny4j': {
      'en': 'New Password:',
      'vi': 'Mật khẩu mới:',
    },
    'u6iv42vg': {
      'en': ' *',
      'vi': ' *',
    },
    '38oe3q7h': {
      'en': 'New Password',
      'vi': 'Mật khẩu mới',
    },
    '7aycies1': {
      'en': 'Confirm Password:',
      'vi': 'Xác nhận mật khẩu:',
    },
    'c6hsm8d0': {
      'en': ' *',
      'vi': ' *',
    },
    'a73s21iu': {
      'en': 'Confirm Password',
      'vi': 'Xác nhận mật khẩu',
    },
    '9jxexqm3': {
      'en': 'Save',
      'vi': 'Lưu',
    },
    '6dvjt0n2': {
      'en': 'Cancel',
      'vi': 'Hủy',
    },
    '3x9wfr4k': {
      'en': 'Home',
      'vi': 'Tranh chủ',
    },
  },
  // edit_profile_screen
  {
    'xzao1gj9': {
      'en': 'Full Name:',
      'vi': 'Họ và Tên:',
    },
    'hiprfz0c': {
      'en': 'Enter First Name',
      'vi': 'Nhập Tên',
    },
    'clqyndho': {
      'en': 'Enter Last Name',
      'vi': 'Nhập Họ',
    },
    'dtstmqtx': {
      'en': 'Email:',
      'vi': 'Email:',
    },
    'hzqkgpzd': {
      'en': ' *',
      'vi': ' *',
    },
    'r7tg0ukf': {
      'en': 'Enter Email',
      'vi': 'Nhập Email',
    },
    '1za1kahu': {
      'en': 'Contact Number:',
      'vi': 'Số điện thoại:',
    },
    '8eu3zng3': {
      'en': ' *',
      'vi': ' *',
    },
    'bi0q9hyu': {
      'en': 'Enter Contact number',
      'vi': 'Nhập số điện thoại',
    },
    'gef46sip': {
      'en': 'Save',
      'vi': 'Lưu',
    },
    'u8el6evt': {
      'en': 'Cancel',
      'vi': 'Hủy',
    },
    '2rucwo9a': {
      'en': 'Edit Profile',
      'vi': 'Sửa thông tin',
    },
    '9m5wjghs': {
      'en': 'Home',
      'vi': 'Trang chủ',
    },
  },
  // business_card_screen
  {
    'w7cj5v2s': {
      'en': 'Business Cards',
      'vi': 'Danh Thiếp',
    },
    'a19bsrp1': {
      'en': '  |  ',
      'vi': '  |  ',
    },
    'yiciai6r': {
      'en': '  |  ',
      'vi': '  |  ',
    },
    '9iwqms5z': {
      'en': '   |   ',
      'vi': '   |   ',
    },
    'l18wkyym': {
      'en': '  |  ',
      'vi': '  |  ',
    },
    'oxp3unm3': {
      'en': 'Home',
      'vi': 'Trang chủ',
    },
  },
  // phone_number_screen
  {
    '6hyvkz90': {
      'en': 'Login',
      'vi': 'Đăng nhập',
    },
    'fgce4hqx': {
      'en':
          'Enter your phone number, MeU will send a confirmation code to your phone',
      'vi': 'Nhập số điện thoại, MeU sẽ gửi mã xác nhận đến điện thoại của bạn',
    },
    'jznj5x2j': {
      'en': 'Phone number',
      'vi': 'Số điện thoại',
    },
    'bj2tmfun': {
      'en': 'Send',
      'vi': 'Gửi',
    },
    'y9tifkv3': {
      'en': 'Back',
      'vi': 'Quay lại',
    },
  },
  // otp_screen
  {
    '7n1kbue5': {
      'en': 'Enter OTP',
      'vi': 'Nhập OTP',
    },
    'j2119ttc': {
      'en':
          'OTP code has been sent to your phone number, please check your message and enter OTP in the box',
      'vi':
          'Mã OTP đã được gửi đến số điện thoại của bạn, vui lòng kiểm tra tin nhắn và nhập OTP vào ô trống',
    },
    '168q6tn6': {
      'en': 'Cancel',
      'vi': 'Hủy',
    },
  },
  // register_screen
  {
    'cgei5bnd': {
      'en': 'Register Account',
      'vi': 'Đăng ký tài khoản',
    },
    'yqqtpp25': {
      'en': 'Please enter your details',
      'vi': 'Vui lòng nhập thông tin chi tiết của bạn',
    },
    '9ni1jqov': {
      'en': 'Enter Your First Name',
      'vi': 'Nhập Tên của bạn',
    },
    'qf8w78qo': {
      'en': 'Enter Your Last Name',
      'vi': 'Nhập Họ của bạn',
    },
    'esxemusr': {
      'en': 'Enter Your Email',
      'vi': 'Nhập Email của bạn',
    },
    'wgvyzwvt': {
      'en': 'Enter Your Password',
      'vi': 'Nhập mật khẩu của bạn',
    },
    'obbyo86y': {
      'en': 'Enter Your Confirm Password',
      'vi': 'Xác nhận lại mật khẩu',
    },
    '1cnl5cer': {
      'en': 'Register',
      'vi': 'Đăng ký',
    },
    '0duuerwu': {
      'en': 'Already have an Account?',
      'vi': 'Đã có tài khoản?',
    },
    'z8plp0bu': {
      'en': 'Login',
      'vi': 'Đăng nhập',
    },
    'mz8icuzj': {
      'en': 'Home',
      'vi': 'Trang chủ',
    },
  },
  // vcard_sheet
  {
    'czqtua31': {
      'en': 'QR Code',
      'vi': 'Mã QR',
    },
    'pjqehk70': {
      'en': 'Appointment',
      'vi': 'Cuộc hẹn',
    },
    'scgrnjh5': {
      'en': 'Enquiries',
      'vi': 'Liên hệ',
    },
    'nbadcbhy': {
      'en': 'Delete',
      'vi': 'Xóa',
    },
    '8qp2hsel': {
      'en': 'Delete Vcard',
      'vi': 'Xóa Vcard',
    },
    'rjtl9wlc': {
      'en': 'Are you sure want to delete this VCard?',
      'vi': 'Bạn chắc chắn muốn xóa VCard này?',
    },
    '5837yt5h': {
      'en': 'QR Code',
      'vi': 'Mã QR',
    },
    'om39cqak': {
      'en': 'Write NFC',
      'vi': 'Ghi NFC',
    },
    'czqtua39': {
      'en': 'Vcard Information',
      'vi': 'Thông tin',
    },
  },
  // drawer
  {
    'b3jasfwe': {
      'en': 'Dashboard',
      'vi': 'Tổng quan',
    },
    '5esgh4un': {
      'en': 'Scan Business Cards',
      'vi': 'Quét QR',
    },
    '5pw0ml62': {
      'en': 'Cancel',
      'vi': 'Hủy',
    },
    'es398s13': {
      'en': 'VCards',
      'vi': 'Danh thiếp',
    },
    'uvnyicos': {
      'en': 'Enquiries',
      'vi': 'Liên hệ',
    },
    'ujuhl9mw': {
      'en': 'Appointments',
      'vi': 'Cuộc hẹn',
    },
    '7myfbppy': {
      'en': 'Business Cards',
      'vi': 'Kinh doanh',
    },
    'etqjz79k': {
      'en': 'Setting',
      'vi': 'Cài đặt',
    },
    'l0kd7rcm': {
      'en': 'Log out',
      'vi': 'Đăng xuất',
    },
  },
  // appointment_sheet
  {
    '466tlio2': {
      'en': '•',
      'vi': '•',
    },
    'xtmrhsl8': {
      'en': 'Mark as Completed',
      'vi': 'Đánh dấu đã hoàn thành',
    },
    'yjdr134k': {
      'en': 'Delete Appointment',
      'vi': 'Xóa cuộc hẹn',
    },
    'gddc3pb8': {
      'en': 'Delete Appointment',
      'vi': 'Xóa cuộc hẹn',
    },
    '8ozw55kd': {
      'en': 'Are you sure want to delete this appointment?',
      'vi': 'Bạn chắc chắn muốn xóa cuộc hẹn này?',
    },
  },
  // delete_dialog_box
  {
    'vs9ndxz8': {
      'en': 'Cancel',
      'vi': 'Hủy',
    },
    'l72rvcpp': {
      'en': 'Delete',
      'vi': 'Xóa',
    },
  },
  // enquiry_sheet
  {
    '5wvlwvl0': {
      'en': 'Message:',
      'vi': 'Tin nhắn:',
    },
    '9nxg8fm7': {
      'en': 'Delete Enquiries',
      'vi': 'Xóa thông tin để lại',
    },
    'pddaljtn': {
      'en': 'Delete Enquiry',
      'vi': 'Xóa thông tin để lại',
    },
    'cn8iygh6': {
      'en': 'Are you sure want to delete this enquiry?',
      'vi': 'Bạn chắc chắn muốn xóa thông tin này?',
    },
  },
  // logout_dialog_box
  {
    'zhbckfxu': {
      'en': 'Logout',
      'vi': 'Đăng xuất',
    },
    'j446pvul': {
      'en': 'Are you sure want to Logout?',
      'vi': 'Bạn chắc chắn muốn đăng xuất?',
    },
    '1w5hmry4': {
      'en': 'Cancel',
      'vi': 'Hủy',
    },
    '3jhq3lck': {
      'en': 'Logout',
      'vi': 'Đăng xuất',
    },
  },
  // select_group_dialog_box
  {
    'pav5knqn': {
      'en': 'Select Group',
      'vi': 'Chọn nhóm',
    },
    'gwoconob': {
      'en': 'Remove',
      'vi': 'Gỡ bỏ',
    },
    'jhx9r5x3': {
      'en': 'Add Group',
      'vi': 'Thêm nhóm',
    },
    '519lfi78': {
      'en': 'Add Group',
      'vi': 'Thêm nhóm',
    },
    'nl3mfnja': {
      'en': 'Save',
      'vi': 'Lưu',
    },
  },
  // add_group_component
  {
    'avdfo1ha': {
      'en': 'Add Group',
      'vi': 'Thêm nhóm',
    },
    'qyw7qjzy': {
      'en': 'Group Name',
      'vi': 'Tên nhóm',
    },
    'xw06my7r': {
      'en': 'Cancel',
      'vi': 'Hủy',
    },
    'pdjihobs': {
      'en': 'Save',
      'vi': 'Lưu',
    },
  },
  // nfc_write_sheet
  {
    'p8kqv4fo': {
      'en': 'Ready To Write',
      'vi': 'Sẵn sàng để Ghi',
    },
    '94hehnjl': {
      'en': 'Move your phone closer to \nthe document.',
      'vi': 'Di chuyển thiết bị đến gần Thẻ',
    },
    'ozm3csxv': {
      'en': 'Cancel',
      'vi': 'Hủy',
    },
  },
  // scan_component
  {
    'g6ibpxlk': {
      'en': 'Cancel',
      'vi': 'Hủy',
    },
  },
  // empty_data_component
  {
    '94l07cwi': {
      'en': 'No Data Available!!',
      'vi': 'Dữ liệu không có sẵn!!',
    },
  },
  // delete_group_dialog_box
  {
    'ya1mvu3y': {
      'en': 'Remove Group',
      'vi': 'Gỡ Nhóm',
    },
    '6bpycp98': {
      'en': 'Remove Group',
      'vi': 'Gỡ Nhóm',
    },
  },
  // instruction_dialog
  {
    '3e7888cd': {
      'en': 'Steps to Open Reset Password Screen.',
      'vi': 'Các bước để mở màn hình đặt lại mật khẩu',
    },
    '4pub3o54': {
      'en': 'Go to settings and follow below steps.',
      'vi': 'Vào cài đặt và thực hiện theo các bước bên dưới',
    },
    'srbg7bto': {
      'en': '1. Open app setting.',
      'vi': '1. Mở cài đặt ứng dụng.',
    },
    'mnx423h5': {
      'en': '2. Tap into “Open by default”.',
      'vi': '2. Nhấn vào “Mở theo mặc định”.',
    },
    'kbp5yjef': {
      'en': '3. Add link, and select available Link.',
      'vi': '3. Thêm link và chọn link có sẵn.',
    },
    'ppow7hza': {
      'en': '4. Now, open your reset password link in your mail box.',
      'vi': '4. Bây giờ, hãy mở link đặt lại mật khẩu trong email của bạn.',
    },
    '5n7l5g6u': {
      'en': 'Go to Setting',
      'vi': 'Vào cài đặt',
    },
  },

  /// Tabbar
  {
    '1p20tie1': {
      'en': 'Scan QR Code',
      'vi': 'Quét mã QR',
    },
    '0qadhchn': {
      'en': 'Scan NFC',
      'vi': 'Quét NFC',
    },
    'du28g3hn': {
      'en': 'Enter DoorLink Code',
      'vi': 'Nhập mã DoorLink',
    },
    'f0k3xdae': {
      'en': 'DoorLink Code',
      'vi': 'Mã DoorLink',
    },
    '0t2bd74t': {
      'en': 'Confirm',
      'vi': 'Xác nhận',
    }
  },
  // Miscellaneous
  {
    'emlaxqkx': {
      'en':
          'In order to scan for barcodes and QR codes, this app requires permission to access the camera.',
      'vi':
          'Để quét mã vạch và mã QR, ứng dụng này cần có quyền truy cập vào máy ảnh.',
    },
    '9jbvizuo': {
      'en':
          'In order to save contact, this app requires permission to access the contact',
      'vi': 'Để lưu liên hệ, ứng dụng này cần có quyền truy cập vào liên hệ',
    },
    'kzgfqwxd': {
      'en': 'Allow NFC Permission for Read and Write NFC Cards.',
      'vi': 'Cho phép quyền NFC để đọc và ghi thẻ NFC.',
    },
    'kcglmo2n': {
      'en': "username (https://meu.ntiot.vn/username)",
      'vi': "Tên người dùng (meu.ntiot.vn/tennguoidung)",
    },
    'zd8zu4bj': {
      'en': 'Your Vcard Name',
      'vi': 'Vui lòng nhập tên danh thiếp',
    },
    'c4dsezao': {
      'en': 'Your Occupation',
      'vi': 'Vui lòng nhập nghề nghiệp',
    },
    'w9mq572h': {
      'en': 'Your Description',
      'vi': 'Mô tả ngắn',
    },
    'w9mq572b': {
      'en': 'Your First Name',
      'vi': 'Vui lòng nhập tên',
    },
    'w9m2572b': {
      'en': 'Your Last Name',
      'vi': 'Vui lòng nhập họ',
    },
    'dcgsvo5f': {
      'en': 'Your Phone',
      'vi': 'Vui lòng nhập số điện thoại',
    },
    'f55w16uu': {
      'en': 'Your Email',
      'vi': 'Vui lòng nhập email',
    },
    'v3xhl8u3': {
      'en': 'Your Address',
      'vi': 'Vui lòng nhập địa chỉ',
    },
    'zflj63ri': {
      'en': 'Your Date Of Birth',
      'vi': 'Vui lòng nhập ngày sinh',
    },
    'ny0cmlus': {
      'en': 'Your Company',
      'vi': 'Vui lòng nhập công ty',
    },
    'l71rqwjl': {
      'en': 'Your Position',
      'vi': 'Vui lòng nhập chức danh',
    },
    'j9yhl7xn': {
      'en': 'Your Website',
      'vi': 'Website của bạn',
    },
    'jgriox45': {
      'en': 'Your Facebook URL',
      'vi': 'Facebook URL',
    },
    'ym8h30k3': {
      'en': 'Your Zalo Phone',
      'vi': 'Số điện thoại Zalo',
    },
    'r7znqgj4': {
      'en': 'Instagram URL',
      'vi': 'Instagram URL',
    },
    'kyj0gr39': {
      'en': 'Tiktok URL',
      'vi': 'Tiktok URL',
    },
    '6jxublw0': {
      'en': 'Youtube URL',
      'vi': 'Youtube URL',
    },
    '25ab0n8x': {
      'en': 'LinkedIn URL',
      'vi': 'LinkedIn URL',
    },
    'ej3h14cd': {
      'en': 'Whatsapp URL',
      'vi': 'Whatsapp URL',
    },
    'wu73s867': {
      'en': 'Basic of information',
      'vi': 'Thông tin cơ bản',
    },
    'h4lb2x6z': {
      'en': 'Detail of information',
      'vi': 'Thông tin chi tiết',
    },
    's3dvl2h2': {
      'en': 'Gallery',
      'vi': 'Thư viện',
    },
    'lj4umspj': {
      'en': 'Camera',
      'vi': 'Chụp ảnh',
    },
    'yvoo2o0c': {
      'en': 'Gallery (Video)',
      'vi': 'Thư viện (Video)',
    },
    'qvftghvv': {
      'en': 'Gallery (Photo)',
      'vi': 'Thư viện (Hình ảnh)',
    },
    'x7y1wb4n': {
      'en': 'Choose source',
      'vi': 'Chọn nguồn',
    },
  },
].reduce((a, b) => a..addAll(b));
