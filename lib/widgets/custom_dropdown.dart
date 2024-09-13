import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pvi_nhm/widgets/custom_circuler_loader.dart';
import '../core/constants/app_export.dart';
import '../theme/color_constants.dart';
import '../theme/text_style.dart';

// ignore: must_be_immutable
class CustomDropdown extends StatefulWidget {
  final String hintText;
  final String? labelText;
  void Function(String?)? onSave;
  void Function(String?)? onChng;
  String? Function(String?)? validator;
  Function(List<dynamic>)? onChanged;
  bool isMultiselect = false;
  String? selectedItem;
  List<dynamic>? multiSelected;
  bool showSearchBox;
  bool? isValidate;
  void Function(List<dynamic>, dynamic)? popupOnItemAdded;
  void Function(List<dynamic>, dynamic)? popupOnItemRemoved;
  Widget? prefix;
  InputBorder? border;

  List<String> listName;
  CustomDropdown({
    this.prefix,
    this.labelText,
    this.onChng,
    this.multiSelected,
    this.popupOnItemRemoved,
    this.popupOnItemAdded,
    this.isValidate = true,
    required this.hintText,
    required this.listName,
    this.selectedItem,
    this.border,
    this.onSave,
    this.validator,
    this.isMultiselect = false,
    this.onChanged,
    this.showSearchBox = false,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? value = "";

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.labelText);
    }
    return Stack(
      children: [
        widget.isMultiselect
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.labelText != null
                      ? Text(widget.labelText!,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.textFieldLabel)
                      : const SizedBox(),
                  widget.labelText != null
                      ? SizedBox(height: 5.h)
                      : const SizedBox(),
                  DropdownSearch.multiSelection(
                    selectedItems: widget.multiSelected ?? [],
                    // to check validation

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select one or more option';
                      }
                      return null;
                    },
                    compareFn: (item, selectedItem) {
                      return item == selectedItem;
                    },
                    filterFn: (item, filter) {
                      return item.toLowerCase().contains(filter.toString());
                    },

                    dropdownButtonProps: const DropdownButtonProps(
                        icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                    )),
                    items: widget.listName,
                    onChanged: widget.onChanged,

                    popupProps: PopupPropsMultiSelection.menu(),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 20.h),
                            filled: true,
                            fillColor: const Color(0xffF1F0F1),
                            hintText: widget.hintText,
                            border: widget.border ??
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                    borderSide: BorderSide.none),
                            enabledBorder: widget.border ??
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                    borderSide: BorderSide.none),
                            focusedBorder: widget.border ??
                                OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                    borderSide: BorderSide.none),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.w),
                            ))),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.labelText != null
                      ? Text(widget.labelText!,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.textFieldLabel)
                      : const SizedBox(),
                  widget.labelText != null
                      ? SizedBox(height: 5.h)
                      : const SizedBox(),
                  DropdownSearch<String>(
                    clearButtonProps: const ClearButtonProps(isVisible: true),
                    selectedItem: widget.selectedItem,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: widget.validator,
                    dropdownBuilder: (context, selectedItem) {
                      return Text(
                        selectedItem ?? widget.hintText,
                        style: AppTextStyles.smallText,
                      );
                    },
                    popupProps: PopupProps.menu(
                        showSearchBox: true,
                        emptyBuilder: (context, searchEntry) {
                          return Center(
                            child: Text(
                              'No item found',
                              style: AppTextStyles.smallText,
                            ),
                          );
                        },
                        loadingBuilder: (context, searchEntry) {
                          return CustomLoading();
                        },
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.r),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.w),
                            ),
                            hintText: "Search",
                            hintStyle: AppTextStyles.smallText,
                          ),
                          style: AppTextStyles.smallText,
                          cursorColor: Colors.black,
                          cursorHeight: 20.h,
                          cursorWidth: 2.w,
                          textInputAction: TextInputAction.search,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.text,
                        )),
                    onSaved: widget.onSave,
                    items: widget.listName.toList(),
                    onChanged: widget.onChng,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: customInputDecoration(
                        const Color(0xffF1F0F1),
                        widget.hintText,
                        false,
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  customInputDecoration(Color fillColor, String hintText, bool isPrefixIcon,
      {IconButton? iconButton,
      Widget? prefixIcon,
      Widget? suffixIcon,
      String? counterText,
      bool? offStage,
      bool? isDense,
      TextStyle? counterStyle,
      String? hinttText,
      String? errorText}) {
    double radius = 10;
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.h),
      hintText: hinttText,
      counterStyle: counterStyle,
      counterText: counterText,
      isDense: isDense ?? false,
      errorText: errorText,
      hintStyle: AppTextStyles.hintText,
      errorStyle: AppTextStyles.bodyText.copyWith(
          color: AppColors.red600D8,
          fontWeight: FontWeight.w400,
          fontSize: 10.sp),
      prefixIcon: widget.prefix == null
          ? null
          : Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
              child: widget.prefix,
            ),
      suffixIcon: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          bottom: 20.h,
        ),
        child: suffixIcon,
      ),
      filled: true,
      fillColor: fillColor,
      counter: Offstage(
        offstage: offStage ?? true,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide:
            BorderSide(color: AppColors.kprimary.withOpacity(0.2), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide:
              BorderSide(color: AppColors.kprimary.withOpacity(0.2), width: 1)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: Colors.red.withOpacity(0.8), width: 1)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide:
              BorderSide(color: AppColors.kprimary.withOpacity(0.2), width: 1)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Colors.grey, width: 1)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Colors.grey, width: 1)),
    );
  }
  // ignore: unused_element
}
