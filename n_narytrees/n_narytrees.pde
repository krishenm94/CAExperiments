float theta;
float lengthMultiplier = 0.66;
int branches = 3;

void setup() {
  size(800, 800);
}

void draw() {
  background(255);
  theta = map(mouseX, 0, width, 0, PI/2);
  branches = floor(map(mouseY, 0, height, 2, 10));
  translate(width/2, height);
  stroke(0);

  branch(height/3);
}

void branch(int length) {
  line(0, 0, 0, -length);
  translate(0, -length);

  length *= lengthMultiplier;

  if (length <= height/30 || theta == 0) {
    return;
  }

  for (float angle = -theta; angle <= theta; angle += 2*theta / (branches - 1)) {
    pushMatrix();
    rotate(angle);
    branch(floor(length * cos(angle)));
    popMatrix();
  }
}
