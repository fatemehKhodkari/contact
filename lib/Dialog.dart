import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';


class AddDialog{
  createAlertDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
            builder: (BuildContext context,StateSetter setState){
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(0.0),
                insetPadding: const EdgeInsets.all(0.0),
                actionsOverflowButtonSpacing: 0.0,
                content: Container(
                  width: 100,
                  height: 100,
                  child: Column(
                    children: [
                      Container(
                        height: 100.0,
                        width: 100.0,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 16.0,),
                      Container(
                        height: 24,
                        width: 100,
                        color: Colors.red,
                      )
                    ],
                  ),
                )
              );
          }
    );
  }
   );
  }
}