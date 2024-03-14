void setup(){
  size(9000, 6000); 
  loadColors();
}

float w = random(-2,2);
float h = (w * height) / width;
float ymin = -h/2;
float xmin = -w/2+0.31;
float INF = Integer.MAX_VALUE;
void draw(){
 
  
  noLoop();
  background(255);
  
  // Establish a range of values on the complex plane
  // A different range will allow us to "zoom" in or out on the fractal
  
  // It all starts with the width, try higher or lower values
  

  //float w = map(mouseX,0,width,0,1);
  //float h = (w * height) / width;
  
  // Start at negative half the width and height
  float xmin = -w/2;
  float ymin = -h/2;
  
  // Make sure we can write to the pixels[] array.
  // Only need to do this once since we don't do any other drawing.
  for(int iii = 0; iii< 20;iii++){
    w = random(-2,2);
   // ymin = random(-0.6,-0.5);
    loadPixels();
    
    // Maximum number of iterations for each point on the complex plane
    int maxiterations = 100;
    
    // x goes from xmin to xmax
    float xmax = xmin + w;
    // y goes from ymin to ymax
    float ymax = ymin + h;
    
    // Calculate amount we increment x,y for each pixel
    float dx = (xmax - xmin) / (width);
    float dy = (ymax - ymin) / (height);
    
    // Start y
    float y = ymin;
    for (int j = 0; j < height; j++) {
      // Start x
      float x = xmin;
      for (int i = 0; i < width; i++) {
    
        // Now we test, as we iterate z = z^2 + cm does z tend towards infinity?
        float a = x;
        float b = y;
        int n = 0;
        while (n < maxiterations) {
          float aa = a * a;
          float bb = b * b;
          float twoab = 2.0 * a * b;
          a = aa - bb + x;
          b = twoab + y;
          // Infinty in our finite world is simple, let's just consider it 16
          if (dist(aa, bb, 0, 0) > INF) {
            break;  // Bail
          }
          n++;
        }
    
        // We color each pixel based on how long it takes to get to infinity
        // If we never got there, let's pick the color black
        if (n == maxiterations) {
          pixels[i+j*width] = color(0);
        } else {
          // Gosh, we could make fancy colors here if we wanted
          float hh = map(n, 0, maxiterations, 0, col_array.size());
          pixels[i+j*width] = col_array.get(floor(hh));
        }
        x += dx;
      }
      y += dy;
      if(j%100 == 0){
        println(j);  
      }
      
    }
    updatePixels();
    saveFrame("mndl"+w+".png");
  }

  
}

void keyPressed() {
  xmin+=1.1;
  print(xmin);
}

//enter colors here
color colors[] = {#FF0000, #FF8000, #FFFF00, #00FF00, #00FFFF, #0000FF, #8000FF, #FF00FF, #FF0000,#FF0000, #FF8000, #FFFF00, #00FF00, #00FFFF, #0000FF, #8000FF, #FF00FF, #FF0000,#FF0000, #FF8000, #FFFF00, #00FF00, #00FFFF, #0000FF, #8000FF, #FF00FF, #FF0000 };
ArrayList<Integer> col_array = new ArrayList<Integer>();
float steps = 500;

//loads colors from the colors array and generates a gradient palette
void loadColors() {

  for (int i = 0; i < steps; i++) {
    col_array.add(color(colors[0]));
  }

  for (int i = 0; i < colors.length-1; i++) {
    color from = colors[i];
    color to = colors[i+1];
    for (float j = 0; j < steps; j++) {
      color c = lerpColor(from, to, j*(1/steps));
      col_array.add(color(c));
    }
  }

  for (float i = 0; i < steps; i++) {
    col_array.add(color(colors[colors.length-1]));
  }
}
