import java.util.*;

class Grid {
  Cell[][] m_cells;
  Cell[][] m_nextCells;
  float m_cellSize;
  int m_threshold;
  Random random = new Random();

  Grid(float cellSize, int threshold) {
    m_cellSize = cellSize;
    m_threshold = threshold;

    int cols = int(width/cellSize);
    int rows = int(height/cellSize);

    m_cells = initCells(cols, rows);
    m_nextCells = initCells(cols, rows);
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
        nextCell.copy(cell); 
      }
    }
    
    Cell[][] temp = m_cells;
    m_cells = m_nextCells;
    m_nextCells = temp;
  }
}
