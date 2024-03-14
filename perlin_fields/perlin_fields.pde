void setup() {
    size(9000,6000);
    background(0);
    colorMode(HSB,100);
    drawParticles();
    stroke(0,80);
    strokeWeight(1);
}

ArrayList<Particle> p = new ArrayList<Particle>();
int num = 150;
float noiseVal = 0.0005;
float noiseVal2 = 0.0003;
void draw() {
    // background(0,0.5)
    for(int i = 0; i < p.size(); i++){
        p.get(i).move();
        p.get(i).display();
        
        // if(p[i].x > width ||  p[i].x <0 ||p[i].y > height || p[i].y < 0){
        //     p.splice(i,1);
        //     p.push(new Particle(random(width), random(height)))
        // }
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
  saveFrame("perlin-######.png");
}

class Particle{
    float x;
    float y;
    float nx;
    float ny;
    Particle(float x,float y){
      this.x = x;
      this.y = y;
    }
    
    void display(){
        float h = map(this.nx+this.ny,0,2,-70,170);
        // stroke(100-h,100,20)
        fill(h,100,100);
        ellipse(this.x,this.y,25,25);
    }
    
    void move(){
        this.nx = noise(this.x*noiseVal,this.y*noiseVal, frameCount*noiseVal);
        this.ny = noise(this.y*noiseVal2,this.x*noiseVal2, frameCount*noiseVal2);
        
        float nx = map(this.nx,0,1,-5,5);
        float ny = map(this.ny,0,1,-5,5);
        this.x += nx;
        this.y += ny;
        
       
    }
}

void drawParticles(){
    for(int i = 0; i <= num; i+= 1){
        for(int j = 0; j <= num; j+=1){
            p.add(new Particle(i*width/num,j*width/num));
        }
    }
}
