import 'package:flutter/material.dart';
import 'package:material_new_shapes/material_new_shapes.dart';

class MaterialPolygonBorder extends ShapeBorder {
  final RoundedPolygon polygon;

  const MaterialPolygonBorder({required this.polygon});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // Transform the normalized polygon to fit the rect
    final matrix = Matrix4.translationValues(rect.left, rect.top, 0)
      ..multiply(Matrix4.diagonal3Values(rect.width, rect.height, 1.0));

    return polygon.transformed(matrix.asPointTransformer()).toPath();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return this;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MaterialPolygonBorder) return false;
    return other.polygon == polygon;
  }

  @override
  int get hashCode => polygon.hashCode;
}
