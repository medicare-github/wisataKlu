// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:newwisataklu/api/tourism_api.dart';
// import 'package:newwisataklu/models/tourism.dart';
// import 'package:newwisataklu/notifier/tourismNotifier.dart';
// import 'package:provider/provider.dart';

// class TourismForm extends StatefulWidget {
//   final bool isUpdating;
//   TourismForm({@required this.isUpdating});

//   @override
//   _TourismFormState createState() => _TourismFormState();
// }

// class _TourismFormState extends State<TourismForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   List _subloc = [];
//   Tourism _currentTourism;
//   String _imageUrl;
//   File _imageFile;
//   TextEditingController subLocController = new TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     TourismNotifier tourismNotifier =
//         Provider.of<TourismNotifier>(context, listen: false);

//     if (tourismNotifier.currentTourism != null) {
//       _currentTourism = tourismNotifier.currentTourism;
//     } else {
//       _currentTourism = Tourism();
//     }

//     _subloc.addAll(_currentTourism.subLoc);
//     _imageUrl = _currentTourism.image;
//   }

//   _showImage() {
//     // return Text("Image here");
//     if (_imageFile == null && _imageUrl == null) {
//       return Text("image placeholder");
//     } else if (_imageFile != null) {
//       print('showing image from local file');

//       return Stack(
//         alignment: AlignmentDirectional.bottomCenter,
//         children: <Widget>[
//           Image.file(
//             _imageFile,
//             fit: BoxFit.cover,
//             height: 250,
//           ),
//           FlatButton(
//             padding: EdgeInsets.all(16),
//             color: Colors.black54,
//             child: Text(
//               'Change Image',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w400),
//             ),
//             onPressed: () => _getLocalImage(),
//           )
//         ],
//       );
//     } else if (_imageUrl != null) {
//       print('showing image from url');

//       return Stack(
//         alignment: AlignmentDirectional.bottomCenter,
//         children: <Widget>[
//           Image.network(
//             _imageUrl,
//             width: MediaQuery.of(context).size.width,
//             fit: BoxFit.cover,
//             height: 250,
//           ),
//           FlatButton(
//             padding: EdgeInsets.all(16),
//             color: Colors.black54,
//             child: Text(
//               'Change Image',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w400),
//             ),
//             onPressed: () => _getLocalImage(),
//           )
//         ],
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

//   Widget _buildNameField() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'Name'),
//       initialValue: _currentTourism.name,
//       keyboardType: TextInputType.text,
//       style: TextStyle(fontSize: 20),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Name is required';
//         }

//         if (value.length < 3 || value.length > 20) {
//           return 'Name must be more than 3 and less than 20';
//         }

//         return null;
//       },
//       onSaved: (String value) {
//         _currentTourism.name = value;
//       },
//     );
//   }

//   Widget _buildCountryField() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'Country'),
//       initialValue: _currentTourism.country,
//       keyboardType: TextInputType.text,
//       style: TextStyle(fontSize: 20),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'country is required';
//         }

//         if (value.length < 3 || value.length > 20) {
//           return 'country must be more than 3 and less than 20';
//         }

//         return null;
//       },
//       onSaved: (String value) {
//         _currentTourism.country = value;
//       },
//     );
//   }

//   _buildSubLocField() {
//     return SizedBox(
//       width: 200,
//       child: TextField(
//         controller: subLocController,
//         keyboardType: TextInputType.text,
//         decoration: InputDecoration(labelText: 'Subloc'),
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }

//   _onTourismUploaded(Tourism tourism) {
//     TourismNotifier tourismNotifier =
//         Provider.of<TourismNotifier>(context, listen: false);
//     tourismNotifier.addTourism(tourism);
//     Navigator.pop(context);
//   }

//   _addSubLoc(String text) {
//     if (text.isNotEmpty) {
//       setState(() {
//         _subloc.add(text);
//       });
//       subLocController.clear();
//     }
//   }

//   _saveTourism() {
//     print('saveTourism Called');
//     if (!_formKey.currentState.validate()) {
//       return;
//     }

//     _formKey.currentState.save();

//     print('form saved');

//     _currentTourism.subLoc = _subloc;

//     uploadTourismAndImage(
//         _currentTourism, widget.isUpdating, _imageFile, _onTourismUploaded);

    

//     print("name: ${_currentTourism.name}");
//     print("country: ${_currentTourism.country}");
//     print("subLoc: ${_currentTourism.subLoc}");
//     print("imageFile: ${_imageFile.toString()}");
//     print("imageUrl: $_imageUrl");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         actions: <Widget>[Icon(Icons.share)],
//         title: Text('Tourism Form'),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           autovalidate: true,
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//               child: Column(
//                 children: <Widget>[
//                   _showImage(),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     widget.isUpdating ? "Edit Tourism" : "Create Tourism",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   _imageUrl == null && _imageFile == null
//                       ? ButtonTheme(
//                           child: RaisedButton(
//                             onPressed: () => _getLocalImage(),
//                             child: Text(
//                               "add image",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         )
//                       : SizedBox(
//                           height: 20,
//                         ),
//                   _buildNameField(),
//                   _buildCountryField(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       _buildSubLocField(),
//                       ButtonTheme(
//                         child: RaisedButton(
//                           child: Text('Add',
//                               style: TextStyle(color: Colors.white)),
//                           onPressed: () => _addSubLoc(subLocController.text),
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   GridView.count(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     padding: EdgeInsets.all(8),
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 4,
//                     mainAxisSpacing: 4,
//                     children: _subloc
//                         .map((subLoc) => Card(
//                               color: Colors.black,
//                               child: Center(
//                                 child: Text(
//                                   subLoc,
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 16),
//                                 ),
//                               ),
//                             ))
//                         .toList(),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           FocusScope.of(context).requestFocus(new FocusNode());
//           _saveTourism();
//         },
//         // onPressed: () => _saveTourism(context),
//         child: Icon(Icons.save),
//         foregroundColor: Colors.white,
//       ),
//     );
//   }
// }
