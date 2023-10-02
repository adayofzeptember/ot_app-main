import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class HeroPhotoViewRouteWrapper extends StatelessWidget {
  HeroPhotoViewRouteWrapper({
    super.key,
    required this.imageProvider,
    required this.index,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  String index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          imageProvider: imageProvider,
          backgroundDecoration: backgroundDecoration,
          minScale: minScale,
          maxScale: maxScale,
          heroAttributes: PhotoViewHeroAttributes(tag: "sometag$index"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(120, 0, 0, 0),
        elevation: 1,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.close,
          size: 33,
          color: Colors.white,
        ),
      ),
    );
  }
}
