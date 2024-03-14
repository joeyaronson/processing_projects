void setup() {
  //set resolution here
  size(9000, 6000);
  
  rectMode(CENTER);

  //set background color here
  background(0, 0, 0);
  drawParticles();

  //set stroke color here
  stroke(0);

  strokeWeight(str_weight);
  loadColors();
  
}

ArrayList<Particle> p = new ArrayList<Particle>();
//set number of particles here, width/60 is a good number
int num = 800;

//set noise multiplier. higher number = higher complexity
float noiseVal = 0.00085;
float noiseVal2 = 0.00095;

//enter colors here
color colors[] = {#FF0000, #FF8000, #FFFF00, #00FF00, #00FFFF, #0000FF, #8000FF, #FF00FF, #FF0000, #FF8000, #FFFF00, #00FF00, #00FFFF, #0000FF, #8000FF, #FF00FF, };
ArrayList<Integer> col_array = new ArrayList<Integer>();
float steps = 50;
//set stroke weight here
float str_weight = 0.15;


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


void draw() {
  //for each particle
  for (int i = 0; i < p.size(); i++) {
    p.get(i).move();
    p.get(i).display();

    //remove particle from array if they move too far from canvas
    if (p.get(i).x > width + 200 ||  p.get(i).x < -200 || p.get(i).y > height+200 || p.get(i).y < -200) {
      p.remove(i);
    }

    
  }
  
  //saves final copy of canvas
    if (p.size() == 0) {
      saveFrame("pxx-final-######.png");
      exit();
    }
    
    if(frameCount % 5000 == 0 || frameCount == 500){
        saveFrame("pxx-incr-######.png");
        print(frameCount+" "+p.size());
    }
}

//takes screenshot on key press
void keyPressed() {
  saveFrame("px-######-"+p.size()+"rem.png");
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
    float h = map(this.nx, 0, 1, 0, col_array.size());
    fill(col_array.get(floor(h)));
    ellipse(this.x,this.y,10,10);
    //point(this.x,this.y);
    //float a = map(this.nx,0,1,0,360);
    //translate(this.x,this.y);
    //rotate(radians(a));
    //rect(0,0, a/3, a/3);
    //resetMatrix();
  }

  void move() {
    this.nx = noise(this.x*noiseVal, this.y*noiseVal, frameCount*noiseVal);
    this.ny = noise(this.y*noiseVal2, this.x*noiseVal2, frameCount*noiseVal2);

    float nx = map(this.nx, 0, 1, -3, 3);
    float ny = map(this.ny, 0, 1, -3, 3);
    this.x += nx;
    this.y += ny;
  }
}

//loads particles into particle array
void drawParticles() {
  
  //for(int i = -1; i <= num+1; i+= 1){
  //  if(i % 2 == 0){
  //    off = (width/num)/2;
  //   }
  //   else{
  //    off = 0;
  //   }
  //    for(int j = -1; j <= num+1; j+=1){
  //        p.add(new Particle((i*width/num),j*width/num +off));
  //    }
  //}
  
  //for(int i = 0; i < num; i++){
  //   float rx = random(width);
  //   float ry = random(height);
  //   float mr = random(50,150);
     
  //   for(int j = 0; j < num; j++){
  //      float ma = random(0,360);
  //      float rr = random(mr);
        
  //      //p.add(new Particle(rx+sin(radians(ma))*rr,ry+cos(radians(ma))*rr));
  //      p.add(new Particle(random(width),random(height)));
  //   }
  //}
  for(float i = 0; i < width;i+=0.125){
      p.add(new Particle(i,height/2+sin(radians(i/10))*height/3));
  }
  
  //for(int i = 0; i < 10; i++){
  //   for(int j = 0; j < 10; j++ ){
  //      p.add(new Particle(random(width),random(height))); 
  //   }
  //}
  
  //for (int i = 0; i < 180000; i+=1) {
  //  // n.push(new Node(width/2+sin(i)* i/100,width/2+cos(i)*i/100));
  //  p.add(new Particle(width/2 + sin(radians(i/2) ) * i/200, height/2+cos( ( radians(i/2) ))*i/200  ) );
  //}
}
