import 'package:flutter/material.dart';

showLoadingDialog(BuildContext context)
{
  return showDialog(context: context, builder:
      (context) => const AlertDialog(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        content: Row(
          children: [
            Text("Loading...", style: TextStyle(fontSize: 18,fontFamily: "Exo")),
            Spacer(),
            CircularProgressIndicator(color: Colors.black,)
          ],
        ),
      ),
    barrierDismissible: false
  );
}

hideLoadingDialog(BuildContext context)
{
  Navigator.pop(context);
}

showErrorsDialog(BuildContext context, String message)
{
  showDialog(context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        title: const Text("Error!",textAlign: TextAlign.center, style: TextStyle(fontFamily: "Exo", fontSize: 18, fontWeight: FontWeight.bold)),
        content: Text(message, style: const TextStyle(fontFamily: "Exo", fontSize: 18)),
        actions: [
          Center(
            child: TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Ok", style: TextStyle(color: Colors.black, fontFamily: "Exo", fontSize: 18, fontWeight: FontWeight.bold),),),
          )
        ],
      ),
  );
}

showDialogM(BuildContext context) async{
  return showDialog(context: context, builder: (context) => const AlertDialog(content: Text("Nothing..."),),);
}