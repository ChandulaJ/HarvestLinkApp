import 'package:flutter/material.dart';

class SingleSelector extends StatefulWidget {
  const SingleSelector({Key? key}) : super(key: key);

  @override
  State<SingleSelector> createState() => _SingleSelectorState();
}

class _SingleSelectorState extends State<SingleSelector> {
  bool isFarmer = true; // Default value for isFarmer

  @override
  Widget build(BuildContext context) {
    return GroupedButton<Text>(
      buttons: <Button<Text>>[
        Button<Text>(
          child: Text("Farmer"),
          onPressed: () {
            setState(() {
              isFarmer = true;
            });
          },
          selected: isFarmer,
        ),
        Button<Text>(
          child: Text("Customer"),
          onPressed: () {
            setState(() {
              isFarmer = false;
            });
          },
          selected: !isFarmer,
        ),
      ],
    );
  }
}
