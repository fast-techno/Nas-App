import 'package:flutter/material.dart';

class ShareInformationDialog extends StatelessWidget {
  const ShareInformationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: 250.19,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.clear,
                  size: 25,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Text("خيار هذا الحقل يتم مشاركته مع أطراف أخرى",
                  style: Theme.of(context).textTheme.bodyText2, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
