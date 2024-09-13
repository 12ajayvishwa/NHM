import '../../core/constants/app_export.dart';
import '../../theme/theme_helper.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Size size;
  final Widget svgIcon1;
  final VoidCallback onPressed1;
  final Widget svgIcon2;
  final VoidCallback onPressed2;
  final Widget svgIcon3;
  final VoidCallback onPressed3;

  const CustomBottomNavBar({
    Key? key,
    required this.size,
    required this.svgIcon1,
    required this.onPressed1,
    required this.svgIcon2,
    required this.onPressed2,
    required this.svgIcon3,
    required this.onPressed3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          height: size.height * 0.08,
          width: size.width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: appTheme.orange)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: onPressed1,
                child: svgIcon1,

                // SvgPicture.asset(
                //   "assets/icons/light/Home.svg",
                //   height: 30,
                //   width: 30,
                //   color: kGrayColor2,
                // ),
              ),
              InkWell(onTap: onPressed2, child: svgIcon2),
              InkWell(onTap: onPressed3, child: svgIcon3),
            ],
          ),
        ),
      ),
    );
  }
}
