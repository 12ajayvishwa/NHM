import 'package:flutter/material.dart';
import '../../../widgets/app_bar_container.dart';

class PandingPatientScreen extends StatefulWidget {
  const PandingPatientScreen({super.key});

  @override
  State<PandingPatientScreen> createState() => _PandingPatientScreenState();
}

class _PandingPatientScreenState extends State<PandingPatientScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      width: size.width,
      height: size.height, 
      child: Column(
        children: [
          appBarContainer(size, title: "Pending Patients", isLeading: true),
          Expanded(
            child: Container(
              child: const Center(
                child: Text("Pending Patients"),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
