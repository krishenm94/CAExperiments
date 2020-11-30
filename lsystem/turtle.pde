class Turtle {
  String m_sentence;
  float m_shrinkFactor;
  float m_angle;
  float m_length;

  Turtle(float length, float shrink, float angle) {
    m_length = length;
    m_shrinkFactor = shrink;
    m_angle = angle;
  }

  void set(String sentence) {
    m_sentence = sentence;
    m_length *= m_shrinkFactor;
  }

  void render() {
    for (int i = 0; i < m_sentence.length(); i++) {
      char c = m_sentence.charAt(i);
      if (c == 'F' || c == 'G') {
        line(0, 0, m_length, 0);
        translate(m_length, 0);
      } else if (c == '+') {
        rotate(m_angle);
      } else if (c == '-') {
        rotate(-m_angle);
      } else if (c == '[') {
        pushMatrix();
      } else if (c == ']') {
        popMatrix();
      }
    }
  }
}
