import 'package:flutter/material.dart';

import '../consts/Colors.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      color: kLogInBackGround,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: Image.asset("assets/image/upload.png"),
              onTap: () {
                //TODO get  a excel file and sent it to portal
              },
            ),
            Text(
              "لطفا با کلید بر روی عکس بالا فایل مورد نظر را ارسال کنید",
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
