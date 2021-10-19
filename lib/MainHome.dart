import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/modals.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:contact/sql_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'farsiNumber.dart';
import 'package:focused_menu/focused_menu.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key key}) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  Farsi _farsi=new Farsi();

  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _numberController = new TextEditingController();

  void _showForm(int id) async {
    if (id != null) {
      final existingJournal =
      _journals.firstWhere((element) => element['id'] == id);
      _nameController.text = existingJournal['name'];
      _numberController.text = existingJournal['number'];
    }

    showDialog(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context,StateSetter setState){
                return AlertDialog(
                    titlePadding: const EdgeInsets.all(0.0),
                    contentPadding: const EdgeInsets.all(0.0),
                    insetPadding: const EdgeInsets.all(0.0),
                    actionsOverflowButtonSpacing: 0.0,
                    backgroundColor: HexColor('FFFBED'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(60)
                      ),
                    ),
                    content: Container(
                      height: ResponsiveFlutter.of(context).hp(65),
                      width: ResponsiveFlutter.of(context).wp(70),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: ResponsiveFlutter.of(context).hp(5),
                                left: ResponsiveFlutter.of(context).wp(5),
                                right: ResponsiveFlutter.of(context).wp(5),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.0),
                                radius: ResponsiveFlutter.of(context).wp(15),
                                backgroundImage: AssetImage('assets/pic/addphoto.png'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: ResponsiveFlutter.of(context).hp(5),
                                left: ResponsiveFlutter.of(context).wp(5),
                                right: ResponsiveFlutter.of(context).wp(5),
                              ),
                              child: TextFormField(
                                controller: _nameController,
                                keyboardType: TextInputType.name,
                                style: TextStyle(
                                    fontSize: ResponsiveFlutter.of(context).fontSize(2.25)
                                ),
                                autofocus: true,
                                decoration: InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderSide: new BorderSide(width: 1.0,
                                     style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    top: ResponsiveFlutter.of(context).hp(2),
                                    bottom: ResponsiveFlutter.of(context).hp(2),
                                  ),
                                  // HexColor('bffdff')
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
                                controller: _numberController,
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
                                  hintText: _farsi.replaceFarsiNumber(''),
                                  labelText: 'تلفن',
                                  // border: InputBorder.none,
                                  prefixIcon: Icon(Icons.phone_outlined,color: Colors.grey,
                                    // size: 24.0
                                    size: MediaQuery.of(context).size.width/15,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: ResponsiveFlutter.of(context).hp(5),
                                left: ResponsiveFlutter.of(context).wp(20),
                                right: ResponsiveFlutter.of(context).wp(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FloatingActionButton(
                                    backgroundColor: Colors.white.withOpacity(0.0),
                                    child: Image(
                                      image: AssetImage('assets/pic/add.png'),
                                    ),
                                    splashColor: Colors.orange,
                                    elevation: 20,
                                    onPressed: () async {
                                      // Save new journal
                                      if (id == null) {
                                        await _addItem();
                                      }

                                      if (id != null) {
                                        await _updateItem(id);
                                      }

                                      // Clear the text fields
                                      _nameController.text = '';
                                      _numberController.text = '';

                                      // Close the bottom sheet
                                      Navigator.of(context).pop();
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) => MainHome()));
                                      print(_nameController.text);

                                    },
                                  ),
                                  SizedBox(width: ResponsiveFlutter.of(context).wp(5),),
                                  FloatingActionButton(
                                    backgroundColor: Colors.white.withOpacity(0.0),
                                    child: Image(
                                      image: AssetImage('assets/pic/remove.png'),
                                    ),
                                    splashColor: Colors.orange,
                                    elevation: 20.0,
                                    onPressed: (){

                                      // Clear the text fields
                                      _nameController.text = '';
                                      _numberController.text = '';
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    )
                );
              }
          );

        }
    );

  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _nameController.text, _numberController.text);
    _refreshJournals();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _nameController.text, _numberController.text);
    _refreshJournals();
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // backgroundColor: HexColor('FFFBED'),
      backgroundColor: Colors.orange,
      content: Text('مخاطب با موفقیت حذف شد!',
        style: TextStyle(
          color: HexColor('FFFBED')
        ),
      ),
    ));
    _refreshJournals();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HexColor('FFFBED'),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.2,
            color: Colors.blueGrey
          ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.orange,
        ),
        toolbarOpacity: 0.5,
        toolbarHeight: ResponsiveFlutter.of(context).hp(7),
        // backgroundColor: HexColor('bffdff'),
        // backgroundColor: HexColor('FFFBED'),
        backgroundColor: Colors.orange,
        title: Text(" مخاطبین",style: TextStyle(
          color: HexColor('FFFBED'),
          fontSize: ResponsiveFlutter.of(context).fontSize(3),
        ),
        textAlign: TextAlign.right,),
        elevation: 0.0,
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(color: HexColor('bffdff'),),
      )
          : ListView.builder(
        itemCount: _journals.length,
          itemBuilder: (context, index) {
            return Padding(padding: EdgeInsets.only(
              left: ResponsiveFlutter.of(context).wp(2),
              right: ResponsiveFlutter.of(context).wp(2),
            ),
              child: contactItem(context, index),
            );
          },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 20,
        // splashColor: HexColor('FFFBED'),
        splashColor: Colors.orange,
        child: Image(
          image: AssetImage('assets/pic/2962618.png'),
        ),
        // onPressed: (){
        //   _dialog.createAlertDialog(context);
        // },
        onPressed: () => _showForm(null),
      )
    );
  }
   dialogshow (BuildContext context,int index){
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
                  backgroundColor: HexColor('FFFBED'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(60)
                    ),
                  ),
                  content: Container(
                    height: ResponsiveFlutter.of(context).hp(25),
                    child: Column(
                      children: [
                        SizedBox(height: ResponsiveFlutter.of(context).hp(5),),
                        Text(
                          'آیا میخواهید این مخاطب را حذف کنید؟',
                          style: TextStyle(
                            fontSize: ResponsiveFlutter.of(context).fontSize(1.75),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: ResponsiveFlutter.of(context).hp(3),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              splashColor: Colors.orange,
                              iconSize: ResponsiveFlutter.of(context).wp(12),
                              splashRadius: ResponsiveFlutter.of(context).wp(12),
                              icon: Icon(Icons.cancel_outlined),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            IconButton(
                              splashColor: Colors.orange,
                              iconSize: ResponsiveFlutter.of(context).wp(12),
                              splashRadius: ResponsiveFlutter.of(context).wp(12),
                              icon: Icon(Icons.delete_outline_outlined,color: Colors.orange,),
                              onPressed: () {
                                _deleteItem(_journals[index]['id']);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                );
              }
          );
        }
    );}


  Widget contactItem(context,index){
      return FocusedMenuHolder(
          child: Container(
            // width: ResponsiveFlutter.of(context).wp(90),
            // height: ResponsiveFlutter.of(context).hp(12.5),
            child: Column(
              children: <Widget>[
                SizedBox(height: ResponsiveFlutter.of(context).hp(0.5),),
                SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.0),
                            radius: ResponsiveFlutter.of(context).wp(10),
                            backgroundImage: new AssetImage('assets/pic/2962647.png'),
                          ),

                          SizedBox(width: ResponsiveFlutter.of(context).wp(2),),
                          Column(
                            children: <Widget>[
                              Container(
                                width: ResponsiveFlutter.of(context).wp(72),
                                child: Text(_farsi.replaceFarsiNumber(_journals[index]['name']),style: TextStyle(
                                  fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                                  fontWeight: FontWeight.bold,
                                ),
                                  textAlign: TextAlign.right,),
                              ),
                              SizedBox(height: ResponsiveFlutter.of(context).hp(1),),
                              Container(
                                width: ResponsiveFlutter.of(context).wp(72),
                                child: Text(_farsi.replaceFarsiNumber(_journals[index]['number']),style: TextStyle(
                                  fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                                ),
                                  textAlign: TextAlign.right,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
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
          ),
          menuWidth: ResponsiveFlutter.of(context).wp(40),
          duration: Duration(seconds: 0),
          animateMenuItems: false,
          openWithTap: true,
          onPressed: () {},
          menuItems: [
            FocusedMenuItem(
              backgroundColor: HexColor('FFFBED'),
                title: Text('ویرایش',
                  style: TextStyle(
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => _showForm(_journals[index]['id']),
                trailingIcon: Icon(Icons.edit_outlined)
            ),
            FocusedMenuItem(
              backgroundColor: Colors.orange,
                title: Text('حذف',
                  style: TextStyle(
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                onPressed: () => dialogshow(context, index),
                trailingIcon: Icon(Icons.delete_outline_outlined,
                  color: Colors.white,
                )
              ),
          ],
        blurBackgroundColor: Colors.orange,
        blurSize: 2.5,
      );
        // children: <Widget>[
    }
  }




