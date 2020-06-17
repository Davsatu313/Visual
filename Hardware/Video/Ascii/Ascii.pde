import processing.video.*;

Movie mov;
PImage img;
PShader ascii;
PShape original, frame;
int img_size = 560;

void setup(){
  size(1120, 320, P3D);
  mov = new Movie(this, "small.mp4");
  mov.play();
  
  ascii = loadShader("ascii.glsl");
  ascii.set("iResolution", float(width), float(height));
}

void movieEvent(Movie m) {
  m.read();
}

void draw(){
  resetShader();
  image(mov, 0, 0);  
  filter(ascii);
  //shader(ascii); //This flip the image upside down kek
  image(mov, img_size, 0);
  surface.setTitle("FPS " + nf(int(frameRate), 2) + " || Shaser ASCII ");
}
