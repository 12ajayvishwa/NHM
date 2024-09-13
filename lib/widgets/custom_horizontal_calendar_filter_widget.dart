import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../core/constants/app_export.dart';
import '../theme/color_constants.dart';
import '../theme/text_style.dart';
import '../utils/date_time_timeline.dart';

class CustomHorizontalCalendarWidget extends StatefulWidget {
  final void Function(String?)? onChangedMonths;
  final void Function(int?)? onChangedYears;
  const CustomHorizontalCalendarWidget({super.key, this.onChangedMonths, this.onChangedYears});

  @override
  State<CustomHorizontalCalendarWidget> createState() =>
      _CustomHorizontalCalendarWidgetState();
}

class _CustomHorizontalCalendarWidgetState
    extends State<CustomHorizontalCalendarWidget> {
  DayStructerController dayStructerController =
      Get.put(DayStructerController());
  @override
  Widget build(BuildContext context) {
    List<DateTime> monthDates = dayStructerController.getMonthDates();
    return GetBuilder(
        init: dayStructerController,
        builder: (context) {
          return Card(
            surfaceTintColor: AppColors.whiteA700,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal:10.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          DropdownButton<String>(
                            value: DateFormat('MMM').format(
                                dayStructerController.selectedDategetMonth ??
                                    DateTime.now()),
                            items: List.generate(12, (index) {
                              DateTime month =
                                  DateTime(DateTime.now().year, index + 1);
                              return DropdownMenuItem<String>(
                                value: DateFormat('MMM').format(month),
                                child: Text(DateFormat('MMM').format(month)),
                              );
                            }),
                            onChanged: widget.onChangedMonths
                          ),
                          const SizedBox(width: 8.0),
                          DropdownButton<int>(
                            value: dayStructerController.selectedYear.value,
                            items: List.generate(3, (index) {
                              int year = DateTime.now().year - 1 + index;
                              return DropdownMenuItem<int>(
                                value: year,
                                child: Text(year.toString()),
                              );
                            }),
                            onChanged: widget.onChangedYears
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: monthDates.length,
                      itemBuilder: (context, index) {
                        DateTime date = monthDates[index];
                        bool isSelected =
                            dayStructerController.selectedDate.value == null
                                ? false
                                : date.day ==
                                        dayStructerController
                                            .selectedDategetMonth?.day &&
                                    date.month ==
                                        dayStructerController
                                            .selectedDategetMonth?.month &&
                                    date.year ==
                                        dayStructerController
                                            .selectedDategetMonth?.year;
                        return GestureDetector(
                          onTap: () => dayStructerController.onDateSelected(date),
                          child: Container(
                            width: 55.w,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.kprimary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(date.day.toString(),
                                    style: AppTextStyles.text16BlackBold.copyWith(
                                        color: isSelected
                                            ? AppColors.whiteA700
                                            : AppColors.black121212)),
                                Text(DateFormat('EEE').format(date).toUpperCase(),
                                    style: AppTextStyles.text16BlackBold.copyWith(
                                        color: isSelected
                                            ? AppColors.whiteA700
                                            : AppColors.gray)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
