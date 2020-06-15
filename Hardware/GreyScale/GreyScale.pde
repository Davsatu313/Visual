PImage img;
PShader basic, average, luma;
PShape original_sh, basic_sh, average_sh, luma_sh;
int counter = 0, img_size = 350;

void setup(){
  size(700, 700, P2D);
  img = loadImage("https://www.seekpng.com/png/detail/174-1740914_27kib-423x632-kirby-sword-sword-kirby-battle-royale.png"); // Load the original image
  //img = loadImage("https://pm1.narvii.com/6737/a0189ca5eae2ccd5916b8df883ac3749cfec58d8v2_hq.jpg"); // Load the original image
  img.resize(img_size, img_size);
  
  original_sh = createShape(RECT, 0, 0, img_size, img_size);
  original_sh.setTexture(img);
  
  basic_sh = createShape(RECT, img_size, 0, img_size, img_size);
  basic_sh.setTexture(img);
  
  average_sh = createShape(RECT, 0, img_size, img_size, img_size);
  average_sh.setTexture(img);
  
  luma_sh = createShape(RECT, img_size, img_size, img_size, img_size);
  luma_sh.setTexture(img);
  
  basic = loadShader("basic.glsl");
  average = loadShader("average.glsl");
  luma = loadShader("luma.glsl");
}

void draw(){
  resetShader();
  shape(original_sh);
  
  shader(basic);
  shape(basic_sh);
  
  shader(average);
  shape(average_sh);
  
  shader(luma);
  shape(luma_sh);
}
