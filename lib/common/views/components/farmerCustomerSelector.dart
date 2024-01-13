import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

enum UserMode { farmer, buyer }

class SingleUserSelector extends StatefulWidget {
  const SingleUserSelector({Key? key}) : super(key: key);

  @override
  State<SingleUserSelector> createState() => _SingleUserSelectorState();
}

class _SingleUserSelectorState extends State<SingleUserSelector> {
  UserMode userview = UserMode.buyer;


  @override
  Widget build(BuildContext context) {
    return SegmentedButton<UserMode>(
      segments: const <ButtonSegment<UserMode>>[
        ButtonSegment<UserMode>(
            value: UserMode.farmer,
            label: Text('Farmer'),
            icon: Icon(Icons.grass)),
        ButtonSegment<UserMode>(
            value: UserMode.buyer, label: Text('Buyer'), icon: Icon(Icons.shopping_bag)),
      ],
      selected: <UserMode>{userview},
      onSelectionChanged: (Set<UserMode> newSelection) {
        setState(() {

          userview = newSelection.first;
        });
      },
    );
  }
}
