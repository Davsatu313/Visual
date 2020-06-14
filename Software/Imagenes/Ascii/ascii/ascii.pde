  
PImage img;
//PFont mono = loadFont("CourierNewPSMT-12.vlw");

void setup() {
  size(1400, 700);
  //size(900, 1000);
  //img = loadImage("https://pbs.twimg.com/media/DnYgTB1V4AAMnNy.jpg"); // Load the original image
  img = loadImage("https://www.seekpng.com/png/detail/174-1740914_27kib-423x632-kirby-sword-sword-kirby-battle-royale.png"); // Load the original image
  img.resize(700, 700);
  image(img, 0, 0);
  //img.resize(500, 350);
  img.resize(200, 112);
  //img.resize(125, 86) ;
  noLoop();
} 

void draw() {
  //image(img, 0, 0); // Displays the image from point (0,0) 
  img.loadPixels();

  PImage edgeImg = createImage(img.width, img.height, RGB);
  String asciiRange = " .,:;i1tfLCG08@";
  String asciiImage = "";
  int w = 0;
  for (int y = 0; y < img.height  * img.width; y++) 
  {  // Skip left and right edges
     w++;
    if(w == img.width )
    {
      asciiImage += "\n";
      w = 0;
    }
    float sum = 0; // Kernel sum for this pixel
    sum = ( (red(img.pixels[y]) * 0.299) + (green(img.pixels[y]) * 0.587) + (blue(img.pixels[y]) * 0.114) );
    edgeImg.pixels[y] = color(sum);
    asciiImage += asciiRange.toCharArray()[int(map(sum, 0, 255, 0, asciiRange.toCharArray().length-1))];  
}
  edgeImg.updatePixels();
  
  
  textFont(loadFont("CourierNewPSMT-12.vlw"), 6);
  fill(0);
  //image(edgeImg, width/2, 0); // Draw the new 
  text(asciiImage, 700, 0);
}
