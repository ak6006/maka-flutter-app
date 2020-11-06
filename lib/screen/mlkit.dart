// import 'dart:io';

// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class TextrecognetionScreen extends StatefulWidget {
//   @override
//   _TextrecognetionScreenState createState() => _TextrecognetionScreenState();
// }

// class _TextrecognetionScreenState extends State<TextrecognetionScreen> {
//   File imageFile;
//   var isLoading = false;
//   var result = 'Result In Here';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Flutter ML Kit Text'),
//       // ),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         width: double.infinity,
//         child: Column(
//           children: [
//             Expanded(
//               flex: 1,
//               child: imageFile == null
//                   ? Container()
//                   : Image.file(
//                       imageFile,
//                       fit: BoxFit.cover,
//                     ),
//             ),
//             Expanded(
//               child: Center(
//                 child: isLoading ? _buildWidgetLoading() : Text(result),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.camera_alt),
//         onPressed: () async {
//           var pickedFile =
//               await ImagePicker().getImage(source: ImageSource.camera);
//           if (pickedFile != null) {
//             setState(() {
//               isLoading = true;
//             });
//             imageFile = File(pickedFile.path);
//             var firebaseVisionImage = FirebaseVisionImage.fromFile(imageFile);
//             var textRecognizer = FirebaseVision.instance.textRecognizer();
//             var visionText =
//                 await textRecognizer.processImage(firebaseVisionImage);
//             result = '${visionText.text}';
//             debugPrint('result: $result');
//             textRecognizer.close();
//             setState(() {
//               isLoading = false;
//             });
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildWidgetLoading() {
//     return Platform.isIOS
//         ? CupertinoActivityIndicator()
//         : CircularProgressIndicator();
//   }
// }
