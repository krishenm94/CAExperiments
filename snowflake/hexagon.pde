class Hexagon {
  PVector center;
  float radius;
  boolean state = false;

  Hexagon(float x, float y, float size) {
    center = new PVector(x, y);
    radius = size;
  }

  void draw() {
    beginShape();
      for (float i = 0; i < TWO_PI; i += TWO_PI/6) {
      float x = center.x + cos(i) * radius;
      float y = center.y + sin(i) * radius;
      vertex(x, y);
    }
    endShape(CLOSE);
  }
}
