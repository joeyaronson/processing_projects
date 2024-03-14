Cell[][] grid;
Cell[][] prev;

float dA = 1.0;
float dB = 0.5;
float feed = 0.0542;
float k = 0.06124;

float s = 0.5;


//enter colors here
color colors[] = {#00FFFF,#0000FF,#FF0000, #000000};
ArrayList<Integer> col_array = new ArrayList<Integer>();
float steps = 50;

//loads colors from the colors array and generates a gradient palette
void loadColors() {

  for (int i = 0; i < steps; i++) {
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

void setup() {
  size(1920, 1080);
  loadColors();

  grid = new Cell[width][height];
  prev = new Cell[width][height];

  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j ++) {
      float a = 1;
      float b = 0;
      grid[i][j] = new Cell(a, b);
      prev[i][j] = new Cell(a, b);
    }
  }

  //random startseed
  for (int n = 0; n < 900; n++) {
    int startx = int(random(width/2-300, width/2+300));
    int starty = int(random(height/2 - 300, height/2+300));

    for (int i = startx; i < startx+20; i++) {
      for (int j = starty; j < starty+20; j ++) {
        float a = 1;
        float b = 1;
        grid[i][j] = new Cell(a, b);
        prev[i][j] = new Cell(a, b);
      }
    }
  }
  //for(int j = 0; j < 5;j++){
  //  float rx = random(200,width-200);
  //  float ry = random(200,height-200);
  //  for(float i = 0; i < 1080; i+=0.125){
  //    float a = 1;
  //    float b = 1;
  //    grid[floor(rx + sin(radians(i))*i/10)][floor(ry +cos(radians(i))*i/10)] = new Cell(a, b);
  //    prev[floor(rx +sin(radians(i))*i/10)][floor(ry +cos(radians(i))*i/10)] = new Cell(a, b);
  //  }
  //}
}


class Cell {
  float a;
  float b;

  Cell(float a_, float b_) {
    a = a_;
    b = b_;
  }
}


void update() {
  for (int i = 1; i < width-1; i++) {
    for (int j = 1; j < height-1; j ++) {

      Cell spot = prev[i][j];
      Cell newspot = grid[i][j];

      float a = spot.a;
      float b = spot.b;

      float laplaceA = 0;
      laplaceA += a*-1;
      laplaceA += prev[i+1][j].a*0.2;
      laplaceA += prev[i-1][j].a*0.2;
      laplaceA += prev[i][j+1].a*0.2;
      laplaceA += prev[i][j-1].a*0.2;
      laplaceA += prev[i-1][j-1].a*0.05;
      laplaceA += prev[i+1][j-1].a*0.05;
      laplaceA += prev[i-1][j+1].a*0.05;
      laplaceA += prev[i+1][j+1].a*0.05;

      float laplaceB = 0;
      laplaceB += b*-1;
      laplaceB += prev[i+1][j].b*0.2;
      laplaceB += prev[i-1][j].b*0.2;
      laplaceB += prev[i][j+1].b*0.2;
      laplaceB += prev[i][j-1].b*0.2;
      laplaceB += prev[i-1][j-1].b*0.05;
      laplaceB += prev[i+1][j-1].b*0.05;
      laplaceB += prev[i-1][j+1].b*0.05;
      laplaceB += prev[i+1][j+1].b*0.05;
      //.045 to .07
      //k = map(dist(width/2,height/2,i,j),0,width/2,0.06,0.065);
      newspot.a = a + (dA*laplaceA - a*b*b + feed*(1-a))*s;
      newspot.b = b + (dB*laplaceB + a*b*b - (k+feed)*b)*s;

      newspot.a = constrain(newspot.a, 0, 1);
      newspot.b = constrain(newspot.b, 0, 1);
    }
  }
}
void keyPressed(){
  saveFrame("##########--k-"+k+"--s-"+s+".png"); 
}

void swap() {
  Cell[][] temp = prev;
  prev = grid;
  grid = temp;
}

void draw() {

  for (int i = 0; i < 1; i++) {
    update();
    swap();
  }

  loadPixels();
  for (int i = 1; i < width-1; i++) {
    for (int j = 1; j < height-1; j ++) {
      Cell spot = grid[i][j];
      float a = spot.a;
      float b = spot.b;
      int pos = i + j * width;
      int c = floor(map(a-b,-1,1,0,col_array.size()-1));

      pixels[pos] = col_array.get(c);
    }
  }
  updatePixels();
}
