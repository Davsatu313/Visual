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
  
  resetShader();
  image(mov, 0, 0);
  
  shader(basic);
  image(mov, img_w, 0);
  
  shader(average);
  image(mov, 0, img_h);
  
  shader(luma);
  image(mov, img_w, img_h);
  
  surface.setTitle("FPS " + nf(int(frameRate), 2) + " || Shader GreyScale ");
}
