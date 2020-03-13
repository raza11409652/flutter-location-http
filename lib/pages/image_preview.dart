import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class ImagePreview extends StatelessWidget {
  final String image;

  const ImagePreview({Key key, @required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(image);
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Preview"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: PhotoView(imageProvider: 
        NetworkImage(image)
        ),
      )
    );
  }
}