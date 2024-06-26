import 'package:flutter/material.dart';

class OfficialTaskWidget extends StatelessWidget {
  final bool isSelected;
  final Function() onTap;

  const OfficialTaskWidget({
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
                color: const Color.fromARGB(255, 57, 254, 169),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'Official',
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
              'Official',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
