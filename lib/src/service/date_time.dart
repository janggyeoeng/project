import 'package:flutter/material.dart';
import 'package:get/get.dart';

//범위 날짜 지정 code
class DateSelectionMixin {
  Future<DateTimeRange?> selectDateRange(
      BuildContext context, DateTimeRange selectedDateRange) async {
    return await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }
}

class MyViewModel extends GetxController {
  final _selectedDateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 2)),
  ).obs;

  DateTimeRange get selectedDateRange => _selectedDateRange.value;

  Future<void> selectDateRange(BuildContext context) async {
    DateTimeRange? pickedDateRange = await DateSelectionMixin()
        .selectDateRange(context, _selectedDateRange.value);
    if (pickedDateRange != null &&
        pickedDateRange != _selectedDateRange.value) {
      _selectedDateRange.value = pickedDateRange;
    }
  }
}


//단일 날짜 지정 code
class DateSelect {
  static Future<DateTime?> selectDate(BuildContext context, DateTime date) async {
    return await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    );
  }
}

class DateModel extends GetxController {
  final _date = DateTime.now().obs;
  DateTime get date => _date.value;

  get selectedItem => null;

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await DateSelect.selectDate(context, _date.value);
    if (pickedDate != null && pickedDate != _date.value) {
      _date.value = pickedDate;
    }
  }
}