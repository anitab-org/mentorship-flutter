import 'package:flutter/material.dart';

class RequestsPage extends StatefulWidget {
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          labelColor: Theme.of(context).accentColor,
          tabs: [
            Tab(text: "Pending".toUpperCase()),
            Tab(text: "Past".toUpperCase()),
            Tab(text: "All".toUpperCase()),
          ],
        ),
        body: TabBarView(
          children: [
            _buildPending(context),
            _buildPast(context),
            _buildAll(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPending(BuildContext context) {
    return Center(
      child: Text("Pending"),
    );
  }

  Widget _buildPast(BuildContext context) {
    return Center(
      child: Text("Past"),
    );
  }

  Widget _buildAll(BuildContext context) {
    return Center(
      child: Text("All"),
    );
  }
}
