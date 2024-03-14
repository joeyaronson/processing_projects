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
	// loadColors();
	
}

ArrayList<Particle> p = new ArrayList<Particle>();
OpenSimplexNoise osn;
OpenSimplexNoise osn2;
//set number of particles here, width/60 is a good number
int num = 20;

//set noise multiplier. higher number = higher complexity
float noiseVal = 0.0025;
float noiseVal2 = 0.0035;
float noiseVal3 = 0.008;

//enter colors here
color colors[] = {#FF0000, #FF8000, #FFFF00, #00FF00, #00FFFF, #0000FF, #8000FF, #FF00FF, #FF0000, #FF8000, #FFFF00, #00FF00, #00FFFF, #0000FF, #8000FF, #FF00FF, };
ArrayList<Integer> col_array = new ArrayList<Integer>();
float steps = 50;
//set stroke weight here
float str_weight = 0.35;
int SPACE;
int SEED = 0;
int LEN = 200;
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
			
			//remove particle from array if they move too far from canvas
			// if (p.get(i).x > width + 10 ||  p.get(i).x < 10 || p.get(i).y > height + 10 || p.get(i).y < - 10) {
			// 	p.remove(i);
			// }
			
		}
		globalFrame++;
	}
	println("frame : " + SEED);
	saveFrame("output/sph_####.png");
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

float SIN_MULT = 1;
float NOISE_RADIUS = 200;
//particle class
class Particle {
	float x;
	float y;
	float nx;
	float ny;
	float j;
	Particle(float x, float y, float j) {
		this.x = x;
		this.y = y;
		this.j = j;
	}
	
	void display() {
		// float h = map(this.nx + this.ny, - 2, 2, 0, col_array.size());
		// fill(col_array.get((floor(h)) % col_array.size()));
		float nh = (float) osn.eval(
			this.x * noiseVal3,
			this.y * noiseVal3,
			(globalFrame + sin(radians(SEED)) * NOISE_RADIUS) * noiseVal3,
			(globalFrame + cos(radians(SEED)) * NOISE_RADIUS) *  noiseVal3
			);
		float h = map(nh, -1, 1, -20,120);
		float b = map(globalFrame,0,LEN,20,100);
		float br = map(this.j,100,0,0,100);
		fill((h) % 100,100,b-br);
		ellipse(this.x,this.y,this.j/10,this.j/10);
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
	// for (int i = - 1; i <= num + 1; i++) {
	// 	for (int j = - 1; j <= num + 4; j++) {
	// 		float offset = 0;
	// 		if (j % 2 == 0) {
	// 			offset = width / num /2;
	// 		}
	//   		// row.push(new Node(i * SPACE + offset, j * (SPACE / 2) * sqrt(3), i, j));
	// 		p.add(new Particle((SPACE * i) + offset,j * (SPACE / 2) * sqrt(3)));
	// 	}
	// }
	
	// CIRCLE
	for (int j = 100; j > 0; j -= 10) {
		int startOffset = (int) random(0,360);
		for (float i = 0; i < 360; i += 2) {
			p.add(new Particle(width / 2 + sin(radians(i+startOffset)) * j, height / 2 + cos(radians(i+startOffset)) * j, j));
		}
	}
}
