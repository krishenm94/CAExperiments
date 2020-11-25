
Boolean[][] makeRandomGrid(int cols, int rows)
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

Boolean[][] makeGrid(int cols, int rows)
{
  Boolean[][] grid = new Boolean[cols][rows];
  for (int col = 0; col < cols; col++)
  {
    Boolean[] colOfCells =  new Boolean[rows];
    for (int row = 0; row < rows; row++)  
    {
      colOfCells[row] = false;
    }
    grid[col] = colOfCells;
  }

  return grid;
}
