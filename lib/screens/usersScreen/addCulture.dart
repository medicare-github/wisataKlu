import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newwisataklu/api/tourism_api.dart';
import 'package:newwisataklu/models/tourism.dart';
import 'package:newwisataklu/notifier/addCultureNotifier.dart';
import 'package:newwisataklu/notifier/authNotifier.dart';
import 'package:newwisataklu/screens/loadingScreen/loading.dart';
import 'package:newwisataklu/screens/loadingScreen/loadingLocatio.dart';
import 'package:newwisataklu/screens/upload/resultUpload.dart';
import 'package:provider/provider.dart';

class AddCulture extends StatefulWidget {
  final bool isUpdating;
  AddCulture({@required this.isUpdating});

  @override
  _AddCultureState createState() => _AddCultureState();
}

class _AddCultureState extends State<AddCulture> {
  // final bool isUpdating = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool mapToggle = false;
  var currentLocation;
  bool loading = false;

  Tourism _currentAddCulture;
  String _imageUrl;
  File _imageFile;
  String notif = '';

  String _subDistric;

  @override
  void initState() {
    super.initState();
    AddCultureNotifier addCultureNotifier =
        Provider.of<AddCultureNotifier>(context, listen: false);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    if (addCultureNotifier.currentAddCulture != null) {
      _currentAddCulture = addCultureNotifier.currentAddCulture;

    } else {
      Geolocator().getCurrentPosition().then((onValue) {
        setState(() {
          currentLocation = onValue;
          mapToggle = true;
        });
      });
      _currentAddCulture = Tourism();
    }

    _imageUrl = _currentAddCulture.image;
    _currentAddCulture.emailUser = authNotifier.user.email;
    _currentAddCulture.idUser = authNotifier.user.uid;
    _currentAddCulture.kind = 'culture';
    _currentAddCulture.status = 'not accepted';
  }



