import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Text('Dashboard',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent)),
              Padding(
                padding: const EdgeInsets.all(40.0),
              ),
              Icon(
                Icons.face,
                size: 50,
              ),
            ],
          ),
        ));
  }
}
