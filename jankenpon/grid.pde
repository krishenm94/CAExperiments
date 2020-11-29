import java.util.*; //<>//

class Grid {
  Cell[][] m_cells;
  Cell[][] m_nextCells;
  float m_cellSize;
  int m_growthThreshold;
  int m_predationThreshold;

  int m_cols;
  int m_rows;

  Random random = new Random();

  Grid(float cellSize, int threshold, int predationThreshold) {
    m_cellSize = cellSize;
    m_growthThreshold = threshold;
    m_predationThreshold = predationThreshold;

    m_cols = int(width/cellSize);
    m_rows = int(height/cellSize);

    m_cells = initCells(m_cols, m_rows);
    m_nextCells = initCells(m_cols, m_rows);
  }

  Cell[][] initCells(int cols, int rows) {
    Cell[][] grid = new Cell[cols][rows];

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        grid[col][row] = new Cell(col, row, m_cellSize);
      }
    }

    return grid;
  }

  void draw() {
    for (int col = 0; col < m_cells.length; col++) {
      for (int row = 0; row < m_cells[col].length; row++) {
        Cell cell = m_cells[col][row];
        cell.draw();

        if (cell.m_dontUpdate == true) {
          cell.m_dontUpdate = false;
          continue;
        }

        updateCell(col, row);
      }
    }

    Cell[][] temp = m_cells;
    m_cells = m_nextCells;
    m_nextCells = temp;
  }

  Cell getRandomNeighbour(int col, int row) {
    int xOffset = 0;
    int yOffset = 0;

    while (xOffset == 0 && yOffset == 0)
    {
      xOffset = random.nextInt(3) - 1;
      yOffset = random.nextInt(3) - 1;
    }

    col = (col + xOffset + m_cols)%m_cols;
    row = (row + yOffset + m_rows)%m_rows;
    return m_cells[col][row];
  }

  Cell getRandomNeighbourNoWrap(int col, int row) {
    int xOffset = 0;
    int yOffset = 0;

    while (xOffset == 0 && yOffset == 0)
    {
      xOffset = random.nextInt(3) - 1;
      yOffset = random.nextInt(3) - 1;
    }

    col = clampTo(width, col + xOffset);
    row = clampTo(height, row + yOffset);
    return m_cells[col][row];
  }

  int clampTo(int limit, int x) {
    if (x >= limit / m_cellSize) {
      return int(limit / m_cellSize) - 1;
    }

    if (x < 0) {
      return 0;
    }

    return x;
  }

  void updateCell(int col, int row) {
    Cell cell = m_cells[col][row];

    if (cell.m_colour == 255) {
      return;
    }

    Cell nextCell = m_nextCells[col][row];
    Cell neighbour = getRandomNeighbour(col, row);

    if (neighbour.m_colour == 255 && cell.m_level < m_growthThreshold && cell.m_colour != 255) {
      
      int neighbourCol = int(neighbour.m_position.x / m_cellSize);
      int neighbourRow = int(neighbour.m_position.y / m_cellSize);
      m_nextCells[neighbourCol][neighbourRow].grow(cell);
      
    } else if (neighbour.m_colour == RED && cell.m_colour == GREEN ||
      neighbour.m_colour == GREEN && cell.m_colour == BLUE ||
      neighbour.m_colour == BLUE && cell.m_colour == RED ) {
      neighbour.eat(nextCell);
      return;
    }

    // Sync grids
    nextCell.copy(cell);
  }

  void updateCell2(int col, int row) {
    Cell cell = m_cells[col][row];

    if (cell.m_colour == 255) {
      return;
    }

    Cell nextCell = m_nextCells[col][row];
    Cell neighbour = getRandomNeighbour(col, row);
    if (neighbour.m_colour == 255 && cell.m_level < m_growthThreshold) {

      int neighbourCol = int(neighbour.m_position.x / m_cellSize);
      int neighbourRow = int(neighbour.m_position.y / m_cellSize);
      m_nextCells[neighbourCol][neighbourRow].grow(cell);

      // Sync grids
      nextCell.copy(cell);

      return;
    } 

    int neighbourPredatorCount = getNeighbourhoodPredatorCount(cell, col, row);

    //if (neighbourPredatorCount < m_predationThreshold + (random.nextInt(2))) {
      if (neighbourPredatorCount < m_predationThreshold) {
      nextCell.copy(cell);
      return;
    }

    nextCell.m_colour = getPredatorColour(cell);
    nextCell.m_level = 0;
    nextCell.m_dontUpdate = false;
  }

  int getNeighbourhoodPredatorCount(Cell cell, int col, int row) {
    int sum = 0;
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j<2; j++) {
        int x = (col + i + m_cols) % m_cols;
        int y = (row + j + m_rows) % m_rows;
        if (m_cells[x][y].m_colour == getPredatorColour(cell)) {
          sum++;
        }
      }
    }

    return sum;
  }

  int getNeighbourhoodPredatorCountNoWrap(Cell cell, int col, int row) {
    int sum = 0;
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j<2; j++) {
        int x = (col + i);
        int y = (row + j);

        if ( x < 0 || y < 0 || x  >= int(width/m_cellSize) || y >= int(height/m_cellSize))
        {
          continue;
        }
        if (m_cells[x][y].m_colour == getPredatorColour(cell)) {
          sum++;
        }
      }
    }

    return sum;
  }

  color getPredatorColour(Cell cell) {
    if (cell.m_colour == RED) {
      return BLUE;
    }
    if (cell.m_colour == GREEN) {
      return RED;
    }
    if (cell.m_colour == BLUE) {
      return GREEN;
    }

    return 0;
  }

  void updateCell3(Cell cell, int col, int row) {
    if (cell.m_colour == 255) {
      return;
    }

    Cell neighbour = getRandomNeighbourNoWrap(col, row);

    if (neighbour.m_colour == 255 && cell.m_level < m_growthThreshold) {
      neighbour.grow(cell);
    } else if (cell.m_colour == RED && neighbour.m_colour == GREEN ||
      cell.m_colour == GREEN && neighbour.m_colour == BLUE ||
      cell.m_colour == BLUE && neighbour.m_colour == RED ) {
      cell.eat(neighbour);
    }

    // Sync grids
    int neighbourCol = int(neighbour.m_position.x / m_cellSize);
    int neighbourRow = int(neighbour.m_position.y / m_cellSize);
    m_nextCells[neighbourCol][neighbourRow].copy(neighbour);
  }
}
