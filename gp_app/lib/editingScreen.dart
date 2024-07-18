import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gp_app/resultScreen.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gp_app/signIn.dart';

class editingScreen extends StatefulWidget{
  String? user;
  XFile? imageFile;
  int? pred;
  editingScreen({super.key,required this.imageFile, required this.pred, required this.user});
  @override
  State<editingScreen> createState() => _editingScreen();
}

class _editingScreen extends State<editingScreen> {

  Future<XFile> convertBytesToXFile(Uint8List bytes) async {

    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/temp_image.png';

    File file = File(filePath);
    await file.writeAsBytes(bytes);

    return XFile(filePath);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset : false,
        body:
        ProImageEditor.file(File(widget.imageFile!.path),
        callbacks: ProImageEditorCallbacks(
          
        onImageEditingComplete: (Uint8List bytes) async {
          XFile img= await convertBytesToXFile(bytes);
          await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  resultScreen(imageFile: img,pred: widget.pred,user: widget.user,))
          );
        }
    )
    ));
  }
}