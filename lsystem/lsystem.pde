System system;
Turtle turtle;
int counter = 0;


void setup() {
  size(600, 600);

  Rule[] ruleset = new Rule[1];
  ruleset[0] = new Rule('F', "FF+[+F-F+F]-[-F+F-F]");
  system = new System("F", ruleset);
  turtle = new Turtle(height/3, 0.5, radians(25));
  turtle.set(system.m_sentence);
}

void draw() {
  background(255);  
  fill(0);
  //text("Click mouse to generate", 10, height-10);

  translate(width/2, height);
  rotate(-PI/2);
  turtle.render();
  noLoop();
}

void mousePressed() {
  if (counter < 5) {
    pushMatrix();
    system.generate();
    println(system.m_sentence + "\n");
    turtle.set(system.m_sentence);
    popMatrix();
    redraw();
    counter++;
  }
}
