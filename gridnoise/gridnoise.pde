void setup() {
    osn = new OpenSimplexNoise((long)random(0,360));
    smooth(8);
    size(1000, 1000, P3D);
    rectMode(CENTER);
    //angleMode(DEGREES);
    colorMode(HSB, 360);
    background(360);
    //debugMode();
    strokeWeight(1);
    //noStroke();
    
    loadTiles();
}
OpenSimplexNoise osn;

int S = 10;
int loopCount = 0;
ArrayList<Tile> t = new ArrayList<Tile>();
float nv = 0.004;
void draw() {
    background(180);
    camera(sin(radians(frameCount)) * 10,(cos(radians(frameCount)) * 600) + 600, 500, 0, 0, 0, 0, 1, 0);
    rotate(radians(45+frameCount));
    while(!allBurnt()) {
        displayTiles();
        loopCount++;
}
    if(frameCount <= 360) {
        saveFrame("output/grid-final-######.png");
        println(frameCount);
} else {
        exit();
}
    resetTiles();
}

void displayTiles() {
    for (Tile tile : t) {
        tile.move();
        tile.display();
}
};

void resetTiles() {
    for (Tile tile : t) {
        tile.resetTile();
}
};

void loadTiles() {
    for (float i = -width / 3; i < width / 3; i += S) {
        for (float j = -width / 3; j < width / 3; j += S) {
            t.add(new Tile(i, j, 0, t.size()));
        }
}
};

class Tile {
    float x;
    float y;
    float z;
    float i;
    float r;
    float o;
    float oX;
    float oY;
    float n;
    boolean burnt;
    float size;
    
    Tile(float x, float y, float z, float i) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.i = i;
        this.r = random(20, 250);
        this.oX = x;
        this.oY = y;
        this.size = random(10, 25);
}
    
    void display() {
        if (this.z < this.r) {
            push();
            translate(this.x, this.y, this.z);
           if (loopCount % 2 ==  0) {
                strokeWeight(1);
        } else {
                strokeWeight(0);
        }
            float bright = map(this.z, 0, this.r, 20,360);
            fill((this.n * 720) % 360, 360, bright);
            ellipse(0, 0, this.size, this.size);
           // cylinder(this.size,this.size, 3.0,3);
            pop();
        } else {
            this.burnt = true;
        }
}
    void move() {
        float n = (float) osn.eval(
            this.x* nv, 
            this.y* nv, 
            sin(radians(frameCount)), 
            cos(radians(frameCount)) 
           );
        this.n = map(n, -1, 1, 0, 1);
        float off = map(this.n, 0, 1, -360, 360);
        float d = dist(this.x, this.y, 0, 0);
        this.x += sin(radians(off));
        this.y += cos(radians(off));
        this.z += (this.n) * 3;
        // this.r += cos(radians(frameCount)) / 100;
}
    
    
    void resetTile() {
        this.z = 0;
        this.x = this.oX;
        this.y = this.oY;
        this.burnt = false;
}
}

boolean allBurnt() {
    for (Tile tile : t) {
        if (!tile.burnt) {
            return false;
        }
}
    return true;
}
