import 'dart:io';

import 'package:flutter/material.dart';
import 'package:viking_scouter/contextPages/teamPage.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/inputPages/newTeam.dart';
import 'package:viking_scouter/widgets/header.dart';

final Database _db = Database.getInstance();

class Teams extends StatefulWidget {

  @override
  TeamsState createState() => TeamsState();
}

class TeamsState extends State<Teams> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 10),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Header('Teams'),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          backgroundColor: CustomColors.darkBlue,
                          radius: 24,
                          child: IconButton(
                            icon: Icon(Icons.add),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).push(new MaterialPageRoute(builder: (context) => NewTeamPage())).then((value) => setState(() {}));
                            }
                          )
                        ),
                      ),
                    ],
                  )
                ),
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8),
                  physics: BouncingScrollPhysics(),
                  children: _db.getTeams().map((e) {
                    if (File(e.headerImage).existsSync() == true) {
                      return ListTile(
                        leading: e.headerImage == null ? Icon(Icons.outlined_flag) : CircleAvatar(radius: 25, backgroundImage: MemoryImage(File(e.headerImage).readAsBytesSync()), backgroundColor: CustomColors.darkBlue),
                        title: Text(e.teamName),
                        subtitle: Text(e.teamNumber.toString()),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => TeamPage(e))).then((value) => setState(() {})),
                        onLongPress: () {
                          setState(() {
                            _db.removeTeam(e.teamNumber);
                          });
                        },
                      );
                    }

                    return ListTile(
                      leading: CircleAvatar(radius: 25, child: Icon(Icons.outlined_flag, color: Colors.white), backgroundColor: CustomColors.darkBlue),
                      title: Text(e.teamName),
                      subtitle: Text(e.teamNumber.toString()),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => TeamPage(e))).then((value) => setState(() {})),
                      onLongPress: () {
                        setState(() {
                          _db.removeTeam(e.teamNumber);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}