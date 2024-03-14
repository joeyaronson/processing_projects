void setup() {
	//set resolution here
	size(500, 500);
	
	rectMode(CENTER);
	osn = new OpenSimplexNoise();
	globalFrame = 0;
	//set background color here
	background(0, 0, 0);
	drawParticles();
	
	//set stroke color here
	stroke(0,0,0,50);
	
	strokeWeight(str_weight);
	loadColors();
	
}

ArrayList<Particle> p = new ArrayList<Particle>();
//set number of particles here, width/60 is a good number
int num = 70;
OpenSimplexNoise osn;
//set noise multiplier. higher number = higher complexity
float noiseVal = 0.005;

//enter colors here
color colors[] = {#FF0000, #FF8000, #FFFF00, #00FF00, #00FFFF, #0000FF, #8000FF, #FF00FF, #FF0000, #FF8000, #FFFF00, #00FF00, #00FFFF, #0000FF, #8000FF, #FF00FF, };
ArrayList<Integer> col_array = new ArrayList<Integer>();
float steps = 50;
//set stroke weight here
float str_weight = 0.035;
int SEED = 0;
int VARIANCE_MULT = 1;
int globalFrame = 0;
//loads colors from the colors array and generates a gradient palette
void loadColors() {
	
	for (int i = 0; i < steps; i++) {
		col_array.add(color(colors[0]));
	}
	
	for (int i = 0; i < colors.length - 1; i++) {
		color from = colors[i];
		color to = colors[i + 1];
		for (float j = 0; j < steps; j++) {
			color c = lerpColor(from, to, j * (1 / steps));
			col_array.add(color(c));
		}
	}
	
	for (float i = 0; i < steps; i++) {
		col_array.add(color(colors[colors.length - 1]));
	}
}

int iterations = 50;
void draw() {
	//for each particle
	while(iterations == 50) {
		
		for (int i = 0; i < p.size(); i++) {
			p.get(i).move();
			p.get(i).display();
			
			//remove particle from array if they move too far from canvas
			if (p.get(i).x > width + 2 ||  p.get(i).x < - 2 || p.get(i).y > height + 2 || p.get(i).y < - 2) {
		p.remove(i);
			}
			
			
		}
		if (p.size() < 200) {
      println("saving frame : " + frameCount);
      saveFrame("output/orb####.png");
      SEED++;
      break;
		}
		globalFrame++;
		if(globalFrame %100 == 0){
      println("size: "+p.size());
    }
	}
	setup();
}

//takes screenshot on key press
void keyPressed() {
	saveFrame("new - perl - ###### - " + p.size() + "rem.png");
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
		float h = map(this.nx, - 1, 1, 0, col_array.size());
		// fill(col_array.get(floor(h)));
		// ellipse(this.x,this.y,10,10);
		stroke(col_array.get(floor(h)));
		point(this.x,this.y);
		//float a = map(this.nx,0,1,0,360);
		//translate(this.x,this.y);
		//rotate(radians(a));
		//rect(0,0, a/3, a/3);
		//resetMatrix();
	}
	
	void move() {
		
		this.nx = (float)osn.eval(this.x * noiseVal, this.y * noiseVal,(globalFrame + sin(radians(SEED)) * VARIANCE_MULT) * noiseVal,(globalFrame + cos(radians(SEED)) * VARIANCE_MULT) * noiseVal);
		// this.ny = (float)osn.eval(this.y*noiseVal2, this.x*noiseVal2, (globalFrame + cos(radians(SEED)) * VARIANCE_MULT) *  noiseVal2);
		
		float noi = map(this.nx, - 1,1, - 360,360);
		this.x += sin(radians(noi)) / 1;
		this.y += cos(radians(noi)) / 1;
		// this.x += nx;
		// this.y += ny;
	}
}

//loads particles into particle array
void drawParticles() {
	
	for (int i = - 1; i <= num + 1; i += 1) {
		for (int j = - 1; j <= num + 1; j +=1) {
		 p.add(new Particle((i * width / num),j * width / num));
		}
	}
	
	// for(int i = 0; i < num; i++){
	//    //float rx = random(width);
	//    //float ry = random(height);
	//    //float mr = random(50,150);
	
	//    for(int j = 0; j < num; j++){
	//       //float ma = random(0,360);
	//       //float rr = random(mr);
	   
	//       //p.add(new Particle(rx+sin(radians(ma))*rr,ry+cos(radians(ma))*rr));
	//       p.add(new Particle(random(width),random(height)));
	//    }
	// }
	
	//for(int i = 0; i < 10; i++){
	//   for(int j = 0; j < 10; j++ ){
	//      p.add(new Particle(random(width),random(height))); 
	//   }
	//}
	
	// for (int i = 0; i < 3600; i+=1) {
	//  // n.push(new Node(width/2+sin(i)* i/100,width/2+cos(i)*i/100));
	//  p.add(new Particle(width/2 + sin(radians(i/2) ) * i/100, height/2+cos( ( radians(i/2) ))*i/100  ) );
	// }
}
