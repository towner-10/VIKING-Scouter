import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/widgets/header.dart';
import 'package:viking_scouter/widgets/subHeader.dart';

final ImagePicker picker = ImagePicker();


class TeamPage extends StatefulWidget {

  final int teamNumber;
  final String teamName;

  TeamPage(this.teamNumber, this.teamName);

  @override
  TeamPageState createState() => TeamPageState(this.teamNumber, this.teamName);
}

class TeamPageState extends State<TeamPage> {

  final int teamNumber;
  final String teamName;

  List<File> imageFiles = new List<File>();
  List<UnicornButton> childButtons = new List<UnicornButton>();

  TeamPageState(this.teamNumber, this.teamName) {
    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: 'Camera',
      labelColor: Colors.black,
      currentButton: FloatingActionButton(
        heroTag: 'camera',
        mini: true,
        backgroundColor: CustomColors.darkBlue,
        child: Icon(Icons.camera_alt),
        onPressed: () => pickImageCamera(),
      ),
    ));

    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: 'Gallery',
      labelColor: Colors.black,
      currentButton: FloatingActionButton(
        heroTag: 'gallery',
        mini: true,
        backgroundColor: CustomColors.darkBlue,
        child: Icon(Icons.photo),
        onPressed: () => pickImageGallery(),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: UnicornDialer(
        parentButtonBackground: CustomColors.darkBlue,
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.add),
        childButtons: childButtons,
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
                  child: Column(
                    children: [
                      Header(teamName),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          teamNumber.toString(),
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 20,
                            color: const Color(0xff6d8ac4),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 15, bottom: 30),
                  child: SubHeader('Images'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: imageFiles.map((e) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 175,
                            maxHeight: 175
                          ), 
                          child: Container(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              image: new DecorationImage(
                                fit: BoxFit.fitWidth,
                                alignment: FractionalOffset.topCenter,
                                image: MemoryImage(e.readAsBytesSync()),
                              )
                            ),
                          ),
                        );
                      }).toList()
                    ),
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

  Future pickImageCamera() async {
    final Directory parentDirectory = await getApplicationDocumentsDirectory();
    final PickedFile pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile == null) return;

    final Directory teamImageDirectory = await Directory(parentDirectory.path + '/' + teamNumber.toString() + '/images').create(recursive: true);

    final String teamImageDirectoryPath = teamImageDirectory.path;

    final String fileName = path.basename(pickedFile.path);

    final File localImage = await File(pickedFile.path).copy('$teamImageDirectoryPath/$fileName');

    print(localImage.path);

    setState(() {
      imageFiles.add(localImage);
    });
  }

  Future pickImageGallery() async {
    final Directory parentDirectory = await getApplicationDocumentsDirectory();
    final PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final String teamImageDirectory = new Directory(parentDirectory.path + '/' + teamNumber.toString() + '/images').path;

    final String fileName = path.basename(pickedFile.path);

    final File localImage = await File(pickedFile.path).copy('$teamImageDirectory/$fileName');

    print(localImage.path);

    setState(() {
      imageFiles.add(localImage);
    });
  }
}