import 'package:flutter/material.dart';
import 'package:graduation_project/ui/home/home_screen.dart';

class ErrorDialog extends StatelessWidget {
  String? message;
  ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      title: const Text("Error!",textAlign: TextAlign.center, style: TextStyle(fontFamily: "Exo", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      content: Text(message ??"Something went wrong please try again later", style: const TextStyle(fontFamily: "Exo", fontSize: 18, color: Colors.white)),
      actions: [
        Center(
          child: TextButton(onPressed: (){
             Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }, child: const Text("Go to Home", style: TextStyle(color: Colors.white, fontFamily: "Exo", fontSize: 18, fontWeight: FontWeight.bold),),),
        )
      ],
    );
  }
}
