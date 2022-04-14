import 'package:checkmate_mobile_app/Entities/BookingRecord.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingScheduleCard extends StatelessWidget {
  final BookingRecord booking;
  BookingScheduleCard(this.booking);

  @override
  Widget build(context) {
    Duration duration = this.booking.endTime.difference(this.booking.startTime);
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://pbs.twimg.com/profile_images/1063248492863180800/qC1N8aiY_400x400.jpg'),
                  fit: BoxFit.fill,
                )),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    this.booking.location['name'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Text(DateFormat('dd MMM yyyy\nHH:mm - ')
                        .format(this.booking.startTime.toLocal()) +
                    DateFormat('HH:mm').format(this.booking.endTime.toLocal())),
                Divider(thickness: 0.5, color: Colors.grey, endIndent: 5),
                Text(duration.inHours <= 0 ?
                    (
                      (duration.inMinutes % 60).toString() +
                      " " +
                      "minutes"
                    )
                    : (duration.inMinutes % 60 != 0 ?
                        (duration.inHours.toString() +
                        " " +
                        "hours" +
                        " " +
                        (duration.inMinutes % 60).toString() +
                        " " +
                        "minutes"
                        )
                        : (duration.inHours.toString() +
                        " " +
                        "hours"
                        )
                    )
                ),
                Text(this.booking.location['address'].split(", Clear Water Bay")[0])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
