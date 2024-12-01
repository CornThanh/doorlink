
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

Future<bool> writeNFCAction(
  BuildContext context,
  String url,
  String name,
) async {
  bool isDone = false;
  try {
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        var ndef = Ndef.from(tag);
        if (ndef == null) {
          NfcManager.instance.stopSession();
          isDone = false;
        } else if (!ndef.isWritable) {
          NfcManager.instance.stopSession();
          isDone = false;
        }
        NdefMessage message = NdefMessage(
          [
            NdefRecord.createText(name),
            NdefRecord.createUri(
              Uri.parse(url),
            ),
          ],
        );
        try {
          await ndef!.write(message);
          NfcManager.instance.stopSession();
          isDone = true;
        } catch (e) {
          NfcManager.instance.stopSession();
          isDone = false;
        }
      },
    );
  } catch (e) {
    isDone = false;
  }
  Navigator.pop(context);

  return isDone;
}
