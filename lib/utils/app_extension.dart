import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension WidthHeight on num {
  Widget get width => SizedBox(width: toDouble());
  Widget get height => SizedBox(height: toDouble());
}

extension AppDateTime on DateTime {
  String get toMMDDYY {
    return DateFormat("MMM d, y").format(this);
  }

  String get toMMDDYYYY {
    return DateFormat("MMM d, yyyy").format(this);
  }

  String get toDDMMYYYY {
    return DateFormat("dd-MM-yyyy").format(this);
  }

  String get toWEEKDAY {
    return DateFormat.EEEE().format(this);
  }

  String get toYYYMMDD {
    return DateFormat("yyyy-MM-dd").format(this);
  }

  String get tohhMMh {
    return DateFormat.jm().format(this);
  }

  String get toMMOnly {
    return DateFormat.E().format(this);
  }

  String get toHOUR24MINUTESECOND {
    return DateFormat.Hms().format(this);
  }
}
