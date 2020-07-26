// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:newwisataklu/api/tourism_api.dart';
// import 'package:newwisataklu/models/tourism.dart';
// import 'package:newwisataklu/notifier/tourismNotifier.dart';
// import 'package:newwisataklu/screens/feedScreen.dart';
// import 'package:provider/provider.dart';

// class AddTourism extends StatefulWidget {
//   final bool isUpdating;
//   AddTourism({@required this.isUpdating});

//   @override
//   _AddTourismState createState() => _AddTourismState();
// }

// class _AddTourismState extends State<AddTourism> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   Tourism _currentTourism;
//   String _imageUrl;
//   File _imageFile;

//   TextEditingController subLocController = new TextEditingController();

//   String _subDistric, subkind;
//   List<String> subDistric = [
//     "Pemenang",
//     "Tanjung",
//     "Gangga",
//     "Kayangan",
//     "Bayan"
//   ];

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   TourismNotifier tourismNotifier =
//   //       Provider.of<TourismNotifier>(context, listen: false);

//   //   if (tourismNotifier.currentTourism != null) {
//   //     _currentTourism = tourismNotifier.currentTourism;
//   //   } else {
//   //     _currentTourism = Tourism();
//   //   }

//   //   _imageUrl = _currentTourism.image;
//   // }

//   Widget _buildTourismNameField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: TextFormField(
//         // initialValue: _currentTourism.name,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(top: 16, bottom: 16),
//             prefixIcon: Padding(
//               padding: const EdgeInsets.only(left: 18, right: 18),
//               child: Icon(FontAwesomeIcons.pen),
//             ),
//             filled: true,
//             fillColor: Colors.white.withOpacity(0.7),
//             hintText: "Tourism name",
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: Colors.blue[300], width: 2)),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(width: 0, style: BorderStyle.none))),
//         keyboardType: TextInputType.text,
//         cursorColor: Colors.white,
//         validator: (String value) {
//           if (value.isEmpty) {
//             return 'TourismName is required';
//           }

//           if (value.length < 4 || value.length > 25) {
//             return 'TourismName must be betweem 4 and 25characters';
//           }

//           return null;
//         },
//         onSaved: (String value) {
//           _currentTourism.name = value;
//         },
//       ),
//     );
//   }

//   Widget _builSelecKind() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.7),
//             borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10),
//           child: InputDecorator(
//             decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(width: 0, style: BorderStyle.none))),
//             isEmpty: false,
//             child: DropdownButton(
//               isDense: true,
//               hint: new Text("Please select Type of tourism"),
//               value: subkind == null ? null : subkind,
//               // value: _subDistric,
//               items: ["natural", "culture","culinary"].map((String value) {
//                 return DropdownMenuItem(
//                   child: Text(
//                     value,
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black),
//                   ),
//                   value: value,
//                 );
//               }).toList(),
//               isExpanded: true,
//               onChanged: (String newValue) {
//                 setState(() {
//                   subkind = newValue;
//                   // _currentTourism.kind = newValue;
//                 });
//               },
//             ),
//           ),
          
//         ),
//       ),
//     );
//   }

//   Widget _builSelecSubDistric() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.7),
//             borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10),
//           child: InputDecorator(
//             decoration: InputDecoration(
//                 // errorText: _subDistric != null ? null : "Please select sub-distric",
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(width: 0, style: BorderStyle.none))),
//             isEmpty: false,
//             child: DropdownButton(
//               isDense: true,
//               hint: new Text("Please select sub-distric"),
//               value: _subDistric == null ? null : _subDistric,
//               // value: _subDistric,
//               items: subDistric.map((String value) {
//                 return DropdownMenuItem(
//                   child: Text(
//                     value,
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black),
//                   ),
//                   value: value,
//                 );
//               }).toList(),
//               isExpanded: true,
//               onChanged: (String newValue) {
//                 setState(() {
//                   _subDistric = newValue;
//                   // _currentTourism.subDistric = newValue;
//                 });
//               },
//             ),
//           ),
//           // child: DropDownFormField(
//           //   hintText: 'Please choose Subdistric',
//           //   titleText: 'Sub-Distric',
//           //   value: _myActivity,
//           //   validator: (value) => value == null ? 'please Select one option' : null,
//           //   onSaved: (value) {
//           //     setState(() {
//           //       _currentTourism.subDistric = value;
//           //     });
//           //   },
//           //   onChanged: (value) {
//           //     setState(() {
//           //       _myActivity = value;
//           //     });
//           //   },
//           //   dataSource: [
//           //     {"display": "Bayan", "value": "Bayan"},
//           //     {"display": "Kayangan", "value": "Kayangan"},
//           //     {"display": "Pemenang", "value": "Pemenang"},
//           //     {"display": "Gangga", "value": "Gangga"},
//           //     {"display": "Tanjung", "value": "Tanjung"},
//           //   ],
//           //   textField: 'display',
//           //   valueField: 'value',
//           // ),
//         ),
//       ),
//     );
//   }

