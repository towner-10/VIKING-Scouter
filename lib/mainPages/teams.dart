import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viking_scouter/contextPages/teamPage.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/inputPages/newTeam.dart';
import 'package:viking_scouter/models/teamData.dart';
import 'package:viking_scouter/widgets/conditionalBuilder.dart';
import 'package:viking_scouter/widgets/header.dart';
import 'package:viking_scouter/widgets/subHeader.dart';

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
                ConditionalBuilder(
                  builder: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(child: SubHeader("No Teams")),
                  ),
                  condition: teamData.length == 0,
                ),
                CupertinoScrollbar(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return buildTeamTile(index);
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