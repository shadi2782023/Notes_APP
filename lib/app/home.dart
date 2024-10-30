import 'package:flutter/material.dart';
import 'package:notesapp/app/notes/edit.dart';
import 'package:notesapp/components/cardnote.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';
import 'package:notesapp/model/notemodel.dart';
import '../components/appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Curd {
  getNotes() async {
    var notesUser = sharedPreference.getString("user_id".toString());
    // ignore: avoid_print
    print("Request URL: $linkViewNotes");
    // ignore: avoid_print
    print("Request Data: {\"notes_users\": \"$notesUser\"}");

    var response =
        await postRequest(linkViewNotes, {"notes_users".toString(): notesUser});

    // ignore: avoid_print
    print("Response: $response");

    if (response != null && response['data'] != null) {
      return response;
    } else {
      return {"data": []};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: 'Home',
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Note",
        mouseCursor: MouseCursor.uncontrolled,
        backgroundColor: Colors.yellow.shade800,
        onPressed: () {
          Navigator.of(context).pushNamed("addnote");
        },
        child: const Icon(
          Icons.add,
          size: 25,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapchot) {
                if (snapchot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text("Loading..."),
                  );
                }

                if (snapchot.hasError) {
                  return Center(
                    child: Text("Error: ${snapchot.error}"),
                  );
                }
                // ignore: avoid_print
                print("Snapshot Data: ${snapchot.data}");
                if (!snapchot.hasData ||
                    snapchot.data == null ||
                    snapchot.data['data'] == null) {
                  return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No data available",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow.shade800),
                          ),
                        ]),
                  );
                }

                if (!snapchot.hasData ||
                    snapchot.data == null ||
                    snapchot.data['data'] == null) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No data available",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow.shade800),
                        ),
                      ]);
                }

                var data = snapchot.data['data'];

                if (data is List && data.isNotEmpty) {
                  return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return CardNote(
                        onDelete: () async {
                          var response = await postRequest(linkDeleteNotes, {
                            "notes_id":
                                snapchot.data['data'][i]['notes_id'].toString(),
                            "notes_image": snapchot.data['data'][i]
                                    ['notes_image']
                                .toString()
                          });
                          if (response['status'] == "Success") {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushReplacementNamed("home");
                          }
                        },
                        ontap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditNote(
                                    notes: snapchot.data['data'][i],
                                  )));
                        },
                        notemodel:
                            NotesModel.fromJson(snapchot.data['data'][i]),
                      );
                    },
                  );
                } else if (data is Map) {
                  return Center(
                    child: Text(
                      "Data is in map format: ${data.toString()}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow.shade800),
                    ),
                  );
                } else {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "you don't have any note!",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow.shade800),
                              ),
                              Text(
                                "you can add one",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow.shade800),
                              ),
                            ]),
                      ]);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
