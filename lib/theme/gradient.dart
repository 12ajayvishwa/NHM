import '../core/constants/app_export.dart';
import 'color_constants.dart';

class AppGradient {
  static LinearGradient kContainerGradient() {
    return LinearGradient(
        colors: [
          AppColors.containerGradient.withOpacity(0.25),
          AppColors.containerGradient.withOpacity(0.8),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: const [0.5, 3.0]);
  }

  static LinearGradient kTopContainerColor() {
    return LinearGradient(
      begin: const Alignment(0.00, -1.00),
      end: const Alignment(0, 1),
      colors: [
        const Color(0xFF0CC58B).withOpacity(0.7),
        const Color(0xFF0CC58B).withOpacity(0)
      ],
    );
  }

  static LinearGradient kCircleGradient() {
    return const LinearGradient(
      begin: Alignment(0.98, -0.19),
      end: Alignment(-0.98, 0.19),
      colors: [Color(0xFF0EBE7E), Color(0xFF07D9AD)],
    );
  }
}
