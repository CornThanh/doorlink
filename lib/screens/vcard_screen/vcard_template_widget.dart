import 'package:MeU/screens/vcard_screen/update_vcard_screen_model.dart';
import 'package:flutter/material.dart';

class VcardTemplateWidget extends StatefulWidget {
  const VcardTemplateWidget({super.key, required this.model});

  final UpdateVcardScreenModel model;

  @override
  State<StatefulWidget> createState() => _VcardTemplateWidgetState();
}

class _VcardTemplateWidgetState extends State<VcardTemplateWidget> {
  final list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.model.selectedTemplateID = list[index];
                    });
                  },
                  child: Card(
                    elevation: 2,
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(
                      side: widget.model.selectedTemplateID == list[index]
                          ? const BorderSide(color: Colors.green, width: 3)
                          : BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/vcard${list[index]}.webp',
                        fit: BoxFit.fitHeight,
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
            );
          },
        ))
      ],
    );
  }
}
