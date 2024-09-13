import 'package:flutter/material.dart';
import 'package:pvi_nhm/widgets/app_bar_container.dart';

class AllPatientScreen extends StatefulWidget {
  const AllPatientScreen({super.key});

  @override
  State<AllPatientScreen> createState() => _AllPatientScreenState();
}

class _AllPatientScreenState extends State<AllPatientScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          appBarContainer(size, title: "All Patient", isLeading: true),
          Expanded(
            child: Container(
              child: const Center(
                child: Text("All Patient"),
              ),
            ),
          )
        ],
      ),
    ));}
}
