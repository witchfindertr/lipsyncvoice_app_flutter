import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lipsyncvoice_app/components/addvid_btn.dart';
import 'package:lipsyncvoice_app/components/contact_btn.dart';
import 'package:open_file/open_file.dart';

import '../utils/global_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool contactPressed = false;
  bool arrowPressed = false;
  contactOnPress() {
    setState(() {
      contactPressed = !contactPressed;
    });
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
                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
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
                                position: const RelativeRect.fromLTRB(400, 60, 0, 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                items: <PopupMenuItem<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'Sign Out',
                                    child: Text('Sign Out'),
                                  ),
                                ],
                              ).then((value) async {
                                if (value != null) {
                                  if (value == "Sign Out"){
                                    Navigator.of(context).pop();
                                  }
                                } 
                                await Future.delayed(const Duration(milliseconds: 100));
                                setState(() {
                                  arrowPressed = !arrowPressed;
                                });
                              });
                            },
                            child: !arrowPressed ? const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ): const Icon(Icons.keyboard_arrow_up, color: Colors.white,) )
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
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AddVideoButton(
                            icon: Icons.history,
                            btnName: "View History",
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
                                style: GoogleFonts.poppins(color: Colors.white)),
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
                     FloatingActionButton(
                          backgroundColor: Colors.black,
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles();
                            if (result == null) return;
                            final file = result.files.first;
                            openFile(file);
                          },
                          child: const Icon(Icons.add, color: Colors.white,),
                        ),
                        const SizedBox(height: 10,),
                        Text("Upload Video" , style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),)
                      
                    ],
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void openFile(PlatformFile file){
    OpenFile.open(file.path);
  }

}
