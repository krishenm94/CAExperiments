import java.util.*;

int CELL_SIZE = 2;

Boolean[][] GRID;
Boolean[][] NEXT_GRID;
int COLS;
int ROWS;

Random RANDOM = new Random();

Boolean[][] makeGrid(int cols, int rows)
{
  Boolean[][] grid = new Boolean[cols][rows];
  for (int col = 0; col < cols; col++)
  {
    Boolean[] colOfCells =  new Boolean[rows];
    for (int row = 0; row < rows; row++)  
    {
      colOfCells[row] = RANDOM.nextBoolean() && RANDOM.nextBoolean();
    }
    grid[col] = colOfCells;
  }

  return grid;
}

void setup()
{
  size(1600, 1000);
  background(255);
  smooth();
  //frameRate(10);
  COLS = width/ CELL_SIZE;
  ROWS = height / CELL_SIZE;

  GRID = makeGrid(COLS, ROWS);
  NEXT_GRID = makeGrid(COLS, ROWS);
}

void draw()
{
  background(255);
  fill(0);

  for (int col = 0; col < COLS; col++)
  {
    for (int row = 0; row < ROWS; row++)  
    {
      if (GRID[col][row] == true)
      {
        square(col * CELL_SIZE, row * CELL_SIZE, CELL_SIZE);
      }

      int neighbours = countNeighbours(row, col);
      if (neighbours < 2 || neighbours > 3)
      {
        NEXT_GRID[col][row] = false;
      } else if (neighbours == 3)
      {
        NEXT_GRID[col][row] = true;
      } else
      {
        NEXT_GRID[col][row] = GRID[col][row];
      }
    }
  }

  Boolean[][] temp = GRID;
  GRID = NEXT_GRID;
  NEXT_GRID = temp;
}

int countNeighbours(int row, int col)
{
  int sum = 0;
  for (int i = -1; i < 2; i++) {
    for (int j = -1; j < 2; j++) {
      int x = (col + i + COLS) % COLS;
      int y = (row + j + ROWS) % ROWS;
      sum += GRID[x][y]? 1 : 0;
    }
  }
  sum -= GRID[col][row] ? 1 : 0;
  return sum;
}
