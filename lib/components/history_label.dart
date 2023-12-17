



import 'package:flutter/material.dart';

class HistoryLabel extends StatelessWidget {
  const HistoryLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 70, bottom: 20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.70),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Padding(
                 padding: EdgeInsets.only(right: 150),
                 child: Text(
                    'S.No',
                    style: TextStyle(color: Colors.white),
                  ),
               ),
              Padding(
                padding: EdgeInsets.only(right: 400),
                child: Text(
                  'Video Title',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 400),
                child: Text(
                  'Message',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 0),
                child: Text(
                  'Date',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}