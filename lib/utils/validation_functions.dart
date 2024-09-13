


/// Checks if string consist only Alphabet. (No Whitespace)
bool isText(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern = r'^[a-zA-Z]+$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

/// Checks if string is phone number
String? phoneNumberValidator(value) {
  RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
  if (value!.length == 0) {
    return 'Please enter mobile number';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
  }
  return null;
}

// Age validator
String? validateAge(String? value) {
  if (value == null || value.isEmpty) {
    return 'Age is required';
  }

  final int? age = int.tryParse(value);
  if (age == null) {
    return 'Age must be a valid number';
  }

  if (age < 1 || age > 110) {
    return 'Age must be between 1 and 110';
  }

  return null;
}

/// Checks if string consist only numeric.
bool isNumeric(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern = r'^\d+$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

String? emailValidator(value) {
  if (value!.isEmpty) {
    return ("Please Enter Your Email");
  }
  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
    return ("Please Enter a valid email");
  }
  return null;
}

String? validateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Number is required';
  }

  final int? number = int.tryParse(value);
  if (number == null) {
    return 'Number must be a valid integer';
  }

  if (number < 1 || number > 15) {
    return 'Number must be between 1 and 15';
  }

  return null;
}

// String? validateTime(String? value,List<TextEditingController>? startTime,int index) {
//   if (value == null || value.isEmpty) {
//     return 'Time is required';
//   }
//   final endTimeValue =
//       TimeOfDay.fromDateTime(intl.DateFormat('hh:mm a').parse(value));

//   // Parse the start time
//   final startTimeValue = TimeOfDay.fromDateTime(
//       intl.DateFormat('hh:mm a').parse(startTime[index].text));

//   // Compare the times
//   if (endTimeValue.hour < startTimeValue.hour ||
//       (endTimeValue.hour == startTimeValue.hour &&
//           endTimeValue.minute <= startTimeValue.minute)) {
//     return "End time must be after start time";
//   }

//   return null;
// }
