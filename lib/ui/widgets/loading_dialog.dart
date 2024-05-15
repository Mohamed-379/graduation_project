import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: Colors.black,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      content: Row(
        children: [
          Text("Loading...",
              style: TextStyle(fontFamily: "Exo", fontSize: 18, color: Colors.white)),
          Spacer(),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}
