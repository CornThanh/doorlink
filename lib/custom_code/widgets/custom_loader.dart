import 'package:doorlink_mobile/backend/schema/util/schema_util.dart';
import 'package:flutter/cupertino.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(color: Colors.white);
  }
}
