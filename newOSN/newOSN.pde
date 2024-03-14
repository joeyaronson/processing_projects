void setup() {
    osn = new OpenSimplexNoise();
    //set resolution here
    size(9000,6000);

    //set background color here
    background(0,0,0);
    drawParticles();

    //set stroke color here
    stroke(0);

    strokeWeight(str_weight);
    loadColors();
}

ArrayList<Particle> p = new ArrayList<Particle>();
//set number of particles here, width/60 is a good number
int num = 150;
float noiseVal = random(0.001,0.002);
float noiseVal2 = 0.0011;
float frameOffset = random(0,1000);
//open simplex noise
OpenSimplexNoise osn;

//enter colors here
color colors[] = {
  #b30086, #ff00bf, #b30086, //pink
  #990099, #0099ff, #990099, //blue
  #99ffcc, #00cc66, #99ffcc, //green
  #008000, #00ff00, #008000,  //green2
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
  //#cc6600, #ff8000, #cc6600, //orange
  //#b30000, #ff00ff, #b30000, //red
  //#b30086, #ff00bf, #b30086, //pink
  //#990099, #0099ff, #990099, //blue
  //#99ffcc, #00cc66, #99ffcc, //green
  //#008000, #00ff00, #008000,  //green2
  //#33ccff, #007399, #33ccff, //blue
  //#9933ff, #6600cc, #9933ff, //purple
  //#ff00bf, #ff00ff, #ff00bf, //pink
  //#990099, #0099ff, #990099, //blue
  //#99ffcc, #00cc66, #99ffcc, //green
  //#008000, #00ff00, #008000,  //green2
  //#33ccff, #007399, #33ccff, //blue
  //#9933ff, #6600cc, #9933ff, //purple
  //#ff00bf, #ff00ff, #ff00bf, //pink
  
  
};
ArrayList<Integer> col_array = new ArrayList<Integer>();
float steps = 50;
//set stroke weight here higher stroke weight results in darker result
float str_weight = 0.55;


//loads colors from the colors array and generates a gradient palette
void loadColors(){
    
    for(float i = 0; i < steps;i++){
        col_array.add(color(colors[0]));
    }
    
    for(int i = 0; i < colors.length-1; i++){
        color from = colors[i];
        color to = colors[i+1];
        for(float j = 0; j < steps;j++){
            color c = lerpColor(from,to,j*(1/steps));
            col_array.add(color(c));
        }
    }
    for(float i = 0; i < steps;i++){
        col_array.add(color(colors[colors.length-1]));
    }
}

float globalFrame = 0;
void draw() {
    for(int steps = 0; steps < 150; steps++){
      //for each particle
      for(int i = 0; i < p.size(); i++){
          p.get(i).move();
          p.get(i).display();
          
          //remove particle from array if they move too far from canvas
          if(p.get(i).x > width + 1000 ||  p.get(i).x < -1000 || p.get(i).y > height+1000 || p.get(i).y < -1000){
              p.remove(i);
          }
          
          //saves final copy of canvas
          if(p.size() == 0){
              saveFrame("output/apf-final"+ int(random(0,100)) +"-######.png");
              exit();
          }
      }  
      globalFrame++;
    }
    saveFrame("output/apf-######-"+int(random(0,200))+".png");
}

//takes screenshot on key press
void keyPressed() {
    saveFrame("output/apf"+int(random(0,1000))+"-######.png");
}

//particle class
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
        float h = map(this.nx,-1,1,0,col_array.size());
        fill(col_array.get(floor(h)));
        ellipse(this.x,this.y,25,25);
    }
    
    void move(){
        this.nx = (float) osn.eval(this.x * noiseVal ,this.y * noiseVal,sin((globalFrame+frameOffset)) * noiseVal);
        //this.nx = (float) osn.eval(this.x * noiseVal2 ,this.y * noiseVal2,frameCount * noiseVal2);
        float ang = map(this.nx,-1,1,0,2*PI);
        
        //float nx = map(this.nx,0,1,-5,5);
        //float ny = map(this.ny,0,1,-5,5);
        this.x += sin(ang)*2;
        this.y += cos(ang)*2;
    }
}

//loads particles into particle array
void drawParticles(){
    for(int i = -1; i <= num+1; i+= 1){
        for(int j = -1; j <= num+1; j+=1){
            p.add(new Particle(i*width/num,j*width/num));
        }
    }
    //for(float i = 0; i < 50000; i++){
    //   p.add(new Particle(width/2 + sin(radians(i/3)) * i/50,height/2 + cos(radians(i/3)) * i/50));
    //}
}
