import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viking_scouter/inputPages/input.dart';

class NewMatchPage extends StatelessWidget {

  NewMatchPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 81,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 150)),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Team Number',
                              style: TextStyle(
                                fontFamily: 'TT Norms',
                                fontSize: 30,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: 20,
                              right: 18
                            ),
                            child: TextField(
                              style: TextStyle(
                                fontFamily: 'TT Norms',
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Enter team number...',
                                hintStyle: TextStyle(
                                  fontFamily: 'TT Norms',
                                  fontSize: 15,
                                  color: const Color(0xffd9d3d3),
                                ),
                              ),
                            ),
                          ),
                        ],                  
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Match Number',
                              style: TextStyle(
                                fontFamily: 'TT Norms',
                                fontSize: 30,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              top: 20,
                              right: 18,
                              bottom: 20
                            ),
                            child: TextField(
                              style: TextStyle(
                                fontFamily: 'TT Norms',
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Enter match number...',
                                hintStyle: TextStyle(
                                  fontFamily: 'TT Norms',
                                  fontSize: 15,
                                  color: const Color(0xffd9d3d3),
                                ),
                              ),
                            ),
                          ),
                        ],                  
                      ),
                    ],
                  ),
                )
              ),
              Padding(padding: EdgeInsets.only(bottom: 150)),
            ],
          )
        )
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InputPage())),
        child: Container(
          width: MediaQuery. of(context).size.width,
          height: 81.0,
          decoration: BoxDecoration(
            color: const Color(0xff141333),
          ),
          child: Center(
            child: Text(
              'Next',
              style: TextStyle(
                fontFamily: 'TT Norms',
                fontSize: 30,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      )
    );
  }
}