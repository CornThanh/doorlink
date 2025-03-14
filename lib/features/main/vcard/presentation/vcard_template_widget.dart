import 'package:MeU/features/main/vcard/presentation/update_vcard_screen_model.dart';
import 'package:flutter/material.dart';

class VcardTemplateWidget extends StatefulWidget {
  const VcardTemplateWidget({super.key, required this.model});

  final UpdateVcardScreenModel model;

  @override
  State<StatefulWidget> createState() => _VcardTemplateWidgetState();
}

class _VcardTemplateWidgetState extends State<VcardTemplateWidget> {
  final list = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: list
            .map((e) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.model.selectedTemplateID = e;
                        });
                      },
                      child: Card(
                        elevation: 2,
                        borderOnForeground: true,
                        shape: RoundedRectangleBorder(
                          side: widget.model.selectedTemplateID == e
                              ? const BorderSide(color: Colors.green, width: 3)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/templates/vcard$e.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Divider(
                        height: 2,
                        color: Colors.white,
                      ),
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }
}
