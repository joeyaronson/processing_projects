void setup() {
    //angleMode(DEGREES);
    size(4000,4000);
    loadNodes();
    strokeWeight(0.5);
    colorMode(HSB,100);
    
}

float noiseVal = 0.005;
float noiseVal2 = 0.0055;

ArrayList<Node> n = new ArrayList<Node>();


void draw() {
    //background(100);
    for(int i = 0; i < n.size(); i++){
        n.get(i).move();
        n.get(i).display();
        if((i+1)% n.size() !=0){
            line(n.get(i).x,n.get(i).y,n.get((i+1)).x,n.get(i+1).y);
        }
    }
    
    // n.push(new Node(width/2+sin(frameCount*10)* frameCount/5,width/2+cos(frameCount*10)*frameCount/5));
}

void keyPressed() {
    saveFrame("spi2-#####.png");
}

class Node{
    float x;
    float y;
    float dx;
    float dy;
    
    Node(float x,float y){
        this.x = x;
        this.y = y;
    }
    
    void display(){
        //ellipse(this.x,this.y,10,10);
        float dh = noise(this.x * noiseVal/2 , this.y * noiseVal/2,frameCount * noiseVal*2);
        float ddh = map(dh,0,1,-50,150);
         //float dw = map(dh,0,1,0.25,5);
         //strokeWeight(dw);
         stroke(ddh,100,100,80);
    }
    
    void move(){
        this.dx = noise(this.x * noiseVal, this.y * noiseVal, frameCount * noiseVal);
        this.dy = noise(this.x * noiseVal2, this.y * noiseVal2, frameCount * noiseVal);
        float dx = map(this.dx,0,1,-1,1);
        float dy = map(this.dy,0,1,-1,1);
        
        this.x += dx;
        this.y += dy;
    }
}

void loadNodes(){
    for(int i = 0; i < 180000; i+=1){
        // n.push(new Node(width/2+sin(i)* i/100,width/2+cos(i)*i/100));
        n.add(new Node(width/2 + sin(radians(i/5) ) * i/100 , width/2+cos( ( radians(i/5) ))*i/100  ) );
    }
}
