import java.util.*;

Grid GRID;
color MOUSE_COLOUR;

Random RANDOM = new Random();

void setup()
{
  size(800, 800);
  background(255);
  //frameRate(1);

  stroke(0);
  GRID = new Grid(20, 5);
}

void draw()
{
  updateMouseColor();
  drawMouse();
  GRID.draw();
}

void updateMouseColor() {
  if (key == 'r') {
    MOUSE_COLOUR = color(255, 0, 0);
  }

  if (key == 'g') {
    MOUSE_COLOUR = color(0, 255, 0);
  }

  if (key == 'b') {
    MOUSE_COLOUR = color(0, 0, 255);
  }
}

void drawMouse(){
  if(!mousePressed)
  {
    return;
  }
  
  int x = int(mouseX / GRID.m_cellSize);
  int y = int(mouseY / GRID.m_cellSize);
  
  GRID.m_cells[x][y].m_colour = MOUSE_COLOUR;
}
