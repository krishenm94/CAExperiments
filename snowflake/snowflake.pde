HexGrid GRID;

void setup() {
  size(800, 800);
  background(255);

  stroke(0);
  //frameRate(10);

  GRID = new HexGrid(4);
}

void draw() {
  background(255);

  GRID.draw();
}
