import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:khn_tracking/src/views/themes/_themes.dart';

Color statusColor(int statusId) {
  switch (statusId) {
    case 3:
      {
        // running
        return AppColors.green;
      }
    case 4:
      {
        // pause
        return AppColors.gray;
      }
    case 2:
      {
        // disconnect
        return AppColors.red;
      }
    case 6:
      {
        // no gps
        return AppColors.red;
      }
    case 1:
      {
        // chua co dl
        return AppColors.red;
      }
    case 5:
      {
        // het han dv
        return AppColors.red;
      }
    default:
      {
        // orther
        return AppColors.red;
      }
  }
}

String statusString(int statusId, DateTime time) {
  DateTime d2 = DateTime.now();
  var dMins = d2.difference(time).inMinutes;
  switch (statusId) {
    case 3:
      {
        // running
        return 'run';
      }
    case 4:
      {
        // pause
        return dMins > 15 ? 'pauseMax' : 'pauseMin';
      }
    case 2:
      {
        // disconnect
        return 'no-sign-less';
      }
    case 6:
      {
        // no gps
        return 'noGPS';
      }
    case 1:
      {
        // no data
        return 'no-data-less';
      }
    case 5:
      {
        // no gps
        return 'no-exp-less';
      }
    default:
      {
        // orther
        return 'error';
      }
  }
}

String changeDateTime(DateTime? dt) {
  String str = dt.toString();
  String? result;
  // remove **.0000Z
  if (str.isNotEmpty) {
    result = str.substring(0, str.length - 5);
  }
  var s = result!.split(' ');
  result = s[1] + ' ' + s[0];
  return result;
}

String timeDevice(DateTime d2, DateTime? d1) {
  if (d1 != null) {
    //DateTime d2 = DateTime.now();
    var dHours = d2.difference(d1).inHours;
    if (dHours >= 24) {
      return d2.difference(d1).inDays.toString() + ' ' + 'day'.tr;
    } else {
      var dMinutes = d2.difference(d1).inMinutes - dHours * 60;
      // if (dMinutes >= 2) {
      //   return dHours.toString() +
      //       ':' +
      //       dMinutes.toString() +
      //       ' ' +
      //       'minutes'.tr;
      // }
      return dHours.toString() + ':' + dMinutes.toString() + ' ' + 'minutes'.tr;
    }
  }
  return '';
}

String timeToString(DateTime dt) {
  var formatter = DateFormat('dd-MM-yyyy HH:mm:ss');

  return formatter.format(dt);
}