//   Widget _buildVillageField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: TextFormField(
//         // initialValue: _currentTourism.village,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(top: 16, bottom: 16),
//             prefixIcon: Padding(
//               padding: const EdgeInsets.only(left: 18, right: 18),
//               child: Icon(FontAwesomeIcons.home),
//             ),
//             filled: true,
//             fillColor: Colors.white.withOpacity(0.7),
//             hintText: "Village",
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: Colors.blue[300], width: 2)),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(width: 0, style: BorderStyle.none))),
//         keyboardType: TextInputType.text,
//         cursorColor: Colors.white,
//         validator: (String value) {
//           if (value.isEmpty) {
//             return 'Village is required';
//           }

//           if (value.length < 4 || value.length > 25) {
//             return 'Village must be betweem 4 and 25characters';
//           }

//           return null;
//         },
//         onSaved: (String value) {
//           _currentTourism.village = value;
//         },
//       ),
//     );
//   }

//   Widget _buildLongitudeField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: TextFormField(
//         // initialValue: _currentTourism.longitude,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(top: 16, bottom: 16),
//             prefixIcon: Padding(
//               padding: const EdgeInsets.only(left: 18, right: 18),
//               child: Icon(Icons.pin_drop),
//             ),
//             filled: true,
//             fillColor: Colors.white.withOpacity(0.7),
//             hintText: "Longitude point",
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: Colors.blue[300], width: 2)),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(width: 0, style: BorderStyle.none))),
//         keyboardType: TextInputType.text,
//         cursorColor: Colors.white,
//         validator: (String value) {
//           if (value.isEmpty) {
//             return 'Longitude point is required';
//           }

//           if (value.length < 4 || value.length > 25) {
//             return 'Longitude point must be betweem 4 and 25characters';
//           }

//           return null;
//         },
//         onSaved: (String value) {
//           _currentTourism.longitude = double.parse(value);
//         },
//       ),
//     );
//   }

//   Widget _buildLatitudeField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: TextFormField(
//         // initialValue: _currentTourism.latitude,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(top: 16, bottom: 16),
//             prefixIcon: Padding(
//               padding: const EdgeInsets.only(left: 18, right: 18),
//               child: Icon(Icons.pin_drop),
//             ),
//             filled: true,
//             fillColor: Colors.white.withOpacity(0.7),
//             hintText: "Latitude point",
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: Colors.blue[300], width: 2)),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(width: 0, style: BorderStyle.none))),
//         keyboardType: TextInputType.text,
//         cursorColor: Colors.white,
//         validator: (String value) {
//           if (value.isEmpty) {
//             return 'Latitude point is required';
//           }

//           if (value.length < 4 || value.length > 25) {
//             return 'Latitude point must be betweem 4 and 25characters';
//           }

//           return null;
//         },
//         onSaved: (String value) {
//           _currentTourism.latitude = double.parse(value);
//         },
//       ),
//     );
//   }

//   Widget _buildDescriptionField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: TextFormField(
//         // initialValue: _currentTourism.description,
//         maxLines: 3,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(top: 16, bottom: 16),
//             prefixIcon: Padding(
//               padding: const EdgeInsets.only(left: 18, right: 18),
//               child: Icon(FontAwesomeIcons.textHeight),
//             ),
//             filled: true,
//             fillColor: Colors.white.withOpacity(0.7),
//             hintText: "Description",
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: Colors.blue[300], width: 2)),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(width: 0, style: BorderStyle.none))),
//         keyboardType: TextInputType.text,
//         cursorColor: Colors.white,
//         onSaved: (String value) {
//           _currentTourism.description = value;
//         },
//       ),
//     );
//   }

