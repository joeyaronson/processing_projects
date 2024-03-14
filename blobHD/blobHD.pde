void setup() {
  size(2560, 1600);
  colorMode(HSB,360);
  strokeWeight(0.2);
  background(0);
  osn = new OpenSimplexNoise(3);
  
  // loadColors();
  p = new ArrayList<Particle>();
  loadParticles();
  noiseSeed(2);
  globalFrame = 0;
  timer = 0;
  num = 5;
  println("");
  println("SEED : " + SEED);
}
int SEED = 0;
int MAX_SEED = 360;
int VARIANCE_MULT = 100;
float NOISE_DETAIL = 0.003;
float HUE_MULTIPLIER = 2;
ArrayList<Particle> p = new ArrayList<Particle>();
OpenSimplexNoise osn;
int timer = 0;
int num = 5;
int globalFrame = 0;
void draw() {
  background(0);
  while(true) {
    for (int i = 0; i < p.size(); i++) {
      p.get(i).move();
      
      //set the second 100 below to 50 to add stripes
      if (timer % num < num / 2) {
        p.get(i).display(true);
      }
      else{
        p.get(i).display(false); 
      }

      // p.get(i).display(true);
      
      if (globalFrame > 800) {
        //remove particle from array if they move too far from canvas
        if (
          p.get(i).x > width + 2 ||
          p.get(i).x < - 2 ||
          p.get(i).y > height + 2 ||
          p.get(i).y < - 2
        ){
          p.remove(i);
        }
      }
    }
    
    if (timer % num == num - 1) {
      num +=10;
      timer = 0;
    }
    
    // float thres = map(sin(radians(SEED)),-1,1,100,160);
    if (globalFrame > 700) {
      saveFrame("blobb/blob_####.png");
      SEED++;
      break;
    }
    timer++;
    globalFrame++;
    if (globalFrame % 50 == 0) {
      println(globalFrame + " : " + p.size() + " remain");
    }
  }
  setup();
  if (SEED >= MAX_SEED) {
    exit();
  }
  
}
void keyPressed() {
  saveFrame("######--" + p.size() + "rem.png"); 
}
class Particle{
  
  float x;
  float y;
  float n;
  float i;
  Particle(float x,float y,float i) {
    this.x = x;
    this.y = y;
    this.i = i;
  }
  
  void move() {
    //CIRCLE
    this.n = (float) osn.eval(
      this.x * NOISE_DETAIL,
      this.y * NOISE_DETAIL,
      (globalFrame + sin(radians(SEED)) * VARIANCE_MULT) * NOISE_DETAIL,
      (globalFrame + cos(radians(SEED)) * VARIANCE_MULT) *  NOISE_DETAIL
    );
    float noi = map(this.n, - 1,1, - 360,360);
    this.x += sin(radians(noi)) / 3.5;
    this.y += cos(radians(noi)) / 3.5;
    this.x += sin(radians(this.i)) / 2;
    this.y += cos(radians(this.i)) / 2;
    //ENDCIRCLE
    
    //SQUARE
    //float dx = this.x - width/2;
    //float dy = this.y - height/2;
    
    //float ang = atan2(dx,dy);
    //this.x += sin(ang);
    //this.y += cos(ang);
    //END SQUARE
    
    
    //this.y++;
  }
  
  void display(boolean col) {
    //float d = dist(this.x,this.y,width/2,height/2);
    // float h = map(this.n,-1,1,0,col_array.size());


    float h = map(this.n, - 0.8,0.8,0,360);
    if (col) {
      //stroke((d/1.5+h)%360,360,360);  
      //stroke(360);
      //stroke(col_array.get(floor((d/1.5+h)%col_array.size())));
      // stroke(col_array.get((int) h));
      stroke(((h*HUE_MULTIPLIER)+SEED )%360,360,360);
      point(this.x,this.y);
    }
    // else{
    //     stroke(0);
    //     //stroke(((d/1.5+h)+180)%360,360,360);  
    // }
    
    
    
  }
}

void loadParticles() {
  
  //RANDOM
  //for(int i = 0; i < 100000; i++){
  //  p.add(new Particle(random(width),random(height)));
  //}
  
  //DRIP
  //for(float i = 0; i < width; i+=0.5){
  //  for(int j = 0; j < 10; j+=2){
  //    p.add(new Particle(i,-j));
  //  }
  //}
  
  //CIRCLE
  for (float i = 0; i < 360; i += 0.01) {
    p.add(new Particle(width / 2 + sin(radians(i)) * 150, height / 2 + cos(radians(i)) * 150,i));
  }
  
  
  
  
  //SQUARE
  // float num = 0.05;
  //for(float i = -500; i < 500; i+=num){
  //  p.add(new Particle(width/2 + i, height/2 - 500,i));
  //}
  
  //for(float i = -500; i < 500; i+=num){
  //  p.add(new Particle(width/2 + i, height/2 + 500,i));
  //}
  
  //for(float i = -500; i < 500; i+=num){
  //  p.add(new Particle(width/2 -500, height/2 + i,i));
  //}
  
  //for(float i = -500; i < 500; i+=num){
  //  p.add(new Particle(width/2 + 500, height/2 +i,i));
  //}
  
  
  
  
}
