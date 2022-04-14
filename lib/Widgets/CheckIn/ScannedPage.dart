import 'package:flutter/material.dart';

class ScannedPage extends StatefulWidget {
  @override
  _ScannedPageState createState() => _ScannedPageState();
}

class _ScannedPageState extends State<ScannedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  Icons.check_circle_outline,
                  size: 200,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text('Check-in Success',
                style: TextStyle(
                  fontSize: 36
                ),
              ),
              SizedBox(height: 50),
              _returnButton(),
            ],
          )
        ]
      ),
    );
  }

  Widget _returnButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 15.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              'Return',
              style: TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}