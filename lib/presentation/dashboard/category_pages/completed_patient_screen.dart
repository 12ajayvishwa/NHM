import 'package:flutter/material.dart';

import '../../../widgets/app_bar_container.dart';


class CompletedPatientScreen extends StatefulWidget {
  const CompletedPatientScreen({super.key});

  @override
  State<CompletedPatientScreen> createState() => _CompletedPatientScreenState();
}

class _CompletedPatientScreenState extends State<CompletedPatientScreen> {
  @override
  Widget build(BuildContext context) {
    Size  size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          appBarContainer(size, title: "All Complete", isLeading: true),
          Expanded(
            child: Container(
              child: const Center(
                child: Text("All Complete"),
              ),
            ),
          )
        ],
      ),
    ));
  }
}