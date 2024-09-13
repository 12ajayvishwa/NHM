import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/constants/app_export.dart';
import '../theme/color_constants.dart';
import '../theme/text_style.dart';

class DayStructerController extends GetxController {
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  DateTime? date;
  RxInt month = 0.obs;
  RxBool isDateSelected = false.obs;

  DateTime? selectedDategetMonth;
  RxInt selectedMonth = DateTime.now().month.obs;
  RxInt selectedYear = DateTime.now().year.obs;

  List<DateTime> getMonthDates() {
    int year = selectedDategetMonth?.year ?? DateTime.now().year;
    int month = selectedDategetMonth?.month ?? DateTime.now().month;
    int lastDay = DateTime(year, month + 1, 0).day;

    return List.generate(lastDay, (index) => DateTime(year, month, index + 1));
  }

  void onDateSelected(DateTime date) {
    selectedDategetMonth = date;
    selectedDate.value = selectedDategetMonth;
    isDateSelected.value = true;
    update();
  }

  changeDayStructureExample() {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (data) {
        selectedDate.value = data;
        isDateSelected.value = true;
        month.value = data.month;
      },
      activeColor: AppColors.kprimary,
      headerProps: const EasyHeaderProps(
        dateFormatter: DateFormatter.dayOnly(),
      ),
      dayProps: EasyDayProps(
        height: 58.0.h,
        width: 62.0.w,
        dayStructure: DayStructure.dayNumDayStr,
        todayStyle: DayStyle(dayNumStyle: AppTextStyles.text16BlackBold),
        inactiveDayStyle: DayStyle(
          borderRadius: 48.0.r,
          dayNumStyle: AppTextStyles.text16BlackBold,
        ),
        activeDayStyle: DayStyle(
          dayStrStyle: AppTextStyles.text16BlackBold
              .copyWith(color: AppColors.whiteA700),
          dayNumStyle: AppTextStyles.text16BlackBold
              .copyWith(color: AppColors.whiteA700),
        ),
      ),
    );
  }

  void resetSelectedDate() {
    selectedDate.value = null;
    isDateSelected.value = false;
  }
}
