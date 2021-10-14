import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'Dialog.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  AddDialog _dialog= new AddDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: ResponsiveFlutter.of(context).hp(7),
        backgroundColor: Colors.white,
        title: Text("مخاطبین",style: TextStyle(
          color: Colors.black,
          fontSize: ResponsiveFlutter.of(context).fontSize(3),
        ),
        textAlign: TextAlign.right,),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: 15,
          itemBuilder: (context, index) {
            return Padding(padding: EdgeInsets.only(
              left: ResponsiveFlutter.of(context).wp(2),
              right: ResponsiveFlutter.of(context).wp(2),
            ),
              child: contactItem(context),
            );
          },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image(
          image: AssetImage('assets/pic/2962618.png'),
        ),
        onPressed: (){
          _dialog.createAlertDialog(context);
        },
      )
    );
  }

  Container contactItem(context){
    return
      // children: <Widget>[
        Container(
          // width: ResponsiveFlutter.of(context).wp(90),
          height: ResponsiveFlutter.of(context).hp(12.5),
          child: Column(
            children: <Widget>[
              SizedBox(height: ResponsiveFlutter.of(context).hp(0.5),),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: ResponsiveFlutter.of(context).wp(10),
                    backgroundImage: new AssetImage('assets/pic/2962647.png'),
                  ),

                  SizedBox(width: ResponsiveFlutter.of(context).wp(2),),
                  Column(
                    children: <Widget>[
                      Text('name',style: TextStyle(
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                        fontWeight: FontWeight.bold,
                      ),
                        textAlign: TextAlign.center,),
                      SizedBox(height: ResponsiveFlutter.of(context).hp(1),),
                      Text('number',style: TextStyle(
                        fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                      ),
                        textAlign: TextAlign.center,),
                    ],
                  )
                ],
              ),
              Row(children: <Widget>[
                Expanded(
                  child: new Container(
                      height: 0.0,
                      margin:  EdgeInsets.only(
                        right: ResponsiveFlutter.of(context).wp(22),
                        // left: ResponsiveFlutter.of(context).wp(8)
                      ),
                      child: Divider(
                        color: Colors.grey,
                        height: 0.0,
                      )),
                ),
              ]),
              SizedBox(height: ResponsiveFlutter.of(context).hp(0.5),),
            ],
          ),
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(
          //         Radius.circular(35)
          //     )
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(35)
          ),
          ),
      //   ),
      // ],
    );
  }


}



