void setup() {
  //set resolution here
  size(500, 500);
  osn = new OpenSimplexNoise();
  //set background color here
  background(0, 0, 0);
  drawParticles();

  //set stroke color here
  stroke(0);

  //strokeWeight(str_weight);
  loadColors();
}
OpenSimplexNoise osn;
ArrayList<Particle> p = new ArrayList<Particle>();
//set number of particles here, width/60 is a good number
int num = 150;
float noiseVal = 0.008;


//enter colors here
color colors[] = {
  #b30086, #ff00bf, #b30086, //pink
  #990099, #0099ff, #990099, //blue
  #99ffcc, #00cc66, #99ffcc, //green
  #008000, #00ff00, #008000, //green2
  #33ccff, #007399, #33ccff, //blue
  #9933ff, #6600cc, #9933ff, //purple
  #ff00bf, #ff00ff, #ff00bf, //pink
  #b30000, #ff00ff, #b30000, //red
  #cc6600, #ff8000, #cc6600, //orange
  #ffbf00, #ffff00, #ffbf00, //yellow
  #cc6600, #ff8000, #cc6600, //orange
  #b30000, #ff00ff, #b30000, //red
  #cc6600, #ff8000, #cc6600, //orange
  #ffbf00, #ffff00, #ffbf00, //yellow
  #cc6600, #ff8000, #cc6600, //orange
  #b30000, #ff00ff, #b30000, //red

};
ArrayList<Integer> col_array = new ArrayList<Integer>();
float steps = 50;


//loads colors from the colors array and generates a gradient palette
void loadColors() {

  for (float i = 0; i < steps; i++) {
    col_array.add(color(colors[0]));
  }

  for (int i = 0; i < colors.length-1; i++) {
    color from = colors[i];
    color to = colors[i+1];
    for (float j = 0; j < steps; j++) {
      color c = lerpColor(from, to, j*(1/steps));
      col_array.add(color(c));
    }
  }
  for (float i = 0; i < steps; i++) {
    col_array.add(color(colors[colors.length-1]));
  }
}

int globalFrame = 0;
void draw() {
  for (int steps = 0; steps < 1; steps++) {
    //for each particle
    for (int i = 0; i < p.size(); i++) {
      p.get(i).display();
    }  
    globalFrame++;
  }

  //uncomment section below to capture screenshots
  //saveFrame("mov3/osn-######.png");
  //if(frameCount > 300){
  //  exit();     
  //}
}

//takes screenshot on key press
void keyPressed() {
  saveFrame("output/apf"+int(random(0, 1000))+"-######.png");
}

//particle class
class Particle {
  float x;
  float y;
  float nx;
  float ny;
  Particle(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    this.nx = (float) osn.eval(this.x*noiseVal, this.y*noiseVal, globalFrame*noiseVal);
    float h = map(this.nx, -1, 1, 0, col_array.size());
    stroke(col_array.get(floor(h)));
    point(this.x, this.y);
  }
}

//loads particles into particle array
void drawParticles() {
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      p.add(new Particle(i, j));
    }
  }
}
