import 'package:flutter/material.dart';

class PersonalTaskWidget extends StatelessWidget {
  final bool isSelected;
  final Function() onTap;

  const PersonalTaskWidget({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'Personal',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: onTap,
            child: const Text(
              'Personal',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
