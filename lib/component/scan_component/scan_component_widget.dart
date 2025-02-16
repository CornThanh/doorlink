import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'scan_component_model.dart';
export 'scan_component_model.dart';

class ScanComponentWidget extends StatefulWidget {
  const ScanComponentWidget({
    super.key,
    bool? isBusinessCardScreen,
  }) : isBusinessCardScreen = isBusinessCardScreen ?? false;

  final bool isBusinessCardScreen;

  @override
  State<ScanComponentWidget> createState() => _ScanComponentWidgetState();
}

class _ScanComponentWidgetState extends State<ScanComponentWidget> {
  late ScanComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScanComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          _model.url = await FlutterBarcodeScanner.scanBarcode(
            '#C62828', // scanning line color
            FFLocalizations.of(context).getText(
              'g6ibpxlk' /* Cancel */,
            ), // cancel button text
            false, // whether to show the flash icon
            ScanMode.QR,
          );

          await launchURL(_model.url);
        },
        child: Container(
          width: 60.0,
          height: 100.0,
          decoration: const BoxDecoration(
            color: Color(0x00FFFFFF),
          ),
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: const SizedBox(
            width: 23.0,
            height: 23.0,
            child: Icon(Icons.qr_code_scanner),
          ),
        ),
      ),
    );
  }
}
