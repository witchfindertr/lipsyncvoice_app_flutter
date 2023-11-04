


import 'package:flutter/material.dart';

class AddVideoButton extends StatelessWidget {
  final String btnName;
  IconData icon;
  AddVideoButton({super.key, required this.btnName, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: ElevatedButton(
              onPressed: () {
        
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, size: 20, color: Colors.black,), 
                  const SizedBox(width: 2,),
                  Text(
                    btnName,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ), 
                ],
              ),
            ),
    );
  }
}