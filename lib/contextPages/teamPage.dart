import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/widgets/header.dart';

final ImagePicker picker = ImagePicker();

class TeamPage extends StatefulWidget {

  @override
  TeamPageState createState() => TeamPageState();
}

class TeamPageState extends State<TeamPage> {

  List<File> imageFiles = new List<File>();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    print(pickedFile.path);

    setState(() {
      imageFiles.add(File(pickedFile.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: CustomColors.darkBlue,
        onPressed: () {
          pickImage();
        },
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 15, left: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context).pop()),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 15, bottom: 30),
                  child: Header('Images'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: imageFiles.map((e) => Image(image: ResizeImage(MemoryImage(e.readAsBytesSync()), width: 175))).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}