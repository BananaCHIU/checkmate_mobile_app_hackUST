import 'package:checkmate_mobile_app/Entities/BookingRecord.dart';
import 'package:checkmate_mobile_app/Widgets/Schedule/BookingScheduleCard.dart';
import 'package:checkmate_mobile_app/Widgets/Schedule/NoBookingScheduleCard.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  final Function(bool) showSchedulePage;
  Schedule(
      {Key key,
      @required this.showSchedulePage,})
      : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  ScrollController _scrollController = new ScrollController();
  List<BookingRecord> bookings = [];

  @override
  void initState() {

    bookings = BookingRecord.getBooking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _dismissSchedulePage();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  child: bookings.length > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: bookings.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 10.0, 0),
                              child: Container(
                                height: 170,
                                child: Stack(children: [
                                  BookingScheduleCard(
                                      bookings[index]),
                                ]),
                              ),
                            );
                          })
                      : SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: NoBookingScheduleCard(),
                        ),
                ),
                _backButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(120.0, 20.0, 120.0, 20.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: TextButton(
          style: ButtonStyle(
              //backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                      side: BorderSide(color: Colors.blue)))),
          child: Text(
            "Back",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onPressed: _dismissSchedulePage,
        ),
      ),
    );
  }

  void _dismissSchedulePage() {
    widget.showSchedulePage(false);
    _scrollController.jumpTo(0.0); //go back to the top of the page
  }
}
