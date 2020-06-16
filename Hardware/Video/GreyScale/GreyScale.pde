import processing.video.*;

Movie mov;
PShader basic, average, luma;
PImage original_sh, basic_sh, average_sh, luma_sh;
int counter = 0, img_w = 560, img_h = 320;

void setup(){
  size(1120, 640, P2D);
  mov = new Movie(this, "small.mp4");
  mov.play();
  
  basic = loadShader("basic.glsl");
  average = loadShader("average.glsl");
  luma = loadShader("luma.glsl");
}

void movieEvent(Movie m) {
  m.read();
}

void draw(){
  original_sh = createImage(mov.width, mov.height, RGB);
  for (int y = 0; y < mov.height  * mov.width; y++){
    original_sh.pixels[y] = mov.pixels[y];
  }
  
  resetShader();
  image(original_sh, 0, 0);
  
  shader(basic);
  image(original_sh, img_w, 0);
  
  shader(average);
  image(original_sh, 0, img_h);
  
  shader(luma);
  image(original_sh, img_w, img_h);
}
