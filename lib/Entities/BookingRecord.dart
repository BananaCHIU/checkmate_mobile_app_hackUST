import 'dart:convert';
import 'package:flutter/material.dart';

class BookingRecord {
  DateTime bookingTime;
  DateTime startTime;
  DateTime endTime;
  Map<String, dynamic> location;
  String remark;

  BookingRecord(this.bookingTime, this.startTime, this.endTime,
      this.location, this.remark);

  static List<BookingRecord> cachedBookings;

  static List<BookingRecord> getBooking() {
    return cachedBookings;
  }

  static void loadBookings() {
    //TODO
    cachedBookings = demoBookings.map((booking) => BookingRecord(
      DateTime.parse(booking["booking_time"]),
      DateTime.parse(booking["start_time"]),
      DateTime.parse(booking["end_time"]),
      booking["location"],
      booking["remark"],
    )).toList() ?? [];
    cachedBookings.sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  static List<Map<String, dynamic>> demoBookings =
  [
    {
      "booking_time":"2022-04-14T05:23:33.490Z",
      "start_time":"2022-05-31T01:00:00.000Z",
      "end_time":"2022-05-31T01:30:00.000Z",
      "duration":30,
      "last_modified":"2022-04-14T05:23:33.490Z",
      "remark":"1",
      "checkin_records":[],
      "location":{
        "address":"Lee Shau Kee Library, The Hong Kong University of Science and Technology, Clear Water Bay, Kowloon, Hong Kong",
        "name":"LC-01(Group Study Rooms (LC))",
        "tag_uid":null,
        "type":"Group Study Rooms (LC)",
        "area":"Group Study Rooms (LC)",
        "room":"LC-01",
        "status":"open",
        "latitude":22.338009,
        "longitude":114.264143,
        "is_overrided":false,
        "create_time":"2021-11-24T10:43:02.149Z",
        "last_modified":"2021-11-24T10:43:02.149Z",
        "remark":"{\"area_id\":\"8\",\"room_id\":\"57\"}"
      },
    },
    {
      "booking_time":"2022-04-14T05:29:22.015Z",
      "start_time":"2022-05-31T02:30:00.000Z",
      "end_time":"2022-05-31T04:00:00.000Z",
      "duration":90,
      "last_modified":"2022-04-14T05:29:22.015Z",
      "remark":"3",
      "checkin_records":[],
      "location":{
        "address":"Lee Shau Kee Library, The Hong Kong University of Science and Technology, Clear Water Bay, Kowloon, Hong Kong",
        "name":"LC-03(Group Study Rooms (LC))",
        "tag_uid":null,
        "type":"Group Study Rooms (LC)",
        "area":"Group Study Rooms (LC)",
        "room":"LC-03",
        "status":"open",
        "latitude":22.338009,
        "longitude":114.264143,
        "is_overrided":false,
        "create_time":"2021-11-24T10:43:02.352Z",
        "last_modified":"2021-11-24T10:43:02.352Z",
        "remark":"{\"area_id\":\"8\",\"room_id\":\"59\"}"
      },
    },
    {
      "booking_time":"2022-04-14T05:28:41.397Z",
      "start_time":"2022-05-31T01:30:00.000Z",
      "end_time":"2022-05-31T02:30:00.000Z",
      "duration":60,
      "last_modified":"2022-04-14T05:28:41.397Z",
      "remark":"2",
      "checkin_records":[],
      "location":{
        "address":"Lee Shau Kee Library, The Hong Kong University of Science and Technology, Clear Water Bay, Kowloon, Hong Kong",
        "name":"LC-02(Group Study Rooms (LC))",
        "tag_uid":null,
        "type":"Group Study Rooms (LC)",
        "area":"Group Study Rooms (LC)",
        "room":"LC-02",
        "status":"open",
        "latitude":22.338009,
        "longitude":114.264143,
        "is_overrided":false,
        "create_time":"2021-11-24T10:43:02.250Z",
        "last_modified":"2021-11-24T10:43:02.250Z",
        "remark":"{\"area_id\":\"8\",\"room_id\":\"58\"}"
      },
    }
  ];
}
