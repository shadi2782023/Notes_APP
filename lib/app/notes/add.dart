import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp/components/appbar.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/components/customtextform.dart';
import 'package:notesapp/components/valid.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';

class AddNotes extends StatefulWidget {
  final String hinttext;

  const AddNotes({super.key, required this.hinttext});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Curd {
  File? myfile;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  TextEditingController notes_title = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController notes_content = TextEditingController();
  bool isLoading = false;

  addNote() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequestWithFile(
          linkAddNotes,
          {
            "notes_title": notes_title.text,
            "notes_content": notes_content.text,
            "notes_users": sharedPreference.getString("user_id"),
          },
          myfile!);
      isLoading = false;
      setState(() {});
      if (response['status'] == "Success") {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed("home");
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Add Note'),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(color: Colors.yellow.shade800),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Form(
                key: formstate,
                child: ListView(
                  children: [
                    Image.asset("images/logo.png"),
                    const SizedBox(
                      height: 1,
                    ),
                    CustomTextFormLogin(
                        hinttext: "please enter the note's title",
                        icondata: Icons.title_outlined,
                        labeltext: "note's title",
                        isNumber: false,
                        obscuretext: false,
                        mycontroller: notes_title,
                        valid: (val) {
                          return validInput(val!, 1, 50);
                        }),
                    CustomTextFormLogin(
                        hinttext: "please enter the note's content",
                        icondata: Icons.content_paste_go_outlined,
                        labeltext: "note's content",
                        isNumber: false,
                        obscuretext: false,
                        mycontroller: notes_content,
                        valid: (val) {
                          return validInput(val!, 10, 255);
                        }),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // نصف قطر الحواف الدائرية
                          ),
                          color: myfile == null
                              ? Colors.yellow.shade800
                              : Colors.yellow.shade600,
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => SizedBox(
                                      height: 100,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Text(
                                              "Please Choose Image",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              XFile? xfile = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context).pop();
                                              setState(() {});

                                              myfile = File(xfile!.path);
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(8),
                                              child: const Text(
                                                "from Gallery",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              XFile? xfile = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context).pop();
                                              setState(() {});

                                              myfile = File(xfile!.path);
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(8),
                                              child: const Text(
                                                "from Camera",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                          },
                          textColor: Colors.black,
                          child: const Text(
                            "Choose File(image, text,...)",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.yellow.shade800,
                          onPressed: () async {
                            await addNote();
                          },
                          textColor: Colors.black,
                          child: const Text(
                            "Add",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
