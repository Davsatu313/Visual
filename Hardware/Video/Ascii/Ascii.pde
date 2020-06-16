import processing.video.*;

Movie mov;
PImage img;
PShader ascii;
PShape original, frame;
int img_size = 560;

void setup(){
  size(1120, 320, P2D);
  mov = new Movie(this, "small.mp4");
  mov.play();
  
  ascii = loadShader("ascii.glsl");
  ascii.set("iResolution", float(width), float(height));
}

void movieEvent(Movie m) {
  m.read();
}

void draw(){
  
  img = createImage(mov.width, mov.height, RGB);
  for (int y = 0; y < mov.height  * mov.width; y++){
    img.pixels[y] = mov.pixels[y];
  }
  
  resetShader();
  image(img, 0, 0);
  
  filter(ascii);
  //shader(ascii); //This flip the image upside down kek
  image(img, img_size, 0);
}
