void setup() {
  size(1000, 1000);
  rectMode(CENTER);

  strokeWeight(50);
  noFill();
  makeNodes();
}

boolean loop = true;
ArrayList<node> nodes =new ArrayList<node>();
float num = 180;
float thick;
color[] colors = {
  color(255, 0, 0), 
  color(0, 255, 0), 
  color(0, 0, 255)
};

void draw() {
  blendMode(BLEND);
  background(255);
  // turn on exclusion
  blendMode(EXCLUSION);
  
  for (int i = 0; i < nodes.size(); i++) {
    nodes.get(i).display();
    nodes.get(i).move();
  }
  
  if(frameCount < 781){
    saveFrame("output/plaid-######.png");
  }
}

void makeNodes() {
  int count = 18;
  nodes.clear();
  num = 360/count;

  int counter = 0;
  for (int i = 0; i < 360; i+=num) {
    nodes.add(new node(width/2, height/2, i, counter));
    counter++;
  }
}

class node {
  float x;
  float y;
  float a;
  int i;
  node(float x, float y, float a, int c) {
    this.x = x;
    this.y = y;
    this.a = a;
    this.i = c;
  }

  void move() {
    this.a+=0.125;
    this.x = this.x+sin(radians(this.a*5));
    this.y = this.y+cos(radians(this.a*5));
  }

  void display() {
    stroke(colors[this.i%3]);   
    fill(colors[(this.i+1)%3]);   
    ellipse(this.x, this.y, 200, 200);
  }
}
