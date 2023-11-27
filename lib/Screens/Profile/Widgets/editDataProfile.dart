import 'package:flutter/material.dart';

class EditProfileDialog extends StatelessWidget {
  final TextEditingController dataController = TextEditingController();

  final String text;

  EditProfileDialog({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text),
      content: IntrinsicWidth(
        child: Container(
            width: 300,
          child: TextFormField(
            controller: dataController,
            maxLines: 2,
            style: TextStyle(color: Colors.black), // Màu chữ đen
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(10.0),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0)
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop('');
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white          
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
                Navigator.of(context).pop(dataController.text);
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ),
      ],
    );
  }
}
