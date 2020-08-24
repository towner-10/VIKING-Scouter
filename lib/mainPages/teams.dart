import 'dart:io';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viking_scouter/contextPages/teamPage.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/inputPages/newTeam.dart';
import 'package:viking_scouter/models/teamData.dart';
import 'package:viking_scouter/widgets/header.dart';

final Database _db = Database.getInstance();

class Teams extends StatefulWidget {

  @override
  TeamsState createState() => TeamsState();
}

class TeamsState extends State<Teams> {
  List<TeamData> teamData;

  @override
  Widget build(BuildContext context) {
    teamData = _db.getTeams();

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
                CupertinoScrollbar(
                  child: LiveList(
                    shrinkWrap: true,
                    showItemInterval: Duration(milliseconds: 150),
                    showItemDuration: Duration(milliseconds: 350),
                    reAnimateOnVisibility: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index, Animation<double> animation) {
                      return FadeTransition(
                        opacity: Tween<double>(
                          begin: 0,
                          end: 1,
                        ).animate(animation),
                        // And slide transition
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(0, -0.1),
                            end: Offset.zero,
                          ).animate(animation),
                          // Paste you Widget
                          child: buildTeamTile(index),
                        ),
                      );
                    },
                    itemCount: teamData.length,
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }

  ListTile buildTeamTile(int index) {
    if (teamData[index].headerImage != null) {
      if (File(teamData[index].headerImage).existsSync() == true) {
        return ListTile(
          leading: teamData[index].headerImage == null ? Icon(Icons.outlined_flag) : CircleAvatar(radius: 25, backgroundImage: MemoryImage(File(teamData[index].headerImage).readAsBytesSync()), backgroundColor: CustomColors.darkBlue),
          title: Text(teamData[index].teamName, style: TextStyle(fontFamily: 'TT Norms')),
          subtitle: Text(teamData[index].teamNumber.toString(), style: TextStyle(fontFamily: 'TT Norms')),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => TeamPage(teamData[index]))).then((value) => setState(() {})),
          onLongPress: () {
            setState(() {
              _db.removeTeam(teamData[index].teamNumber);
            });
          },
        );
      }
    }

    return ListTile(
      leading: CircleAvatar(radius: 25, child: Icon(Icons.outlined_flag, color: Colors.white), backgroundColor: CustomColors.darkBlue),
      title: Text(teamData[index].teamName),
      subtitle: Text(teamData[index].teamNumber.toString()),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => TeamPage(teamData[index]))).then((value) => setState(() {})),
      onLongPress: () {
        setState(() {
          _db.removeTeam(teamData[index].teamNumber);
        });
      },
    );
  }
}