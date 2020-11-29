int CELL_SIZE = 4;
int ROW = 0;

int RULE = 60;

Boolean[] GRID;
Boolean[] NEXT_GRID;

void setup()
{
  size(800, 800);
  init();
}

void draw()
{
  if (mouseButton == LEFT)
  {
    return;
  }

  if (mouseButton == RIGHT)
  {
    init();
    return;
  }

  for (int i = 0; i < width / CELL_SIZE; i++) {
    if (GRID[i] == true) {
      square(i*CELL_SIZE, ROW*CELL_SIZE, CELL_SIZE);
    }
    update(RULE, i);
  }

  Boolean[] temp = GRID;
  GRID = NEXT_GRID;
  NEXT_GRID = temp;

  ROW++;
  //ROW %= (height/CELL_SIZE);
}

void init()
{
  ROW = 0;
  GRID = makeGrid();
  NEXT_GRID = makeGrid();

  GRID[width/CELL_SIZE/2 - 1] = true;

  background(255);
  fill(255, 0, 0);
  stroke(0);
}

Boolean[] makeGrid()
{
  Boolean[] grid = new Boolean[width / CELL_SIZE];
  for (int i = 0; i < width / CELL_SIZE; i++) {
    grid[i] = false;
  }
  return grid;
}

void update(int rule, int col)
{
  int pattern = 0;
  for (int i = -1; i < 2; i++) {
    int x = (col + i + (width/CELL_SIZE)) % (width/CELL_SIZE);
    if (GRID[x] == true) {
      pattern += pow(2, -i+1);
    }
  }

  for (int mask = 1, counter = 0; counter < 8; mask = mask << 1, counter++) {
    if (counter != pattern) {
      continue;
    }

    if ((rule & mask) > 0) {
      NEXT_GRID[col] = true;
    } else {
      NEXT_GRID[col]= false;
    }
  }
}
