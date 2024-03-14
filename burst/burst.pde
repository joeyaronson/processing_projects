void setup() {
  size(1000, 1000);
  colorMode(HSB, 100);
  background(0);
  m = sqrt(pow(width / 2, 2)+ pow(height / 2, 2))-300;
  dh = new DisplayHandler();
  mtemp = m;
  noStroke();
  dh.loadNodes(nodeCount);
}

ArrayList<Node> n = new ArrayList<Node>();
float m;
float mtemp;
DisplayHandler dh = new DisplayHandler();
int nodeCount = 15000;
float noiseVal = 0.007;
float nodeSize = 8;

void draw() {
  fill(0,15);
  rect(0,0,width,height);
  float n = noise(width/2 * noiseVal, height/2 * noiseVal, frameCount * noiseVal);
  float nm = map(n, 0, 1, 0, 100);
  fill((nm) % 100, 100, 100);

  ellipse(width / 2, height / 2, nodeSize, nodeSize);
  dh.updateNodes();
  saveFrame("output2/burst-######.png");

}

class Node {
    float x;
    float y;
    float s;
    float size;
    float d;
    Node(float x, float y) {
    this.x = x;
    this.y = y;
    this.s = 1;
    this.size = 0;
    this.d = dist(this.x, this.y, width / 2, height / 2);
  }

  void display() {
    float n = noise(this.x * noiseVal, this.y * noiseVal, frameCount * noiseVal);
    float nm = map(n, 0, 1, 0, 100);
    float hm = map(this.d, 0, mtemp * 2, 0, 200);
    fill((hm + nm) % 100, 100, 100);
    ellipse(this.x, this.y, this.size, this.size);
  }

  void move() {
    float angle = atan2(width / 2 - this.x, height / 2 - this.y);
    this.d = dist(this.x, this.y, width / 2, height / 2);
    float n = noise(this.x * noiseVal, this.y * noiseVal, frameCount * noiseVal);
    float nm = map(n, 0, 1, -0.5, 0.5);
    float speed = -map(this.d, 0, m, 10, 0);
    this.x += sin(angle+nm) * speed;
    this.y += cos(angle+nm) * speed;

  }

  void grow() {
    this.size += 0.1;
  }
}

class DisplayHandler {
  String mode;
  float timer;
  String next;
  DisplayHandler() {
    this.mode = "grow";
    this.timer = 30;
  }

  void loadNodes(int num) {
    for (int i = 0; i < num; i++) {
      n.add(new Node(random(-400, width + 400), random(-400, height + 400)));
    }
    
    //for(float i = -200; i < width+200; i += width/sqrt(num)){
    //  for(float j = -200; j < height+200; j += height/sqrt(num)){
    //     n.add(new Node(i,j)); 
    //  }
    //}
  }

  void updateNodes() {

    switch (this.mode) {
      case "grow":
        this.grow();
        break;
      case "move":
        this.move();
        break;
      case "wait":
        this.wait(this.next);
        break;

    }
  }

  void grow() {
    for (int i = 0; i < n.size(); i++) {
      n.get(i).display();
      n.get(i).grow();
    }

    if (n.get(0).size > nodeSize) {
      this.next = "move";
      this.mode = "wait";

    }
  }

  void move() {
    for (int i = 0; i < n.size(); i++) {
      n.get(i).display();
      n.get(i).move();

    }
    if (m > 4) {
      m -= 3;
    } else {
      n.clear();
      m = mtemp;
      this.loadNodes(nodeCount);
      this.next = "grow";
      this.mode = "wait";
    }
  }

  void wait(String mode) {
    for (int i = 0; i < n.size(); i++) {
      n.get(i).display();
    }
    if (this.timer > 0) {
      this.timer--;
    } else {
      this.mode = mode;
      this.timer = 30;
      if(mode == "grow"){
        exit(); 
      }
    }
  }

}
