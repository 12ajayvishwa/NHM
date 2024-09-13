import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:pvi_nhm/utils/size_utils.dart';
import 'package:pvi_nhm/utils/string_capitalization.dart';

import '../core/constants/app_export.dart';
import '../theme/theme_helper.dart';

// ignore: must_be_immutable
class MultiselectDropdown extends StatelessWidget {
  final String title;
  final bool isRequired;
  final List<dynamic> dropdownList;
  final List<dynamic>? initiallySelectedList;
  final void Function(List<dynamic>) onChanged;
  final bool? isLarge;
  final bool? selectAll;
  final String compareData;
  final String showData;
  bool? isValidate;

  MultiselectDropdown(
      {super.key,
      required this.title,
      this.isRequired = true,
      this.selectAll = false,
      required this.dropdownList,
      this.isLarge = false,
      this.isValidate = false,
      this.showData = 'name',
      this.compareData = 'id',
      this.initiallySelectedList,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TextLabel(title: title.toCapitalized(), isRequired: isRequired),
        SizedBox(
          height: 60.v,
          child: MultiSelectDropdown(
            width: size.width,
            list: dropdownList,
            initiallySelected: initiallySelectedList ?? [],
            onChange: onChanged,
            label: showData,
            id: compareData,
            includeSearch: true,
            includeSelectAll: selectAll!,
            numberOfItemsLabelToShow: 5,
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.black.withOpacity(0.01),
                    offset: const Offset(0, 0),
                    spreadRadius: 8)
              ],
              border: Border.all(
                color: appTheme.orange,
                width: 1,
              ),
            ),
            isLarge: isLarge!,
            whenEmpty: "Select ${title.toCapitalized()}",
            listTextStyle: TextStyle(
              color: appTheme.orange,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              fontSize: 16.fSize,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, vertical: size.height * 0.01),
            splashColor: Colors.grey,
            checkboxFillColor: appTheme.orange,
            textStyle: TextStyle(
              color: const Color.fromARGB(255, 138, 135, 135),
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w600,
              fontSize: 16.fSize,
            ).copyWith(color: const Color.fromARGB(255, 68, 66, 66)),
          ),
        ),
        // Text(
        //   isValidate! ? 'Please select ${title.toLowerCase()}' : '',
        //   style: const TextStyle(
        //     color: Colors.red,
        //     fontSize: 12,
        //   ),
        // )
      ],
    );
  }
}
