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
  //frameRate(7);
  COLS = width/ CELL_SIZE;
  ROWS = height / CELL_SIZE;

  GRID = makeGrid(COLS, ROWS);
  NEXT_GRID = makeGrid(COLS, ROWS);
}

void drawSquare(int size)
{
  // real square dim = 2*size + 1
  int col = int(mouseX / CELL_SIZE);
  int row = int(mouseY / CELL_SIZE);

  for (int i = -size; i < size+1; i++) {
    for (int j = -size; j < size+1; j++) {
      int x = (col + i + COLS) % COLS;
      int y = (row + j + ROWS) % ROWS;
      GRID[x][y] = true;
    }
  }
}
void draw()
{
  background(255);
  fill(0);

  if ( mousePressed  && mouseButton == LEFT)
  {
    drawSquare(0);
  }

  if (mousePressed && mouseButton == RIGHT)
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

      if (keyPressed)
      {
        if (key == 'g') {
          conwaysRule(row, col);
        } else {
          //mooreFlip(row, col, 76);
          //mooreGreedy(row, col, unbinary("10011001"));
          wolframUpdate(row, col, 110);
        }
      }
    }
  }

  if (keyPressed)
  {
    Boolean[][] temp = GRID;
    GRID = NEXT_GRID;
    NEXT_GRID = temp;
  }
}
