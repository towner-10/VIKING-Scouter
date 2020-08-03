import 'dart:convert';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/inputPages/newMatch.dart';
import 'package:viking_scouter/inputPages/newTemplate.dart';
import 'package:viking_scouter/mainPages/settings.dart';
import 'package:viking_scouter/mainPages/teams.dart';
import 'package:viking_scouter/models/matchData.dart';
import 'package:viking_scouter/widgets/conditionalBuilder.dart';
import 'package:viking_scouter/widgets/latestMatchDataCard.dart';
import 'package:viking_scouter/widgets/subHeader.dart';

class Home extends StatefulWidget {
  
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {

  final PageController controller = new PageController();
  final Database _db = Database.getInstance();

  int _bottomNavIndex = 0;
  String title;

  List<MatchData> matchData = new List<MatchData>();

  @override
  void initState() {
    super.initState();

    String scoutName = _db.getPreferenceDefault('scoutName', null);
    title = scoutName == null ? 'Today\'s\nMatches' : 'Welcome back,\n' + scoutName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              style: TextStyle(
                                fontFamily: 'TT Norms',
                                fontSize: 30,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            )
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 15),
                            child:  SubHeader('New Match'),
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: CustomColors.darkBlue,
                              radius: 24,
                              child: IconButton(
                                icon: Icon(Icons.add),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) => NewMatchPage())).then((value) => setState(() {}));
                                }
                              )
                            ),
                          ),
                          ConditionalBuilder(
                            builder: Column(children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 15),
                                child:  SubHeader('Recent Top Matches'),
                              ),
                              Wrap(
                                spacing: 15,
                                runSpacing: 10,
                                children: _db.getMatches().map((e) => LatestMatchDataCard(data: e)).toList().cast<Widget>(),
                              ),
                            ]),
                            condition: _db.getMatches().length != 0,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20)
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
            ),
            Teams(),
            Settings()
          ],
        ),
      ), 
      bottomNavigationBar: SafeArea(
        child: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.home, title: "Home"),
            TabData(iconData: Icons.flag, title: "Teams"),
            TabData(iconData: Icons.settings, title: "Settings")
          ],
          onTabChangedListener: (position) {
            setState(() {
              _bottomNavIndex = position;
              controller.jumpToPage(_bottomNavIndex);
            });
          },
          circleColor: CustomColors.darkBlue,
          activeIconColor: Colors.white,
          textColor: CustomColors.darkBlue,
          inactiveIconColor: CustomColors.darkBlue,
        )
      )
    );
  }
}