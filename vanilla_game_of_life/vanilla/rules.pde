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

void update(int row, int col, int wolframCode)
{
  int neighbours = countNeighbours(row, col);
  int neighbourCode = int(pow(2, neighbours));
  for (int mask = 1; mask < MOORE_CODE; mask = mask << 1)
  {
    if ((wolframCode & mask) == pow(2, neighbours))
    {
      NEXT_GRID[col][row] = true;
      return;
    }
  }

  NEXT_GRID[col][row] = false;
}

void vanilla_update(int row, int col)
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
