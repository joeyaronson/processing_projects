void setup() {
  size(1000, 1000);
  background(0);
  colorMode(HSB, d = width / 2);
  strokeWeight(0.15);
  stroke(0, 0, 0, d / 2);
}

float d;
float globalFrame = 0;
int steps = 360;

void draw() {
  float r = width / 5;
  float newR = sqrt(r * r + r * r);
  float sp = 0.25;
  for (int i = 0; i < steps; i++) {
    circ(width / 2, height / 2, newR - r, 0, sp);
    circ(width / 2, height / 2, newR - r, 90, sp);
    circ(width / 2, height / 2, newR - r, 180, sp);
    circ(width / 2, height / 2, newR - r, 270, sp);
    globalFrame++;
  }
   saveFrame("output/######.png");
   if(frameCount > 1200){
    exit(); 
   }
}

void circ(float x, float y, float r, float a, float s) {
  float newR = sqrt(r * r + r * r);
  float dis = dist(x, y, width / 2, height / 2);
  fill((dis + frameCount) % d, d, d, d / 2);
  float nx = x + sin(radians(globalFrame * s + a)) * (newR + r * 2);
  float ny = y + cos(radians(globalFrame * s + a)) * (newR + r * 2);
  float s2 = sin(radians(globalFrame)) * 0.003;
  if (r > 5) {
    circ(nx, ny, newR - r, 0, s2);
  } else {
    ellipse(nx, ny, r * 5, r * 5);
  }
}
