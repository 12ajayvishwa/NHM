// ignore_for_file: avoid_print

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../core/constants/app_export.dart';
import '../theme/color_constants.dart';
import '../utils/empty_container.dart';
import 'custom_circuler_loader.dart';

// ignore: must_be_immutable
class CustomPaginationView extends StatelessWidget {
  CustomPaginationView(
      {super.key,
      required PagingController<int, dynamic> pagingController,
      required this.itemBuilder,
      this.onRefresh,
      this.msg,
      this.noDataFound})
      : _pagingController = pagingController;

  final PagingController<int, dynamic> _pagingController;
  final Widget Function(BuildContext, dynamic, int) itemBuilder;
  Future<void> Function()? onRefresh;
  void Function()? noDataFound;
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      
        onRefresh: onRefresh ??
            () => Future.sync(() {
                  _pagingController.refresh();
                }),
        color: AppColors.kprimary,
        child: PagedListView<int, dynamic>.separated(
          
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<dynamic>(
            
            animateTransitions: true,
            transitionDuration: const Duration(milliseconds: 500),
            firstPageProgressIndicatorBuilder: (context) =>
                const CustomLoading(),
            newPageProgressIndicatorBuilder: (context) => const CustomLoading(),
            noItemsFoundIndicatorBuilder: (context) => EmptyContainer(
              msg: msg,
              onTap: noDataFound!,
            ),
            
            noMoreItemsIndicatorBuilder: (context) {
              return SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      'No more items to display.',
                      style: TextStyle(color: AppColors.kprimary),
                    ),
                  ));
            },
            firstPageErrorIndicatorBuilder: (_) {
              print("PPPPPPPPPP ${_pagingController.error.toString()}");
              return ElevatedButton(
                  onPressed: () => _pagingController.refresh(),
                  child: Text(_pagingController.error.toString()));
            },
            newPageErrorIndicatorBuilder: (_) {
              print("Kkkkkkkkkkkkk ${_pagingController.error.toString()}");
              return ElevatedButton(
                  onPressed: () => _pagingController.retryLastFailedRequest(),
                  child: Text(_pagingController.error.toString()));
            },
            itemBuilder: itemBuilder,
          ),
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
        ));
  }
}
