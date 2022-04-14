import 'dart:io' show Platform;

import 'package:async/async.dart';
import 'package:checkmate_mobile_app/Entities/BookingRecord.dart';
import 'package:checkmate_mobile_app/Widgets/CheckIn/ScannedPage.dart';
import 'package:checkmate_mobile_app/Widgets/Schedule/BookingScheduleCard.dart';
import 'package:checkmate_mobile_app/Widgets/Schedule/LoadingScheduleCard.dart';
import 'package:checkmate_mobile_app/Widgets/Schedule/NoBookingScheduleCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MainPage extends StatefulWidget {
  final Function(bool) showSchedulePage;
  MainPage(
      {Key key,
      @required this.showSchedulePage,})
      : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  //TODO: NFC Component
  CancelableCompleter _polling;
  NFCTag _tag;

  //Schedule Components
  List<BookingRecord> booking = [];
  AnimationController _controller;
  RelativeRectTween _rectTween1;
  RelativeRectTween _rectTween2;
  RelativeRectTween _rectTween3;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    //Schedule
    booking = BookingRecord.getBooking();
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 1, milliseconds: 700));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 100), () {
          widget.showSchedulePage(true);
          _controller.reverse();
        });
      }
    });
  }

  _pollNFC(BuildContext context) async {
    // show modal for android to mimick iOS behaviour
    if (Platform.isAndroid) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        useRootNavigator: true,
        enableDrag: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              FlutterNfcKit.finish();
              _polling?.operation?.cancel();
              return true;
            },
            child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ready to Scan',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline4
                          .copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    Icon(
                      Icons.nfc_rounded,
                      size: MediaQuery
                          .of(context)
                          .size
                          .width * 0.3,
                      color: Colors.grey,
                    ),
                    Text(
                      'Hold your phone near the NFC Tag',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6
                          .copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding:
                        EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                        textStyle: Theme
                            .of(context)
                            .textTheme
                            .headline6,
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        FlutterNfcKit.finish();
                        _polling?.operation?.cancel();
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    NFCTag tag = await FlutterNfcKit.poll();
    setState(() {
      _tag = tag;
    });

    await FlutterNfcKit.finish();
    _polling = null;

    // remove modal bottom sheet on android
    if (Platform.isAndroid) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
        PageRouteBuilder(
            pageBuilder: (context, a1, a2) => new ScannedPage(),
            transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 100)
        )
      );
    }
  }

  Widget _bigButton() {
    return RawMaterialButton(
      onPressed: () async {
        try {
          _polling = CancelableCompleter(onCancel: () {
            _polling = null;
          });
          _polling.complete(_pollNFC(context));
        }
        catch (e) {}
      },
      elevation: 2.0,
      fillColor: Colors.white,
      child: SvgPicture.asset(
        'assets/logo.svg',
        height: MediaQuery.of(context).size.width * 0.6,
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
      shape: CircleBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SafeArea(
        child: Center(
          child: Stack(children: [
            Center(
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(flex: 1),
                    FadeTransition(
                        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
                            CurvedAnimation(
                                parent: _controller,
                                curve: Interval(0.0, 0.2,
                                    curve: Curves.easeInOut))),
                        child: _bigButton()),
                    Spacer(flex: 3),
                    //Text('ID: ${_tag?.id}\nStandard: ${_tag?.standard}\nType: ${_tag?.type}\n\n Transceive Result:\n$_result'),
                  ]),
            ),
            LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              double height = constraints.maxHeight;
              _rectTween1 = RelativeRectTween(
                  begin: RelativeRect.fromLTRB(10, height - 194, 10, 24),
                  end: RelativeRect.fromLTRB(
                      10, 0, 10, height - 170)); //top card used space: 170
              _rectTween2 = RelativeRectTween(
                  begin: RelativeRect.fromLTRB(10, height - 186, 10, 16),
                  end: RelativeRect.fromLTRB(
                      10, 170, 10, height - 340)); //second card offset: 170
              _rectTween3 = RelativeRectTween(
                  begin: RelativeRect.fromLTRB(10, height - 178, 10, 8),
                  end: RelativeRect.fromLTRB(
                      10, 340, 10, height - 510)); //third card offset: 170

              return Stack(children: [
                PositionedTransition(
                  rect: _rectTween3.animate(CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0.2, 1.0, curve: Curves.elasticInOut))),
                  child: LoadingScheduleCard(),
                ),
                PositionedTransition(
                  rect: _rectTween2.animate(CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0.2, 1.0, curve: Curves.elasticInOut))),
                  child: LoadingScheduleCard(),
                ),
                PositionedTransition(
                  rect: _rectTween1.animate(CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0.2, 1.0, curve: Curves.elasticInOut))),
                  child: _topScheduleCard(),
                )
              ]);
            })
          ]),
        ),
      ),
    );
  }

  Widget _topScheduleCard() {
    return GestureDetector(
      onTap: () {
        if (booking.length > 0)
          _controller.forward();
      },
      onDoubleTap: () {
        // _controller.reverse();
      },
      child: booking.length > 0
          ? BookingScheduleCard(booking[0])
          : NoBookingScheduleCard(),
    );
  }
}