//   Widget _buildSelecImage() {
//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.only(bottom: 10),
//           child: Container(
//             decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.7),
//                 borderRadius: BorderRadius.circular(10)),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     "Select Picture of Tourism",
//                     style: TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                   RaisedButton(
//                     onPressed: () => _getLocalImage(),
//                     child: Icon(Icons.add_photo_alternate),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5)),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 10),
//           child: Container(
//             width: 200,
//             height: 100,
//             decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.7),
//                 borderRadius: BorderRadius.circular(10)),
//             child: Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Center(child: _decideImageView()),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   _onTourismUploaded(Tourism tourism) {
//     TourismNotifier tourismNotifier =
//         Provider.of<TourismNotifier>(context, listen: false);
//     tourismNotifier.addTourism(tourism);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => FeedScreen()),
//     );
//   }

//   _saveTourism() {
//     print('saveTourism Called');
//     if (!_formKey.currentState.validate()) {
//       return;
//     }

//     _formKey.currentState.save();

//     print('form saved');

//     // uploadTourismAndImage(
//     // _currentTourism, widget.isUpdating, _imageFile, _onTourismUploaded);

//     if (uploadTourismAndImage(
//         _currentTourism, widget.isUpdating, _imageFile, _onTourismUploaded)) {
//       print('success add');
//     } else {
//       print('not success add');
//     }
//     print("name: ${_currentTourism.name}");
//     print("country: ${_currentTourism.country}");
//     print("subditric: ${_currentTourism.subDistric}");
//     print("status: ${_currentTourism.status}");
//     print("village: ${_currentTourism.village}");
//     print("latitude: ${_currentTourism.latitude}");
//     print("longitude: ${_currentTourism.longitude}");
//     print("description: ${_currentTourism.description}");
//     // print("subLoc: ${_currentTourism.subLoc}");
//     print("imageFile: ${_imageFile.toString()}");
//     print("imageUrl: $_imageUrl");
//   }

//   Widget _decideImageView() {
//     if (_imageFile == null && _imageUrl == null) {
//       return Text("No Selected");
//     } else {
//       return Image.file(
//         _imageFile,
//       );
//     }
//   }

//   _getLocalImage() async {
//     File imageFile = await ImagePicker.pickImage(
//         source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);
//     if (imageFile != null) {
//       setState(() {
//         _imageFile = imageFile;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             height: size.height * .10,
//             decoration: BoxDecoration(color: Colors.grey[200]),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Icon(Icons.add),
//                       Text('Submision',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w600, fontSize: 14)),
//                     ],
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(Icons.share),
//                   )
//                   // CircleAvatar(
//                   //   radius: 15.0,
//                   //   backgroundImage: NetworkImage(widget.photoUrl),
//                   // )
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             child: Column(
//               children: <Widget>[
//                 Text(
//                   'Submision',
//                   style: TextStyle(
//                       fontFamily: 'OpenSans',
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'submision your tourism sites',
//                   style: TextStyle(
//                       fontFamily: 'OpenSans',
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400),
//                 ),
//                 Form(
//                   key: _formKey,
//                   autovalidate: true,
//                   child: Container(
//                     padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
//                     child: Column(
//                       children: <Widget>[
//                         _buildTourismNameField(),
//                         _builSelecKind(),
//                         _builSelecSubDistric(),
//                         _buildVillageField(),
//                         _buildLongitudeField(),
//                         _buildLatitudeField(),
//                         _buildDescriptionField(),
//                         _buildSelecImage(),
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 10, top: 20),
//                           child: RaisedButton(
//                             onPressed: () {
//                               FocusScope.of(context)
//                                   .requestFocus(new FocusNode());
//                               _saveTourism();
//                             },
//                             highlightElevation: 0,
//                             focusElevation: 0,
//                             splashColor: Colors.white.withOpacity(0.1),
//                             padding: EdgeInsets.fromLTRB(60, 17, 60, 16),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30)),
//                             color: Color.fromRGBO(1, 72, 164, 1),
//                             child: Text(
//                               'Submit',
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
