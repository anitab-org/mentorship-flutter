import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expandable/expandable.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: <Widget>[
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  children: <Widget>[
                    Image.asset("assets/images/mentorship_system_logo.png"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpandablePanel(
                        header: Text(
                          "Who are we?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        collapsed: Text("AnitaB.org is a global nonprofit organization"),
                        expanded: Text(
                            "AnitaB.org is a global nonprofit organization based in Belmont, California. Founded by computer scientists Anita Borg and Telle Whitney, the institute's primary aim is to recruit, retain, and advance women in technology."),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpandablePanel(
                    header: Text(
                      "What is the Mentorship System",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    collapsed: Text("Mentorship System is a cross platform application"),
                    expanded: Text(
                      "Mentorship System is a cross platform application that allows women in tech to mentor each other, on career development topics, through 1:1 relations for a certain period of time.",
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpandablePanel(
                    header: Text(
                      "Contributing to Mentorship",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    collapsed: Text("Head on over to our github to contribute"),
                    expanded: Container(
                      height: 40,
                      width: 100,
                      child: RaisedButton(
                        color: Color.fromRGBO(36, 41, 46, 1),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/GitHub-Mark-Light-120px-plus.png",
                              width: 20,
                              height: 25,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Github",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: _launchURL,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://github.com/anitab-org/mentorship-flutter';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
