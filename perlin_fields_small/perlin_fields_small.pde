void setup() {
    size(4500,3000);
    background(0);
    colorMode(HSB,100);
    drawParticles();
    stroke(0,80);
    strokeWeight(0.75);
}

ArrayList<Particle> p = new ArrayList<Particle>();
int num = 100;
float noiseVal = 0.0009;
float noiseVal2 = 0.0008;
void draw() {
    // background(0,0.5)
    for(int i = 0; i < p.size(); i++){
        p.get(i).move();
        p.get(i).display();
        
         if(p.get(i).x > width+500 ||  p.get(i).x <-500 ||p.get(i).y > height+500 || p.get(i).y < -500){
             p.remove(i);
         }
    }
    
    //if(mouseIsPressed){
    //    background(0);
    //    p.splice(0,p.length);
    //    drawParticles();
    //    noiseVal = random(0.001,0.009);
    //    noiseVal2 = random(0.001,0.009);
    //}
    
}
void keyPressed() {
  saveFrame("rb-######.png");
}

class Particle{
    float x;
    float y;
    float nx;
    float ny;
    float t;
    float h;
    Particle(float x,float y){
      this.x = x;
      this.y = y;
      this.t = random(10);
      float nx = noise(this.x*noiseVal,this.y*noiseVal, frameCount*noiseVal);
      float ny = noise(this.y*noiseVal2,this.x*noiseVal2, frameCount*noiseVal2);
      this.h = map(nx+ny,0,2,-70,170);
    }
    
    void display(){
        //float h = map(this.nx+this.ny,0,2,-70,170);
        // stroke(100-h,100,20)
        //if(this.t%10 < 5){
        //  noStroke();
        //}
        //else{
        //  fill(0);
        //}
        
        fill(this.h%100,100,100);  

        
        ellipse(this.x,this.y,20,20);
    }
    
    void move(){
        this.nx = noise(this.x*noiseVal,this.y*noiseVal, frameCount*noiseVal);
        this.ny = noise(this.y*noiseVal2,this.x*noiseVal2, frameCount*noiseVal2);
        
        float nx = map(this.nx,0,1,-10,10);
        float ny = map(this.ny,0,1,-10,10);
        this.x += nx;
        this.y += ny;
        this.t++;
        this.h+=0.1;
        
       
    }
}

void drawParticles(){
    for(int i = -50; i <= num+50; i+= 1){
        for(int j = -50; j <= num+50; j+=1){
            p.add(new Particle(i*width/num,j*width/num));
        }
    }
}
