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
                  height: ResponsiveFlutter.of(context).hp(60),
                  width: ResponsiveFlutter.of(context).wp(70),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: ResponsiveFlutter.of(context).hp(5),
                          left: ResponsiveFlutter.of(context).wp(5),
                          right: ResponsiveFlutter.of(context).wp(5),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          style: TextStyle(
                              fontSize: ResponsiveFlutter.of(context).fontSize(2.25)
                          ),
                          autofocus: true,
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(width: 1.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsets.only(
                              top: ResponsiveFlutter.of(context).hp(2),
                              bottom: ResponsiveFlutter.of(context).hp(2),
                            ),
                            labelText: 'نام و نام خانوادگی',
                            // border: InputBorder.none,
                            prefixIcon: Icon(Icons.person_outline,color: Colors.grey,
                              // size: 24.0
                              size: MediaQuery.of(context).size.width/15,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          top: ResponsiveFlutter.of(context).hp(5),
                          left: ResponsiveFlutter.of(context).wp(5),
                          right: ResponsiveFlutter.of(context).wp(5),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(2.25)
                          ),
                          autofocus: true,
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(width: 1.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            contentPadding: EdgeInsets.only(
                              top: ResponsiveFlutter.of(context).hp(2),
                              bottom: ResponsiveFlutter.of(context).hp(2),
                            ),
                            labelText: 'تلفن',
                            // border: InputBorder.none,
                            prefixIcon: Icon(Icons.phone_outlined,color: Colors.grey,
                              // size: 24.0
                              size: MediaQuery.of(context).size.width/15,
                            ),
                          ),
                        ),
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