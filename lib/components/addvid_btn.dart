


import 'package:flutter/material.dart';

class AddVideoButton extends StatelessWidget {
  final String btnName;
  final IconData icon;
  final Function() onPressed;
  const AddVideoButton({super.key, required this.btnName, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                // primary: Colors.grey,
                backgroundColor: Colors.grey
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, size: 20, color: Colors.black,), 
                  const SizedBox(width: 2,),
                  Text(
                    btnName,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ), 
                ],
              ),
            ),
    );
  }
}