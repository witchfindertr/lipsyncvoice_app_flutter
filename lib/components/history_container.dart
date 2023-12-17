



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/global_constants.dart';

class HistoryContainer extends StatefulWidget {
  const HistoryContainer({super.key, required this.serial, required this.videoName, required this.message, required this.date});

  final int serial;
  final String videoName;
  final String message;
  final String date;

  @override
  State<HistoryContainer> createState() => _HistoryContainerState();
}

class _HistoryContainerState extends State<HistoryContainer> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (a){
        setState(() {
          isHover = true;
        });
      },
      onExit: (a){
        setState(() {
          isHover = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 70),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          decoration: BoxDecoration(
            color: !isHover ? Globals.pagebgColor : Colors.grey,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 148),
                  child: SizedBox(
                    width: 35,
                    child: Text(
                        widget.serial.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                ),
    
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: SizedBox(
                    width: 450,
                    child: Text(
                        widget.videoName,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                  ),
                ),
                
                 Padding(
                   padding: EdgeInsets.only(right:16),
                   child: SizedBox(
                    width: 430,
                     child: Text(
                        widget.message,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                   ),
                 ),
      
                Padding(
                  padding:const EdgeInsets.only(right: 0),
                  child: Text(
                    widget.date,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}