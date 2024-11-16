import '/component/select_group_dialog_box/select_group_dialog_box_widget.dart';
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
            true, // whether to show the flash icon
            ScanMode.QR,
          );

          setState(() {
            FFAppState().isBusinessScreenSelected = widget.isBusinessCardScreen;
          });
          if (_model.url != '-1') {
            setState(() {
              FFAppState().scannedURL = _model.url;
            });
            await showDialog(
              context: context,
              builder: (dialogContext) {
                return Dialog(
                  elevation: 1,
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  alignment: const AlignmentDirectional(0.0, 0.0)
                      .resolve(Directionality.of(context)),
                  child: const SelectGroupDialogBoxWidget(),
                );
              },
            ).then((value) => setState(() {}));
          }

          setState(() {});
        },
        child: Container(
          width: 60.0,
          height: 100.0,
          decoration: const BoxDecoration(
            color: Color(0x00FFFFFF),
          ),
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Container(
            width: 23.0,
            height: 23.0,
            child: const Icon(Icons.qr_code_scanner),
          ),
        ),
      ),
    );
  }
}
