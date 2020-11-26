class HexGrid { //<>//
  Hexagon[][] cells;
  Hexagon[][] nextCells;

  HexGrid(float radius) {
    int cols = int(width/((radius*3)/2));
    int rows = int(height/(sqrt(3)*radius))+1;

    print("Cols, Rows: " + cols + ", " + rows + "\n");

    cells = makeGrid(cols, rows, radius);
    nextCells = makeGrid(cols, rows, radius);
  }

  Hexagon[][] makeGrid(int cols, int rows, float radius) {
    Hexagon[][] grid = new Hexagon[cols][rows];

    int initX = int(radius);
    int initY = int(sqrt(3)*radius);

    for (int i = 0, x = initX, y = initY; 
      i < cols; 
      i++, x += (radius*3/2), y = i%2 ==1? int(radius*sqrt(3)/2):int(sqrt(3)*radius)) {
      for (int j = 0; j < rows; j++) {
        grid[i][j] = new Hexagon(x, y, radius);
        y += radius*sqrt(3);
      } //<>//
    }

    grid[cols/2 - 1][rows/2 - 1].state = true;

    return grid;
  }

  void draw() {
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        cells[i][j].draw();

        if (countNeighbours(i, j) == 1) {
          nextCells[i][j].state = true;
        }
      }
    }

    Hexagon[][] temp = cells;
    cells = nextCells;
    nextCells = temp;
  }

  int countNeighbours(int col, int row) {
    int sum = 0;
    for (int i = -1; i < 2; i++) {
      int x = (col + i + cells.length) % cells.length;
      int offset = (x%2) == 1 ? 1 : 0;

      if ( i == 0) {
        for (int j = -1; j < 2; j++) {
          int y = (row + j + cells[x].length) % cells[x].length;
          sum += cells[x][y].state? 1 : 0;
        }
      } else {
        for (int j = -1 + offset; j < 1 + offset; j++) {

          int y = (row + j + cells[x].length) % cells[x].length;
          sum += cells[x][y].state? 1 : 0;
        }
      }
    }

    return sum - (cells[col][row].state? 1:0);
  }
}
