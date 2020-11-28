class Cell {
  PVector m_position;
  float m_size;
  color m_colour = 255;
  int m_level = 0;

  Cell(float x, float y, float size) {
    m_position = new PVector(x * size, y * size);
    m_size = size;
  } 

  void draw() {
    fill(m_colour);
    square(m_position.x, m_position.y, m_size);
  }

  void copy(Cell other) {
    m_colour = other.m_colour;
    m_level = other.m_level;
  }

  void grow(Cell other) {
    m_colour = other.m_colour;
    m_level = other.m_level + 1;
  }

  void eat(Cell other) {
    other.m_colour = m_colour;
    other.m_level  = 0;
  }
}
