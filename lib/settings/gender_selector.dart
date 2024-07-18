// gender_selection.dart

import 'package:flutter/material.dart';

void GenderSelector(BuildContext context, TextEditingController genderController) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Selecciona tu género'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                genderController.text = 'Femenino';
                Navigator.pop(context);
              },
              child: ListTile(
                title: Text('Femenino'),
              ),
            ),
            GestureDetector(
              onTap: () {
                genderController.text = 'Masculino';
                Navigator.pop(context);
              },
              child: ListTile(
                title: Text('Masculino'),
              ),
            ),
            GestureDetector(
              onTap: () {
                genderController.text = 'Otro';
                Navigator.pop(context);
              },
              child: ListTile(
                title: Text('Otro'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
