import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

Future<Uint8List> createCustomMarkerWithText(
    String rating, String imagePath) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  const double size = 150.0;

  final Paint paint = Paint()..color = Colors.transparent;
  canvas.drawCircle(const Offset(size / 2, size / 2), size / 2, paint);

  final image = await rootBundle.load(imagePath);
  final ui.Codec codec = await ui.instantiateImageCodec(
    image.buffer.asUint8List(),
    targetWidth: 100,
    targetHeight: 100,
  );
  final ui.FrameInfo frameInfo = await codec.getNextFrame();
  canvas.drawImage(frameInfo.image, const Offset(25, 25), Paint());

  final TextPainter textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );
  textPainter.text = TextSpan(
    text: rating,
    style: const TextStyle(
      fontSize: 30.0, 
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
  textPainter.layout();

  final double xCenter = (size - textPainter.width) / 2;
  final double yCenter = (size - textPainter.height) / 2;
  textPainter.paint(canvas, Offset(xCenter, yCenter));

  final ui.Image markerAsImage =
      await pictureRecorder.endRecording().toImage(size.toInt(), size.toInt());
  final ByteData? byteData =
      await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
