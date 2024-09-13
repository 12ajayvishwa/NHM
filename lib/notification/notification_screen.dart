import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pvi_nhm/theme/text_style.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../utils/custom_toast.dart';
import '../../widgets/custom_time_ago.dart';
import '../controllers/notification_controller.dart';
import '../core/constants/app_export.dart';
import '../core/constants/session_manager.dart';
import '../data/model/notification_model.dart';
import '../theme/color_constants.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/custom_image_view.dart';
import '../widgets/custom_pagination_view.dart';

class NotificationScreen extends StatefulWidget {
  static String route = '/notifications';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final PagingController<int, dynamic> pagingController = PagingController(
    firstPageKey: 1,
  );
  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);

      pagingController.addStatusListener((status) {
        if (status == PagingStatus.subsequentPageError) {}
      });
    });

    toast.init(context);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await notificationController.getNotification(
        pageKey: pageKey,
        pageSize: notificationController.perPage,
      );
      final isLastPage = newItems.length < notificationController.perPage;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: "Notification",
        // isFiltter: true,
        // actions: TextButton.icon(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.check,
        //       color: AppColors.blackLight,
        //     ),
        //     label: Text(
        //       "Read All",
        //       style: AppTextStyles.bodyText,
        //     )),
        isLeading: true,
        onPressed: () {
          Get.back();
        },
      ),
      body: CustomPaginationView(
          msg: "No Notification Found",
          noDataFound: () {
            pagingController.refresh();
          },
          onRefresh: () => Future.sync(() {
                pagingController.refresh();
              }),
          pagingController: pagingController,
          itemBuilder: (p0, p1, p2) {
            NotificationsModel data = NotificationsModel.fromJson(p1);
            return notificationCard(data);
          }),
    );
  }

  notificationCard(NotificationsModel data) {
    DateTime sentAt = DateTime.parse(data.createdAt.toString());
    timeago.setLocaleMessages('custom', CustomTimeMessages());
    String timeAgo = timeago.format(sentAt, locale: 'custom');

    return InkWell(
      onTap: data.readAt == null
          ? () {
            
            }
          : null,
      child: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: data.readAt == null
                ? AppColors.ksecondaryColor
                : AppColors.gray,
            borderRadius: BorderRadius.circular(10.r)
          ),
          child: Row(children: [
            CustomImageView(
              svgPath: "assets/icons/notification.svg",
              color: AppColors.whiteA700,
            ),
            SizedBox(width: 10.w,),
            Column(
              children: [
                // SizedBox(
                //   width: 300.w,
                //   child: Text(
                //     data.subject.toString(),
                //     overflow: TextOverflow.ellipsis,
                //     maxLines: 2,
                //     style: AppTextStyles.text18White600,
                //   ),
                // ),
                SizedBox(
                  width: 300.w,
                  child: Text(
                    data.body.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppTextStyles.text14White400,
                  ),
                ),
              ],
            ),
            Text(
              timeAgo,
              style: AppTextStyles.text12WhiteRegular
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ]),
          
        ),
      ),
    );
  }
}
