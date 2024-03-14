void setup() {
  size(500, 500);
  osn = new OpenSimplexNoise();
  colorMode(HSB,360);
  strokeWeight(0.2);
  background(0);
  loadColors();
  loadParticles();
}
//enter colors here
color colors[] = {#FF0000, #FF8000, #FFFF00, #00FF00, #00FFFF, #0000FF, #8000FF, #FF00FF, #FF0000, #FF8000, #FFFF00, #00FF00, #00FFFF, #0000FF, #8000FF, #FF00FF, };
ArrayList<Integer> col_array = new ArrayList<Integer>();
float steps = 50;
int timer = 0;
float noiseVal = 0.0009;
ArrayList<Particle> p = new ArrayList<Particle>();
//open simplex noise
OpenSimplexNoise osn;

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

int num = 5;
int globalFrame = 0;
void draw() {
  for(int f = 0; f < 10; f++){
    for(int i = 0; i < p.size(); i++){
      p.get(i).move();
      
      //set the second 100 below to 50 to add stripes
      
      if(timer % num < num/2){
        p.get(i).display(true);  
      }
      else{
        p.get(i).display(false); 
      }
      
      if(frameCount > 1000){
        //remove particle from array if they move too far from canvas
        if (p.get(i).x > width + 200 ||  p.get(i).x < -200 || p.get(i).y > height+200 || p.get(i).y < -200) {
          p.remove(i);
        }
      }
      
    }
    
    if(timer % num == num-1){
        num+=10;
        timer = 0;
    }
    
    if(p.size() == 0){
        saveFrame("final######.png");
        exit();
    }
    timer++;
    globalFrame++;
  }
}
void keyPressed(){
  saveFrame("######--"+p.size()+"rem.png"); 
}
class Particle{
  
  float x;
  float y;
  float n;
  float i;
  Particle(float x,float y,float i){
    this.x = x;
    this.y = y;
    this.i = i;
  }
  
  void move(){
    //CIRCLE
    this.n = (float) osn.eval(this.x * noiseVal, this.y * noiseVal, globalFrame * noiseVal);
    float noi = map(this.n,-1,1,-360,360);
    this.x += sin(radians(noi))/3.5;
    this.y += cos(radians(noi))/3.5;
    this.x += sin(radians(this.i))/2;
    this.y += cos(radians(this.i))/2;
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
  
  void display(boolean col){
    //float d = dist(this.x,this.y,width/2,height/2);
    // float h = map(this.n,-1,1,0,col_array.size());
    float h = map(this.n,0,1,0,360);
    if(col){
      //stroke((d/1.5+h)%360,360,360);  
      //stroke(360);
      //stroke(col_array.get(floor((d/1.5+h)%col_array.size())));
      // stroke(col_array.get((int) h));
      stroke(h,360,360);
    }
    else{
      stroke(0);
      //stroke(((d/1.5+h)+180)%360,360,360);  
    }
    point(this.x,this.y);
    
    
  }
}

void loadParticles(){
  
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
  for(float i = 0; i < 360; i+= 0.01){
    p.add(new Particle(width/2 + sin(radians(i))*50, height/2 +cos(radians(i))*50,i));
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
