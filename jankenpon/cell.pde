class Cell{
  PVector m_position;
  float m_size;
  color m_colour = 255;
  int m_level;
  
  Cell(float x, float y, float size){
    m_position = new PVector(x * size, y * size);
    m_size = size;
  } 
  
  void draw(){
    fill(m_colour);
    square(m_position.x, m_position.y, m_size);
  }
  
  void copy(Cell other){
    m_colour = other.m_colour;
    m_level = other.m_level;
  }
}
