PImage img;
int img_size = 350;

void setup() {
  size(700, 700);
  img = loadImage("https://www.seekpng.com/png/detail/174-1740914_27kib-423x632-kirby-sword-sword-kirby-battle-royale.png"); // Load the original image
  //img = loadImage("https://pm1.narvii.com/6737/a0189ca5eae2ccd5916b8df883ac3749cfec58d8v2_hq.jpg"); // Load the original image
  img.resize(img_size, img_size) ;
  noLoop();
} 

void draw() {
  image(img, 0, 0); // Displays the image from point (0,0) 
  img.loadPixels();

  PImage edgeImg = createImage(img.width, img.height, RGB);

  for (int y = 0; y < img.height  * img.width; y++) {  // Skip left and right edges
    float sum = 0; // Kernel sum for this pixel
    sum = ( (red(img.pixels[y]) * 0.299) + (green(img.pixels[y]) * 0.587) + (blue(img.pixels[y]) * 0.114) );
    edgeImg.pixels[y] = color(sum);
  }
  edgeImg.updatePixels();


  PImage edgeImg2 = createImage(img.width, img.height, RGB);

  for (int y = 0; y < img.height * img.width; y++) {
    float sum = 0;   
    sum = ( (red(img.pixels[y])) + (green(img.pixels[y])) + (blue(img.pixels[y])) ) / 3;
    edgeImg2.pixels[y] = color(sum);
  }

  edgeImg2.updatePixels();
  
  PImage edgeImg3 = createImage(img.width, img.height, RGB);
  
  for (int y = 0; y < img.height * img.width; y++) {
    float sum = 0;   
    sum = ( (red(img.pixels[y]) * 0.299) + (green(img.pixels[y]) * 0.587) + (blue(img.pixels[y]) * 0.114) );
    edgeImg3.pixels[y] = sum/255 > 0.5? color(255): color(0);
  }

  edgeImg3.updatePixels();
  
  image(edgeImg3, img_size, 0);
  image(edgeImg, 0, img_size); // Draw the new image
  image(edgeImg2, img_size, img_size); // Draw the new image
}
