
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:lipsyncvoice_app/screens/view_history.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:universal_image_picker_web/image_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lipsyncvoice_app/components/addvid_btn.dart';
import 'package:lipsyncvoice_app/components/contact_btn.dart';
import 'package:open_file/open_file.dart';
import 'dart:html' as html;
import "package:http/http.dart" as http;

import '../utils/global_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user_id});
  final int user_id;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool contactPressed = false;
  bool arrowPressed = false;
  bool showAdd = true;
  bool isVideoProcess = false;
  bool isVideoComplete = false;
  late String message;
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration audioDuration = const Duration();

  @override
  void initState(){
    _audioPlayer.setSourceUrl("assets/audio/speech.wav");
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
      print('Audio playback completed');
    });
    _audioPlayer.onPositionChanged.listen((event) {
      setState(() {
        audioDuration = event;
      });
    });
   
    super.initState();
  }

  void playAudio(bool play){
    if (play){
      _audioPlayer.play(UrlSource('assets/audio/speech.wav'));
      setState(() {
        isPlaying = true;
      });
    }
    else{
      _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    }
  }

  resetStates(){
    setState(() {
      contactPressed = false;
      arrowPressed = false;
      showAdd = true;
      isVideoProcess = false;
      // _isPlaying = false;
      isVideoComplete = false;
    });
  }

  contactOnPress() {
    setState(() {
      contactPressed = !contactPressed;
    });
  }

  void uploadVideo(Uint8List videoData) async {
     try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/runTest'),
        body: videoData,
        headers: {
          'Content-Type': 'video/mpg', 
        },
      );
      if (response.statusCode == 200){
        final data = json.decode(response.body);
       setState(() {
        isVideoComplete = true;
        message = data['output'];
        isVideoProcess = false;
        // createHistory('custom.mpg', message);
      });
      }}

      catch(error){
        print(error.toString());
      }
  
  }


  void createHistory(String name, String message_) async {
    String apiUrl = 'http://127.0.0.1:3000/add_message'; 

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'message': message_,
          'user_id':widget.user_id
        }),
      );

      if (response.statusCode == 200) {
        print('Message added successfully');
      } else {
        print('Failed to add message');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                decoration: BoxDecoration(
                    color: Globals.pagebgColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "LipsSyncVoice.ai",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        GestureDetector(onTap: (){
                          resetStates();
                        }, child: const Icon(Icons.restart_alt, color: Colors.white,)),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "About Us",
                              style: GoogleFonts.poppins(color: Colors.white),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "Demo",
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
                                    Navigator.of(context).pop();
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
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      width: 200,
                      height: MediaQuery.sizeOf(context).height * 0.88,
                      decoration: BoxDecoration(
                          color: Globals.pagebgColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AddVideoButton(
                            icon: Icons.add_circle,
                            btnName: "Upload Video",
                            onPressed: () async {
                              await ImagePickerWeb.getVideoAsBytes().then((value) => {
                              setState(() {
                              showAdd = false;
                              isVideoProcess = true;
                            }),
                              // getAudio(value!)
                              uploadVideo(value!)
                            });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AddVideoButton(
                            icon: Icons.history,
                            btnName: "View History",
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_) => ViewHistoryPage(userId: widget.user_id,)));
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ContactButton(
                              btnName: "Contact Us",
                              onPressed: contactOnPress,
                              isPressed: contactPressed),
                          const SizedBox(
                            height: 10,
                          ),
                          if (contactPressed) ...[
                            Text(
                              "Muhammad: 03202907153",
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                            Text("Faraz: 03323377681",
                                style:
                                    GoogleFonts.poppins(color: Colors.white)),
                            Text("Ronit: 03342542450",
                                style: GoogleFonts.poppins(color: Colors.white))
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        if (showAdd) SizedBox(
                          height: 50,
                          child: ElevatedButton.icon(onPressed: () async {
                            await ImagePickerWeb.getVideoAsBytes().then((value) => {
                              setState(() {
                              showAdd = false;
                              isVideoProcess = true;
                            }),
                              uploadVideo(value!)
                              
                            });
                          }, icon: const Icon(Icons.add), label: const Text("Upload Video"), style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Colors.black)
                              )
                            )
                          ),),
                        ),
                        
                        const SizedBox(
                          height: 10,
                        ),
                       
                        if (isVideoProcess) const SizedBox(
                          height: 40,
                          width: 40,
                          child:  LoadingIndicator(
                            indicatorType: Indicator.ballScaleMultiple, 
                            colors:  [Colors.white, Colors.orange],      
                            strokeWidth: 2,                     
                            backgroundColor: Colors.white,      
                            pathBackgroundColor: Colors.black   
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (isVideoProcess) Text(
                          "Processing the Video",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 12),
                        ),
                        if (isVideoComplete) Text(
                          "The message in the video is: ",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 18),
                        ),
                        if (isVideoComplete) 
                        SizedBox(
                          width: 500,
                          child: Text(
                          message,
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 18),
                        ),),
                        const SizedBox(height: 20,),
                       if (isVideoComplete) ElevatedButton.icon(onPressed: (){
                          playAudio(!isPlaying);
                        }, icon: isPlaying ?  const Icon(Icons.pause) : const Icon(Icons.play_arrow), label: isPlaying ? const Text("Pause Audio") : const Text("Play Audio")),
                       const SizedBox(height: 20,),
                       if (isVideoComplete) Text('${audioDuration.inMinutes}:${(audioDuration.inSeconds % 60).toString().padLeft(2, '0')}'),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
