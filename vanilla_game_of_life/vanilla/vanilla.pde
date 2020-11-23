import java.util.*;

int SIZE = 500;
int CELL_SIZE = 1;

Boolean[][] GRID = new Boolean[SIZE][SIZE];

Random RANDOM = new Random();

void initGrid()
{
    for (int row = 0; row < SIZE; row++)
  {
    Boolean[] rowOfCells =  new Boolean[SIZE];
    for (int col = 0; col < SIZE; col++)  
    {
      rowOfCells[col] = RANDOM.nextBoolean();
    }
    GRID[row] = (rowOfCells);
  }
}

void setup()
{
  size(500, 500);
  background(255);
  smooth();
  
  initGrid();
}

void draw()
{
  background(255);
  fill(0);

  for (int row = 0; row < SIZE; row++)
  {
    for (int col = 0; col < SIZE; col++)  
    {
      if (GRID[row][col] == true)
      {
        square(row, col, CELL_SIZE);
      }
      
      GRID[row][col] =  RANDOM.nextBoolean();
    }
  }
}
