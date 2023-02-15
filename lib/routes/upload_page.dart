import 'dart:io';

import 'package:flutter/material.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/consts/retrofit_utils.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../consts/Colors.dart';
import '../models/providers/retrofit_provider.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rest = context.read<RetrofitProvider>().state;
    ProgressDialog pd = ProgressDialog(context);
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
              onTap: () async {
                //TODO get  a excel file and sent it to portal
                String? path = await FilesystemPicker.openDialog(
                  context: context,
                  rootDirectory: Directory.current,
                  fsType: FilesystemType.file,
                  allowedExtensions: [
                    '.xlsx',
                    '.xlsm',
                    '.xlsb',
                  ],
                  fileTileSelectMode: FileTileSelectMode.wholeTile,
                  showGoUp: true,
                );
                print(path);
                pd.show();
                await updateFile(context: context, rest: rest, path: path!);
                pd.hide();
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
