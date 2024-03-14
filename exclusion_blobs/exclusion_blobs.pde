void setup() {
  size(1000, 1000);
  rectMode(CENTER);
  noFill();
  noStroke();    
  makeNodes();
}

//making the array of nodes
ArrayList<Node> nodes = new ArrayList<Node>();
float num;
color[] colors = {
  color(255, 0, 0), 
  color(0, 255, 0), 
  color(0, 0, 255)
};

void draw() {
  //default blend mode
  blendMode(BLEND);
  background(255);
  // turn on exclusion
  blendMode(EXCLUSION);

  //display every node and move them
  for (int i = 0; i < nodes.size(); i++) {
    nodes.get(i).display();
    nodes.get(i).move();
  }
  if(frameCount < 720){
    saveFrame("outputFR/excl-######.png");
  }
}

//fills the nodes array with the nodes
void makeNodes() {
  //set number of nodes
  int count = 180;

  //calculated number of degrees inbetween nodes
  num = 360/count;

  //indexing for nodes
  int c = 0;
  // adds the nodes into the array
  for (int i = 0; i < 360; i+=num) {
    nodes.add(new Node(width/2, height/2, i, c));
    c++;
  }
}

//node class
class Node {
  //sets starting positions, angles and indexes
  float x;
  float y;
  float a;
  float i;
  Node(float x, float y, float a, float c) {
    this.x = x;
    this.y = y;
    this.a = a;
    this.i = c;
  }

  //moves the nodes in circular motion
  void move() {
    this.a+=0.5;
    this.x = this.x+sin(radians(this.a))*1.25;
    this.y = this.y+cos(radians(this.a))*1.25;
  }

  //draws the nodes
  void display() {
    //fills node with either red green or blue depending on the index
    fill(colors[floor(this.i%3)]);
    //translates to the position for rotation
    translate(this.x, this.y);
    rect(0, 0, abs(sin(radians(this.a))*100)+200, abs(cos(radians(this.a))*100)+200, 50);
    //resets translation
    resetMatrix();
  }
}

//Joey Aronson 2019
