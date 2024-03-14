void setup() {
    size(9000,6000);
    background(0);
    drawParticles();
    stroke(0,80);
    strokeWeight(1);
    
    
    loadColors();
}

ArrayList<Particle> p = new ArrayList<Particle>();
int num = 150;
float noiseVal = 0.0005;
float noiseVal2 = 0.0003;

color colors[] = {color(0,0,255),color(255,0,0),color(255,255,0)};
ArrayList<Integer> col_array = new ArrayList<Integer>();
int steps = 50;


void loadColors(){
    
    for(int i = 0; i < steps;i++){
         col_array.add(color(colors[0]));
    }
    
    for(int i = 0; i < colors.length-1; i++){
        color from = colors[i];
        color to = colors[i+1];
        
        print("from"+from);
      
        for(int j = 0; j < steps;j++){
            color c = lerpColor(from,to,j*(1/steps));
            col_array.add(color(c));
        }
    }
    
    for(int i = 0; i < steps;i++){
        col_array.add(color(colors[colors.length-1]));
    }
}


void draw() {
    // background(0,0.5)
    //for(int i = 0; i < p.size(); i++){
    //    p.get(i).move();
    //    p.get(i).display();
        
    //     if(p.get(i).x > width + 500 ||  p.get(i).x < -500 || p.get(i).y > height+500 || p.get(i).y < -500){
    //         p.remove(i);
    //     }
    //}
    for(int i = 0; i < col_array.size(); i++){
        int col = col_array.get(i);
        fill(col);
        ellipse(i*width/col_array.size(),500,50,50);
    }
    
    
}
void keyPressed() {
  saveFrame("plc-######.png");
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
        //float h = map(this.nx+this.ny,0,2,-70,170);
        float h = map(this.nx,0,1,0,col_array.size());
        fill(col_array.get(floor(h)));
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
