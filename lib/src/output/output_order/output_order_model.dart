import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutPutOrderModel {
  Future<DateTimeRange?> selectDateRange(
      BuildContext context, DateTimeRange selectedDateRange) async {
    return await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  final _selectedDateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 2)),
  ).obs;

  DateTimeRange get selectedDateRange => _selectedDateRange.value;

  Future<void> selectDate(BuildContext context) async {
    DateTimeRange? pickedDateRange =
        await selectDateRange(context, _selectedDateRange.value);
    if (pickedDateRange != null &&
        pickedDateRange != _selectedDateRange.value) {
      _selectedDateRange.value = pickedDateRange;
    }
  }

  Widget container(String text) {
    return Expanded(
        flex: 2,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.3)),
              color: const Color(0xFF3E8EDE),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            )));
  }

  Widget expanded(String text) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.01)),
        ),
        child: AutoSizeText(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
