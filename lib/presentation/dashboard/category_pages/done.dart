import 'package:flutter/material.dart';

import '../../../widgets/app_bar_container.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({super.key});

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          appBarContainer(size, title: "All Done", isLeading: true),
          Expanded(
            child: Container(
              child: const Center(
                child: Text("All Done"),
              ),
            ),
          )
        ],
      ),
    ));
  }
}