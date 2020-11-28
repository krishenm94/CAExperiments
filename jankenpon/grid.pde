import java.util.*;

class Grid {
  Cell[][] m_cells;
  Cell[][] m_nextCells;
  float m_cellSize;
  int m_threshold;

  int m_cols;
  int m_rows;

  Random random = new Random();

  Grid(float cellSize, int threshold) {
    m_cellSize = cellSize;
    m_threshold = threshold;

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

        Cell nextCell = m_nextCells[col][row];

        updateCell(cell, col, row);
        nextCell.copy(cell);
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

  void updateCell(Cell cell, int col, int row) {
    if (cell.m_colour == 255) {
      return;
    }

    Cell neighbour = getRandomNeighbour(col, row);

    if (neighbour.m_colour == 255 && cell.m_level < m_threshold) {
      neighbour.grow(cell);
    }
  }
}
