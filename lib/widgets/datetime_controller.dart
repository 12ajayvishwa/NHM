import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../utils/calender_theme.dart';

class DateTimePickerController extends GetxController {
  DateTimePickerController();

  void selectDob(TextEditingController dataTimeController) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return calenderTheme(child, context);
      },
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      dataTimeController.text = formattedDate;
    }
  }

  Future<void> selectTime(TextEditingController timeController) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: Get.context!,
      builder: (context, child) {
        return calenderTheme(child, context);
      },
    );

    if (pickedTime != null) {
      DateTime parsedTime = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, pickedTime.hour, pickedTime.minute);
      String formattedTime =
          DateFormat('HH:mm a').format(parsedTime);
      timeController.text = formattedTime.toString();
    }
  }
}
