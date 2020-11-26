HexGrid GRID;

void setup() {
  size(800, 800);
  background(255);

  stroke(0);
  fill(255, 0, 0);

  GRID = new HexGrid(10);
}

void draw() {
  background(255);

  GRID.draw();
}
