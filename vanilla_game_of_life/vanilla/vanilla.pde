import java.util.*;

int SIZE = 1000;
int CELL_SIZE = 1;

Boolean[][] GRID = new Boolean[SIZE][SIZE];
Boolean[][] NEXT_GRID = new Boolean[SIZE][SIZE];

Random RANDOM = new Random();

void initGrid(Boolean[][] grid)
{
  for (int col = 0; col < SIZE; col++)
  {
    Boolean[] colOfCells =  new Boolean[SIZE];
    for (int row = 0; row < SIZE; row++)  
    {
      colOfCells[row] = RANDOM.nextBoolean() && 
      RANDOM.nextBoolean();
    }
    grid[col] = colOfCells;
  }
}

void setup()
{
  size(1000, 1000);
  background(255);
  smooth();

  initGrid(GRID);
  initGrid(NEXT_GRID);
}

void draw()
{
  background(255);
  fill(0);

  for (int col = 0; col < SIZE; col++)
  {
    for (int row = 0; row < SIZE; row++)  
    {
      if (GRID[col][row] == true)
      {
        square(row, col, CELL_SIZE);
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
      int x = (col + i + SIZE) % SIZE;
      int y = (row + j + SIZE) % SIZE;
      sum += GRID[y][x]? 1 : 0;
    }
  }
  sum -= GRID[col][row] ? 1 : 0;
  return sum;
}
