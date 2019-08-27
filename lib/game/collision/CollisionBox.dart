class   CollisionBox {
  final double x;
  final double y;
  final double width;
  final double height;
  const CollisionBox({
    this.x,
    this.y,
    this.width,
    this.height,
  });

  @override
  String toString() {
    return "{x: $x, y: $y, width: $width, height: $height}";
  }
}
