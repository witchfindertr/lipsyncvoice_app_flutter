



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lipsyncvoice_app/components/history_container.dart';
import 'package:lipsyncvoice_app/components/history_label.dart';
import 'package:lipsyncvoice_app/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import '../utils/global_constants.dart';

class ViewHistoryPage extends StatefulWidget {
  const ViewHistoryPage({super.key, required this.userId});

  final int userId;
  @override
  State<ViewHistoryPage> createState() => _ViewHistoryPageState();
}

  

class _ViewHistoryPageState extends State<ViewHistoryPage> {
  bool arrowPressed = false;
  bool isLoading = false;
  List<dynamic> historyList = [];

  Future<void> getHistory(int userId) async {
    String apiUrl = 'http://127.0.0.1:3000/get_history'; 
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse('$apiUrl?user_id=$userId'));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        historyList = responseBody['history'];
        print(historyList);
      } else {
        print('Failed to get history data');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState(){
    getHistory(widget.userId);
    print(historyList);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 13),
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                decoration: BoxDecoration(
                    color: Globals.pagebgColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, icon: const Icon(Icons.arrow_circle_left_rounded, color: Colors.white,size: 25,)),
                        const SizedBox(width: 10,),
                        const Text(
                          "LipsSyncVoice.ai",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Home",
                              style: GoogleFonts.poppins(color: Colors.white),
                            )),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                arrowPressed = !arrowPressed;
                              });
                              showMenu(
                                context: context,
                                position:
                                    const RelativeRect.fromLTRB(400, 60, 0, 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                items: <PopupMenuItem<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'Sign Out',
                                    child: SizedBox(
                                      width: 95,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                        Icon(Icons.logout_sharp),
                                        SizedBox(width: 2,),
                                        Text('Sign Out'),
                                        SizedBox(width: 2,),]
                                        ),
                                    ),
                                  ),
                                ],
                              ).then((value) async {
                                if (value != null) {
                                  if (value == "Sign Out") {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                                  }
                                }
                                await Future.delayed(
                                    const Duration(milliseconds: 100));
                                setState(() {
                                  arrowPressed = !arrowPressed;
                                });
                              });
                            },
                            child: !arrowPressed
                                ? const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.keyboard_arrow_up,
                                    color: Colors.white,
                                  ))
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70, top: 40, bottom: 10),
              child: Text("History", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 28),),
            ),
            const HistoryLabel(),
            if (!isLoading) SizedBox(
              height:MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.95 ,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 10,),
                itemCount: historyList.length,
                itemBuilder: (context,index){
                  print(index);
                  return HistoryContainer(serial: index, videoName: historyList[index]['name'], message: historyList[index]['message'], date: historyList[index]['date']);
              }),
            ),
            if(isLoading) const CircularProgressIndicator(color: Colors.black,)
            // HistoryContainer(serial: 1, videoName: 'Custom', message: 'wrue', date: '16/12/2023',)
        ],
      ),
    );
  }
}