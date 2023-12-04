import 'package:flutter/material.dart';
import 'package:believeder_app/constant/colors_constant.dart';

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
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.only(
          top: 5.0,
          left: 10.0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      content: IntrinsicWidth(
        child: Container(
          width: 400,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.32,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
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
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.32,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 161, 117, 169),
                  ),
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
            ),
          ],
        )    
      ],
    );
  }
}
