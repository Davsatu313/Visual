import processing.video.*;

Movie mov;
int newFrame = 0;
PImage edgeImg;

void setup() {
  size(1000, 1000);
  background(0);
  mov = new Movie(this, "small.mp4");
  mov.loop();
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(255);
  mov.loadPixels();

  edgeImg = createImage(mov.width, mov.height, RGB);
  String asciiRange = " .,:;i1tfLCG08@";
  String asciiImage = "";
  int w = 0;
  for (int y = 0; y < mov.height  * mov.width; y++) {
  
     w++;
    if(w == mov.width )
    {
      asciiImage += "\n";
      w = 0;
    }
    float sum = 0; 
    sum = ( (red(mov.pixels[y]) * 0.299) + (green(mov.pixels[y]) * 0.587) + (blue(mov.pixels[y]) * 0.114) );
    edgeImg.pixels[y] = mov.pixels[y];
    asciiImage += asciiRange.toCharArray()[int(map(sum, 0, 255, 0, asciiRange.toCharArray().length-1))];
}
  edgeImg.updatePixels();


  textFont(loadFont("Monospaced.plain-15.vlw"), 8);
  fill(0);
  image(edgeImg, 0, 0);
  text(asciiImage, mov.width, 0);
}
