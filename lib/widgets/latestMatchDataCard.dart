import 'package:flutter/material.dart';
import 'package:viking_scouter/models/matchData.dart';
import 'package:viking_scouter/database.dart';

final Database _db = Database.getInstance();

class LatestMatchDataCard extends StatelessWidget {

  final MatchData data;

  String score;
  String rp;

  LatestMatchDataCard({@required this.data}) {
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21.0),
        color: const Color(0xff141333),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(5, 5),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              'FRC ' + data.team.toString(),
              style: TextStyle(
                fontFamily: 'TT Norms',
                fontSize: 20,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildDisplayedData(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Match ' + data.match.toString(),
              style: TextStyle(
                fontFamily: 'TT Norms',
                fontSize: 14,
                color: const Color(0xffffffff),
              ),
            )
          )
        ],
      ),
    );
  }

  List<Widget> buildDisplayedData() {
    List<Widget> displayedData = new List<Widget>();

    score = data.data['score'] != null ? (data.data['score']).toString() : '0';
    rp = data.data['rp'] != null ? (data.data['rp']).toString() : '0';

    _db.getTemplates().forEach((template) {
      if (template.name == data.templateName) {
        template.data.forEach((templateData) {
          if (templateData.display) {
            displayedData.add(
              Text(
                data.data[templateData.dbName] + ' ' + templateData.title,
                style: TextStyle(
                  fontFamily: 'TT Norms',
                  fontSize: 15,
                  color: const Color(0xffffffff),
                ),
              )
            );
          }
        });
      }
    });

    return displayedData;
  }
}