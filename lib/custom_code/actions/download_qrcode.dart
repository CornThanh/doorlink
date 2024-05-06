import 'dart:io';
import 'dart:math';
import 'package:image/image.dart';
import 'package:qr_image/qr_image.dart';

Future<String> downloadQrcode(
  String url,
  String name,
) async {
  // Add your function code here!
  int randomNumber = Random().nextInt(1000000);
  String imageName = '$name-$randomNumber';
  Directory directory1 = Directory('/storage/emulated/0/Documents/Vcard');

  if (!await directory1.exists()) {
    await directory1.create(recursive: true);
  }
  final filePath = '${directory1.path}/$imageName.png';
  try {
    var img1 = QRImage(
      url,
      backgroundColor: ColorUint8.rgb(255, 255, 255),
      size: 300,
    ).generate();

    File imageFile = File(filePath);
    await imageFile.writeAsBytes(encodePng(img1));
    return 'Image downloaded successfully at: Document/Vcard';
  } catch (e) {
    return '';
  }
}
