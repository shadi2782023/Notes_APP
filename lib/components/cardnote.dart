import 'package:flutter/material.dart';
import 'package:notesapp/model/notemodel.dart';
import '../constant/linkapi.dart';

class CardNote extends StatelessWidget {
  const CardNote(
      {super.key,
      required this.ontap,
      required this.notemodel,
      required this.onDelete});
  final void Function() ontap;
  final NotesModel notemodel;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade500, Colors.grey.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),
          color: Colors.transparent,
          elevation: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImageRoot/${notemodel.notesImage}",
                  fit: BoxFit.fill,
                  width: 150,
                  height: 150,
                ),
              ),
              Expanded(
                flex: 2,
                child: ListTile(
                  title: Text(
                    "${notemodel.notesTitle}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${notemodel.notesContent}",
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () => _showDeleteDialog(context),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm deletion ',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.yellow.shade900),
          ),
          content: Text('Do you want delete this note?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (onDelete != null) {
                  onDelete!();
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade900,
              ),
              child: const Text('delete'),
            ),
          ],
        );
      },
    );
  }
}
