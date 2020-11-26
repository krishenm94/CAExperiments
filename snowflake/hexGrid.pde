class HexGrid {
  Hexagon[][] cells;

  HexGrid(float radius) {
    int cols = int(width/(sqrt(3)*radius))+1;
    int rows = int(height/((radius*3)/2));
    print("Cols, Rows: " + cols + ", " + rows + "\n");
    cells = new Hexagon[cols][rows];

    int initX = int(radius); //<>//
    int initY = int(sqrt(3)*radius);

    for (int i = 0, x = initX, y = initY; 
      i < cols; 
      i++, x += (radius*3/2), y = i%2 ==1? int(radius*sqrt(3)/2):int(sqrt(3)*radius)) {
      for (int j = 0; j < rows; j++) {
        cells[i][j] = new Hexagon(x, y, radius);
        y += radius*sqrt(3);
      }
    }
  }

  void draw() {
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        cells[i][j].draw();
      } //<>//
    }
  }
}
