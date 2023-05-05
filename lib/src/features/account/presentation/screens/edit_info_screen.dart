import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movieapp/src/common/widgets/snackbarr.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:movieapp/src/features/account/data/models/user_model.dart';

class EditInfoScreen extends StatelessWidget {
  const EditInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'Edit Info',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.10),
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefix: Text(
                  'Name:       ',
                  style: TextStyle(
                      color: secondaryTextColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side: BorderSide(
                        width: 2.0,
                        color: Colors.white.withOpacity(0.5),
                      )),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 14),
                  ),
                  onPressed: () {
                    showSnackBar(context, 'changes saved');

                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
