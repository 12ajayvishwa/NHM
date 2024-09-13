import 'package:flutter/material.dart';
import '../../../widgets/app_bar_container.dart';

class AllSupervisorScreen extends StatefulWidget {
  const AllSupervisorScreen({super.key});

  @override
  State<AllSupervisorScreen> createState() => _AllSupervisorScreenState();
}

class _AllSupervisorScreenState extends State<AllSupervisorScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          appBarContainer(size, title: "All Supervisor", isLeading: true),
          Expanded(
            child: Container(
              child: Center(
                child: Text("All Supervisor"),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
