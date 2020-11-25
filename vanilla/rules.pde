int MOORE_NEIGHBOURS = 8;
int MOORE_CODE = int(pow(2, MOORE_NEIGHBOURS));

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

void mooreGreedy(int row, int col, int code)
{
  int neighbours = countNeighbours(row, col);

  int neighbourCode = int(pow(2, neighbours));
  for (int mask = 1; mask < MOORE_CODE; mask = mask << 1)
  {
    if ((code & mask) == neighbourCode)
    {
      NEXT_GRID[col][row] = true;
      return;
    }
  }

  NEXT_GRID[col][row] = false;
}

void mooreFlip(int row, int col, int code)
{
  int neighbours = countNeighbours(row, col);

  int neighbourCode = int(pow(2, neighbours));
  NEXT_GRID[col][row] = GRID[col][row];

  for (int mask = 1; mask < MOORE_CODE; mask = mask << 1) {
    if ((code & mask) == neighbourCode) {
      NEXT_GRID[col][row] = !NEXT_GRID[col][row];
    }
  }
}

void elementaryRule(int row, int col, int code)
{
  int pattern = 0;
  for (int i = -1; i < 2; i++) {
    int x = (col + i + COLS) % COLS;
    if ( GRID[x][row] == true) {
      pattern += pow(2, -i+1);
    }
  }

  for (int mask = 1, counter = 0; mask < MOORE_CODE; mask = mask << 1, counter++) {
    if (counter != pattern) {
      continue;
    }

    if ((code & mask) > 0) {
      NEXT_GRID[col][(row + 1 + ROWS) % ROWS] = true;
    } else {
      NEXT_GRID[col][(row + 1 + ROWS) % ROWS] = false;
    }
  }
}


void conwaysRule(int row, int col)
{
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
