import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_abuba/isoft/operation_page/logbook/linecheck/form_linechekc.dart';

class FormCheckIn extends StatefulWidget {
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final String namaUser;
  final String departmentUser;

  FormCheckIn(
      {this.outlet,
      this.imageOutlet,
      this.alamatOutlet,
      this.idOutlet,
      this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormCheckInState createState() => _FormCheckInState();
}

class _FormCheckInState extends State<FormCheckIn> {
  DateTime checkinNow = DateTime.now();
  var maxid = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.25,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
        ),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              Container(
                height: 400.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Line Check Shifting',
                            style: TextStyle(
                                color: Colors.black12, fontSize: 12.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text(
                              '|',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontSize: 12.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text(
                              'Location',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Welcome to ${widget.outlet}',
                                  style: TextStyle(
                                      color: AbubaPallate.greenabuba,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  widget.alamatOutlet,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black54),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          ButtonTheme(
                            minWidth: 50.0,
                            height: 40.0,
                            child: RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0)),
                              child: Text(
                                'START',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.white),
                              ),
                              color: Colors.green,
                              onPressed: () {
                                DocumentReference docReference = Firestore
                                    .instance
                                    .collection('linecheck')
                                    .document();

                                docReference.setData(
                                  {
                                    'idUser': widget.idUser,
                                    'timeStart': checkinNow,
                                    'timeDone': null,
                                    'outlet': widget.outlet
                                  },
                                ).then(
                                  (doc) {
                                    Navigator.pushReplacement(
                                      context,
                                      MyCustomRoute(
                                        builder: (context) => FormLineCheck(
                                            idOutlet: widget.idOutlet,
                                            alamatOutlet: widget.alamatOutlet,
                                            outlet: widget.outlet,
                                            imageOutlet: widget.imageOutlet,
                                            idUser: widget.idUser,
                                            idMysteryGuest: maxid,
                                            index: docReference.documentID,),
                                      ),
                                    );
                                  },
                                ).catchError(
                                  (error) {
                                    print(error);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Image.network(
                  widget.imageOutlet,
                  fit: BoxFit.fitWidth,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
