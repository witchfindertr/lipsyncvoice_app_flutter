


import 'package:flutter/material.dart';

class ContactButton extends StatelessWidget {
  final String btnName;
  final Function() onPressed;
  bool isPressed;
  ContactButton({super.key, required this.btnName, required this.onPressed, required this.isPressed});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        btnName,
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      !isPressed ? const Icon(Icons.arrow_drop_down_rounded, color: Colors.black, size: 25,): const Icon(Icons.arrow_drop_up_rounded, color: Colors.black, size: 25,)
                    ],
                  ), 
            ),
    );
  }
}