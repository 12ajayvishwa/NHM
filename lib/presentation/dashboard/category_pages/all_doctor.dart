import 'package:flutter/material.dart';
import '../../../widgets/app_bar_container.dart';

class AllDoctorScreen extends StatefulWidget {
  const AllDoctorScreen({super.key});

  @override
  State<AllDoctorScreen> createState() => _AllDoctorScreenState();
}

class _AllDoctorScreenState extends State<AllDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          appBarContainer(size, title: "All Doctor", isLeading: true),
          Expanded(
            child: Container(
              child: const Center(
                child: Text("All Doctor"),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
