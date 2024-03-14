import processing.svg.*;

void setup() {
  size(1000, 1000);
  strokeWeight(10);
  noLoop();
  beginRecord(SVG, "hex.svg");
}

int count = 15;
float size = 50;

void draw() {
  //background(0,200,255);
  noFill();

  for (float i = 0; i < count; i+=1.5) {
    for (float j = 0; j< count*1.5; j+=sqrt(3)) {
      float x = i*size*2;
      float y = j*size;
      float d = dist(width/2, height/2, x, y);
      float m = map(d, 0, 1000, 12, 5);
      strokeWeight(10);
      polygon(x, y, size, 6);
      //strokeWeight(m);
      polygon(x, y, size/2, 6);
      float x2 = (i*size*2) - size - size/2;
      float y2 = j*size+sqrt(3)/2 * size;
      float d2 = dist(width/2, height/2, x2, y2);
      float m2 = map(d2, 0, 1000, 12, 5);
      strokeWeight(10);
      polygon(x2, y2, size, 6);
      //strokeWeight(m2);

      polygon(x2, y2, size/2, 6);
    }
  }
  endRecord();
}

void polygon(float x, float y, float radius, float npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
