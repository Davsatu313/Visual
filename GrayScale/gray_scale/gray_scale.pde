
PImage img;

void setup() {
  size(1500, 500);
  img = loadImage("https://www.seekpng.com/png/detail/174-1740914_27kib-423x632-kirby-sword-sword-kirby-battle-royale.png"); // Load the original image
  img.resize(500, 500) ;
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

  image(edgeImg, width/3, 0); // Draw the new image
  image(edgeImg2, (width/3) * 2, 0); // Draw the new image
}
