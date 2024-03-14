
void setup() {
	//set resolution here
	size(500, 500);
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
	stroke(0,0,0,50);
	
	strokeWeight(str_weight);
	
}

ArrayList<Particle> p = new ArrayList<Particle>();
OpenSimplexNoise osn;
OpenSimplexNoise osn2;
//set number of particles here, width/60 is a good number
int num = 10;

//set noise multiplier. higher number = higher complexity
float noiseVal = 0.0032;
float noiseVal2 = 0.0036;
float noiseVal3 = 0.008;

//set stroke weight here
float str_weight = 0.95;
int SPACE;
int SEED = 0;
int LEN = 200;

int iterations = 1;
int globalFrame = 0;
void draw() {
	background(0);
	//for each particle
	
	while(globalFrame < LEN) {
		for (int i = 0; i < p.size(); i++) {
			p.get(i).move();
			p.get(i).display();
			
		}
		globalFrame++;
	}
	println("frame : " + SEED);
	saveFrame("output/sin_####.png");
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

float SIN_MULT = 0.75;
float NOISE_RADIUS = 200;
//particle class
class Particle {
	float x;
	float y;
	float nx;
	float ny;
	float j;
	float i;
	boolean d;
	Particle(float x, float y, boolean d) {
		this.x = x;
		this.y = y;
		this.d = d;
		
	}
	
	void display() {
		float nh = (float) osn.eval(
			this.x * noiseVal3,
			this.y * noiseVal3,
			(globalFrame + sin(radians(SEED)) * NOISE_RADIUS) * noiseVal3,
			(globalFrame + cos(radians(SEED)) * NOISE_RADIUS) *  noiseVal3
			);
		float h = map(nh, - 1, 1, - 50,150);
		float b = map(globalFrame,0,LEN,50,100);
		float sx = map(this.nx, - 1,1,2,15);
		float sy = map(this.ny, - 1,1,2,15);
		if (this.d) {
		    fill((h) % 100,100,b);
		} else {
		    fill(100,b);
		}
		ellipse(this.x,this.y,10,10);
		
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
	// int count = 0;
	// for (int i = 0; i <= num; i++) {
	// 	for (int j = 0; j <= num ; j++) {
	// 		float offset = 0;
	// 		if (j % 2 == 0) {
	// 			offset = width / num / 2;
	// 		}
	// 		// row.push(new Node(i * SPACE + offset, j * (SPACE / 2) * sqrt(3), i, j));
	// 		p.add(new Particle((SPACE * i) + offset,j * (SPACE / 2) * sqrt(3),count));
	//         count++;
	// 	}
	// }
	float STEPS = 75;
	float st = width / STEPS;
	for (float i = 0; i < width; i += st) {
		p.add(
            new Particle(
                i,
                height / 2 + sin(radians(i + SEED)) * cos(radians(SEED)) * 100,
                true
            )
        );
		// p.add(
        //     new Particle(
        //         i,
        //         height / 2 + sin(radians(i - SEED + 180)) * 100,
        //         true
        //     )
        // );
	}
}
