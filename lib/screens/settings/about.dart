import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

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
              _buildMainCard(context),
              _buildGeneralCard(context),
              _buildContributingCard(context)
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
    Logger.root.warning("Error: Could not launch $url");
  }
}

@override
Widget _buildMainCard(BuildContext context) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAlias,
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
  );
}

@override
Widget _buildContributingCard(BuildContext context) {
  return Card(
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
        collapsed: Text("Head on over to our Github to contribute"),
        expanded: Container(
          height: 40,
          width: 100,
          child: RaisedButton(
            color: Color.fromRGBO(36, 41, 46, 1),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/Github.png",
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
  );
}

@override
Widget _buildGeneralCard(BuildContext context) {
  return Card(
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
  );
}