  List<String> subDistric = [
    "Pemenang",
    "Tanjung",
    "Gangga",
    "Kayangan",
    "Bayan"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: loading ? Loading() : mapToggle
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 6.0)
                            ],
                            image: DecorationImage(
                                image: AssetImage("assets/images/culture.jpg"),
                                fit: BoxFit.cover)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Submision Your Culture Tourism",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 20,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Add Culture Tourism",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 2.0),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    autovalidate: true,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: <Widget>[
                          _buildTourismNameField(),
                          _buildLatitudeField(),
                          _buildLongitudeField(),
                          _builSelecSubDistric(),
                          _buildVillageField(),
                          _bulidTicketField(),
                          _buildDescriptionField(),
                          _buildSelecImage(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 20),
                    child: RaisedButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _saveTourism();
                      },
                      highlightElevation: 0,
                      focusElevation: 0,
                      splashColor: Colors.white.withOpacity(0.1),
                      padding: EdgeInsets.fromLTRB(60, 17, 60, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Color.fromRGBO(1, 72, 164, 1),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(notif,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            )
          :LoadingLocation()
    );
  }

  _onTourismUploaded(Tourism tourism) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultUpload()),
    );
  }

  _saveTourism() async {
    print('saveTourism Called');
    setState(() {
      loading = true;
    });
    if (!_formKey.currentState.validate()) {
      setState(() {
        loading = false;
        notif = "Invalid input,please check your input";
        print("invalid input");
      });
    } else {
      _formKey.currentState.save();

      _currentAddCulture.lating =
          GeoPoint(_currentAddCulture.latitude, _currentAddCulture.longitude);

      print('form saved');

      await uploadTourismAndImage(_currentAddCulture, widget.isUpdating, _imageFile,
          _onTourismUploaded);

      setState(() {
        loading = false;
        notif = "Submision failed, Please Check your Input";
      });
    }
  }

  Widget _bulidTicketField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        // initialValue: _currentAddCulture.name,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 16, bottom: 16),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Icon(FontAwesomeIcons.coins),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            hintText: "Price Ticket (input 0 for free)",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue[300], width: 2)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 0, style: BorderStyle.none))),
        keyboardType: TextInputType.number,
        cursorColor: Colors.white,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Price Ticket is required or 0 for free';
          }

          if (value.length < 1 || value.length > 7) {
            return 'Price Ticket or 0 for free';
          }

          return null;
        },
        onSaved: (String value) {
          _currentAddCulture.ticket = int.parse(value);
        },
      ),
    );
  }

  Widget _buildTourismNameField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        // initialValue: _currentAddCulture.name,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 16, bottom: 16),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Icon(FontAwesomeIcons.pen),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            hintText: "Tourism name",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue[300], width: 2)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 0, style: BorderStyle.none))),
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        validator: (String value) {
          if (value.isEmpty) {
            return 'TourismName is required';
          }

          if (value.length < 4 || value.length > 25) {
            return 'TourismName must be betweem 4 and 25characters';
          }

          return null;
        },
        onSaved: (String value) {
          _currentAddCulture.name = value;
        },
      ),
    );
  }

  Widget _builSelecSubDistric() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: InputDecorator(
            decoration: InputDecoration(
                // errorText: _subDistric != null ? null : "Please select sub-distric",
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, style: BorderStyle.none))),
            isEmpty: false,
            child: DropdownButton(
              isDense: true,
              hint: new Text("Please select sub-distric"),
              value: _subDistric == null ? null : _subDistric,
              // value: _subDistric,
              items: subDistric.map((String value) {
                return DropdownMenuItem(
                  child: Text(
                    value,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  value: value,
                );
              }).toList(),
              isExpanded: true,
              onChanged: (String newValue) {
                setState(() {
                  _subDistric = newValue;
                  _currentAddCulture.subDistric = newValue;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVillageField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        // initialValue: _currentAddCulture.village,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 16, bottom: 16),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Icon(FontAwesomeIcons.home),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            hintText: "Village",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue[300], width: 2)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 0, style: BorderStyle.none))),
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Village is required';
          }

          if (value.length < 4 || value.length > 25) {
            return 'Village must be betweem 4 and 25characters';
          }

          return null;
        },
        onSaved: (String value) {
          _currentAddCulture.village = value;
        },
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        // initialValue: _currentAddCulture.description,
        maxLines: 3,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 16, bottom: 16),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Icon(FontAwesomeIcons.textHeight),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.7),
            hintText: "Description",
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue[300], width: 2)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 0, style: BorderStyle.none))),
        keyboardType: TextInputType.text,
        cursorColor: Colors.white,
        onSaved: (String value) {
          _currentAddCulture.description = value;
        },
      ),
    );
  }

  Widget _buildSelecImage() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Select Picture of Tourism",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  RaisedButton(
                    onPressed: () => _getLocalImage(),
                    child: Icon(Icons.add_photo_alternate),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  )
                ],
              ),
            ),
          ),
        ),
        _decideImageView()
      ],
    );
  }

  _getLocalImage() async {
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);
    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  _decideImageView() {
    if (_imageFile == null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(child: Text("Please select image")),
          ),
        ),
      );
    } else if (_imageFile != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(child: Image.file(_imageFile)),
          ),
        ),
      );
    }

    //  else {
    //   return Image.file(
    //     _imageFile,
    //   );
    // }
  }

  Widget _buildLongitudeField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: currentLocation.longitude.toString(),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 16, bottom: 16),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Icon(Icons.pin_drop),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.7),
                hintText: "Longitude point",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue[300], width: 2)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none))),
            keyboardType: TextInputType.numberWithOptions(),
            cursorColor: Colors.white,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Longitude point is required';
              }

              if (value.length < 4 || value.length > 25) {
                return 'Longitude point must be betweem 4 and 25characters';
              }

              return null;
            },
            onSaved: (String value) {
              _currentAddCulture.longitude = double.parse(value);
            },
          ),
          mapToggle
              ? Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Your longitude point now",
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                )
              : "",
        ],
      ),
    );
  }

  Widget _buildLatitudeField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: currentLocation.latitude.toString(),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 16, bottom: 16),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Icon(Icons.pin_drop),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.7),
                hintText: "Latitude point",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue[300], width: 2)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none))),
            keyboardType: TextInputType.numberWithOptions(),
            cursorColor: Colors.white,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Latitude point is required';
              }

              if (value.length < 4 || value.length > 25) {
                return 'Latitude point must be betweem 4 and 25characters';
              }

              return null;
            },
            onSaved: (String value) {
              _currentAddCulture.latitude = double.parse(value);
            },
          ),
          mapToggle
              ? Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Your latitude point now",
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                )
              : "",
        ],
      ),
    );
  }
}
