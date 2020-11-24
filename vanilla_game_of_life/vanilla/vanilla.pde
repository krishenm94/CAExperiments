import java.util.*;

int CELL_SIZE = 2;

Boolean[][] GRID;
Boolean[][] NEXT_GRID;
int COLS;
int ROWS;

Random RANDOM = new Random();

void setup()
{
  size(800, 800);
  background(255);
  smooth();
  frameRate(10);
  COLS = width/ CELL_SIZE;
  ROWS = height / CELL_SIZE;

  GRID = makeGrid(COLS, ROWS);
  NEXT_GRID = makeGrid(COLS, ROWS);
}

void draw()
{
  background(255);
  fill(0);

  if ( mousePressed  && mouseButton == LEFT)
  {
    int col = int(mouseX / CELL_SIZE);
    int row = int(mouseY/CELL_SIZE);

    for (int i = -2; i < 4; i++) {
      for (int j = -2; j < 4; j++) {
        int x = (col + i + COLS) % COLS;
        int y = (row + j + ROWS) % ROWS;
        GRID[x][y] = true;
      }
    }
  }
  
  if(mousePressed && mouseButton == RIGHT)
  {
    GRID = makeGrid(COLS, ROWS);
  }

  for (int col = 0; col < COLS; col++)
  {
    for (int row = 0; row < ROWS; row++)  
    {
      if (GRID[col][row] == true)
      {
        square(col * CELL_SIZE, row * CELL_SIZE, CELL_SIZE);
      }

      update(row, col, unbinary("10011010"));
      //vanilla_update(row, col);
    }
  }

  Boolean[][] temp = GRID;
  GRID = NEXT_GRID;
  NEXT_GRID = temp;
}
