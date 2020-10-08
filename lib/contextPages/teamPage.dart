import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/models/teamData.dart';
import 'package:viking_scouter/widgets/conditionalBuilder.dart';
import 'package:viking_scouter/widgets/header.dart';
import 'package:viking_scouter/widgets/latestMatchDataCard.dart';

final ImagePicker picker = ImagePicker();
final Database db = Database.getInstance();

class TeamPage extends StatefulWidget {

  final TeamData teamData;

  TeamPage(this.teamData);

  @override
  TeamPageState createState() => TeamPageState(this.teamData);
}

class TeamPageState extends State<TeamPage> {

  TeamData teamData;

  List<File> imageFiles = new List<File>();
  List<UnicornButton> childButtons = new List<UnicornButton>();

  @override
  void initState() { 
    super.initState();

    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: 'Camera',
      labelColor: Colors.black,
      currentButton: FloatingActionButton(
        heroTag: 'camera',
        mini: true,
        backgroundColor: CustomColors.darkBlue,
        child: Icon(Icons.camera_alt),
        onPressed: () => pickImage(ImageSource.camera),
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
        onPressed: () => pickImage(ImageSource.gallery),
      ),
    ));

    fillImages();
  }

  TeamPageState(this.teamData);

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
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
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
                padding: EdgeInsets.only(top: 15, left: 15, bottom: 30, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(teamData.teamName),
                        Text(
                          teamData.teamNumber.toString(),
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 20,
                            color: const Color(0xff6d8ac4),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    ConditionalBuilder(
                      condition: imageFiles.length > 0,
                      builder: IconButton(icon: Icon(Icons.file_upload, color: Colors.black, size: 32), onPressed: () {
                        List<String> paths = new List<String>();

                        imageFiles.forEach((element) {
                          paths.add(element.path);
                        });

                        Share.shareFiles(paths, text: teamData.teamName + " Images");
                      }),
                    )
                  ],
                )
              ),
              ConditionalBuilder(
                condition: imageFiles.length > 0,
                builder: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2, minWidth: MediaQuery.of(context).size.width),
                    child: CupertinoScrollbar(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                        ),
                        itemCount: imageFiles.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onLongPress: () {
                              _showImageBottomSheet(context, imageFiles[index]);
                            },
                            child: ConditionalBuilderMultiple(
                              trueBuilder: Container(
                                color: const Color(0xff6d8ac4),
                                child: Opacity(
                                  opacity: 0.6,
                                  child: Image.file(imageFiles[index], fit: BoxFit.cover)
                                ), 
                              ),
                              falseBuilder: Image.file(imageFiles[index], fit: BoxFit.cover), 
                              condition: imageFiles[index].path == teamData.headerImage
                            )
                          );
                        }
                      ),
                    ),
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, left: 15, bottom: 30),
                child: Header('Matches'),
              ),
              ConditionalBuilderMultiple(
                condition: db.getTeamMatches(teamData.teamNumber).length > 0,
                trueBuilder: CupertinoScrollbar(
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 10,
                    children: db.getTeamMatches(teamData.teamNumber).map((e) => LatestMatchDataCard(data: e)).toList().cast<Widget>(),
                  ),  
                ),
                falseBuilder: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Nothing to show...",
                    style: TextStyle(
                      fontFamily: 'TT Norms',
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
            ],
          ),
        )
      ),
    );
  }

  Future<void> _showImageBottomSheet(BuildContext context, File e) async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(
                  Icons.file_upload,
                  color: Colors.black,
                ),
                title: Text('Share'),
                onTap: () {
                  Share.shareFiles([e.path]);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                title: Text('Header'),
                onTap: () {
                  updateHeaderImage(e);
                  Navigator.of(context).pop();
                },          
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                title: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red
                  ),
                ),
                onTap: () {
                  removeImage(e);
                  Navigator.of(context).pop();
                }          
              ),
            ],
          ),
        );
      }
    );
  }
  addImage(File file) async {
    if (teamData.images == null) teamData.images = new List<String>();

    teamData.images.add(file.path);
    
    if (teamData.images.first == file.path) teamData.headerImage = file.path;

    db.updateTeam(teamData);

    setState(() {
      imageFiles.add(file);
    });
  }

  removeImage(File file) async {
    teamData.images.remove(file.path);
    db.updateTeam(teamData);

    file.delete().then((value) {
      setState(() {
        imageFiles.remove(file);
      });
    });
  }

  updateHeaderImage(File file) async {
    setState(() {
      teamData.headerImage = file.path;
    });

    db.updateTeam(teamData);
  }

  fillImages() {
    if (teamData.images == null) {
      getApplicationDocumentsDirectory().then((directory) {
        Directory(directory.path + '/' + teamData.teamNumber.toString() + '/images').create(recursive: true).then((value) {
          value.list(followLinks: false).listen((FileSystemEntity entity) {
            if (entity is File) {
              setState(() {
                imageFiles.add(entity);
              });
            }
          });
        });
      });
    }
    else {
      for (int i = 0; i < teamData.images.length; i++) {
        setState(() {
          imageFiles.add(new File(teamData.images[i]));
        });
      }
    }
  }

  Future pickImage(ImageSource source) async {
    final Directory parentDirectory = await getApplicationDocumentsDirectory();
    final PickedFile pickedFile = await picker.getImage(source: source);

    if (pickedFile == null) return;

    final String teamImageDirectory = new Directory(parentDirectory.path + '/' + teamData.teamNumber.toString() + '/images').path;

    final String fileName = path.basename(pickedFile.path);

    final File localImage = await File(pickedFile.path).copy('$teamImageDirectory/$fileName');

    addImage(localImage);
  }
}