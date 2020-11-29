import java.util.*;

Grid GRID;
int GROWTH_LIMIT = 10;
int PREDATION_THRESHOLD = 3;
int CELL_SIZE = 3;

color MOUSE_COLOUR;

color RED = color(255, 0, 0);
color GREEN = color(0, 255, 0);
color BLUE = color(0, 0, 255);

Random RANDOM = new Random();

void setup()
{
  size(800, 800);
  background(255);
  //frameRate(1);

  stroke(0);
  GRID = new Grid(CELL_SIZE, GROWTH_LIMIT, PREDATION_THRESHOLD);
}

void draw()
{
  updateMouseColor();
  drawMouse();
  GRID.draw();
}

void updateMouseColor() {
  if (key == 'r') {
    MOUSE_COLOUR = RED;
  }

  if (key == 'g') {
    MOUSE_COLOUR = GREEN;
  }

  if (key == 'b') {
    MOUSE_COLOUR = BLUE;
  }
}

void drawMouse() {
  if (!mousePressed)
  {
    return;
  }

  if (mouseButton == RIGHT)
  {
    setup();
    return;
  }

  int x = int(mouseX / GRID.m_cellSize);
  int y = int(mouseY / GRID.m_cellSize);

  if ( x >= GRID.m_cols || y >= GRID.m_rows || x < 0 || y < 0) {
    return;
  }

  GRID.m_cells[x][y].m_colour = MOUSE_COLOUR;
}
