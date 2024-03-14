
void setup() {
	//set resolution here
	size(3840, 2160);
	SPACE = width / num;
	rectMode(CENTER);
	long rand1 = (long) random(0,10000);
	long rand2 = (long) random(0,10000);
	osn = new OpenSimplexNoise(rand1);
	osn2 = new OpenSimplexNoise(rand2);
	
	//set background color here
	background(0, 0, 0);
	drawParticles();
	colorMode(HSB,100);
	//set stroke color here
	stroke(0,0,0,60);
	
	strokeWeight(str_weight);
	
}

ArrayList<Particle> p = new ArrayList<Particle>();
OpenSimplexNoise osn;
OpenSimplexNoise osn2;
//set number of particles here, width/60 is a good number
int num = 65;

//set noise multiplier. higher number = higher complexity
float noiseVal = 0.0005;
float noiseVal2 = 0.0015;
float noiseVal3 = 0.00098;

//set stroke weight here
float str_weight = 0.75;
int SPACE;
int SEED = 0;
int LEN = 300;

int iterations = 1;
int globalFrame = 0;
void draw() {
	background(0);
	//for each particle
	// for(int j = 0; j < iterations; j++){
	
	while(globalFrame < LEN) {
		for (int i = 0; i < p.size(); i++) {
			p.get(i).move();
			p.get(i).display();
			
		}
		globalFrame++;
	}
	println("frame : " + SEED);
	saveFrame("output/noodle_####.png");
	p = new ArrayList<Particle>();
	drawParticles();
	globalFrame = 0;
	SEED++;
	if (SEED == 360) {
		exit();
	}
	
}

//takes screenshot on key press
void keyPressed() {
	saveFrame("new - perl - ###### - " + p.size() + "rem.png");
}

float SIN_MULT = 1.5;
float NOISE_RADIUS = 200;
//particle class
class Particle {
	float x;
	float y;
	float nx;
	float ny;
	float j;
	Particle(float x, float y) {
		this.x = x;
		this.y = y;
	}
	
	void display() {
		float nh = (float) osn.eval(
			this.x * noiseVal3,
			this.y * noiseVal3,
			(globalFrame + sin(radians(SEED)) * NOISE_RADIUS) * noiseVal3,
			(globalFrame + cos(radians(SEED)) * NOISE_RADIUS) *  noiseVal3
			);
		float h = map(nh, - 1, 1, - 20,120);
		float b = map(globalFrame,0,LEN,20,100);
		fill((h) % 100,100,b);
		ellipse(this.x,this.y,30,30);
	}
	
	void move() {
		
		this.nx = (float) osn.eval(
			this.x * noiseVal,
			this.y * noiseVal,
			(globalFrame + sin(radians(SEED)) * NOISE_RADIUS) * noiseVal,
			(globalFrame + cos(radians(SEED)) * NOISE_RADIUS) *  noiseVal
			);
		this.ny = (float) osn2.eval(
			this.y * noiseVal2,
			this.x * noiseVal2,
			(globalFrame + sin(radians(SEED + 50)) * NOISE_RADIUS) * noiseVal2,
			(globalFrame + cos(radians(SEED + 50)) * NOISE_RADIUS) *  noiseVal2
			);
		this.x += this.nx * SIN_MULT;
		this.y += this.ny * SIN_MULT;
	}
}

//loads particles into particle array
void drawParticles() {
	// HEX
	for (int i = - 1; i <= num + 1; i++) {
		for (int j = - 1; j <= num + 2; j++) {
			float offset = 0;
			if (j % 2 == 0) {
				offset = width / num / 2;
			}
			// row.push(new Node(i * SPACE + offset, j * (SPACE / 2) * sqrt(3), i, j));
			p.add(new Particle((SPACE * i) + offset,j * (SPACE / 2) * sqrt(3)));
		}
	}
}
