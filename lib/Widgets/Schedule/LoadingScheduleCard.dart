import 'package:flutter/material.dart';

class LoadingScheduleCard extends StatefulWidget {
  @override
  _LoadingScheduleCardState createState() => _LoadingScheduleCardState();
}

class _LoadingScheduleCardState extends State<LoadingScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13)
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 4),
                      width: 150,
                      height: 13,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    width: 100,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    width: 100,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Divider(thickness: 0.5, color: Colors.grey, endIndent: 5),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    width: 120,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 3),
                    width: 180,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}