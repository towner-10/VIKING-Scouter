import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

    setState(() {
      imageFiles.add(File(pickedFile.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header('Images'),
          RaisedButton(onPressed: () {
            pickImage();
          }, child: Text('New Image')),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: imageFiles.map((e) {
              Image.file(e);
            }).toList(),
          )
        ],
      ),
    );
  }
}