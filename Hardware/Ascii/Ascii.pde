PImage img;
PShader ascii;
PShape original, frame;
int img_size = 500;

void setup(){
  size(1000, 500, P2D);
  img = loadImage("https://www.seekpng.com/png/detail/174-1740914_27kib-423x632-kirby-sword-sword-kirby-battle-royale.png");
  //img = loadImage("https://pm1.narvii.com/6737/a0189ca5eae2ccd5916b8df883ac3749cfec58d8v2_hq.jpg");
  img.resize(img_size, img_size);
  
  ascii = loadShader("ascii.glsl");
  ascii.set("iResolution", float(width)/2, float(height));
}

void draw(){
  resetShader();
  image(img, img_size, 0);
 
  shader(ascii);
  image(img, 0, 0);
}
