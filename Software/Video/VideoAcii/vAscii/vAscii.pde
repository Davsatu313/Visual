import processing.video.*;

Movie mov;
int newFrame = 0;

void setup() {
  size(1000, 1000);
  background(0);
  mov = new Movie(this, "small.mp4");
  mov.play();
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(0);
  mov.loadPixels();

  PImage edgeImg = createImage(mov.width, mov.height, RGB);
  String asciiRange = " .,:;i1tfLCG08@";
  String asciiImage = "";
  int w = 0;
  for (int y = 0; y < mov.height  * mov.width; y++) 
  {
     w++;
    if(w == mov.width )
    {
      asciiImage += "\n";
      w = 0;
    }
    float sum = 0; 
    sum = ( (red(mov.pixels[y]) * 0.299) + (green(mov.pixels[y]) * 0.587) + (blue(mov.pixels[y]) * 0.114) );
    edgeImg.pixels[y] = color(sum);
    asciiImage += asciiRange.toCharArray()[int(map(sum, 0, 255, 0, asciiRange.toCharArray().length-1))];
}
  edgeImg.updatePixels();


  textFont(loadFont("Monospaced.plain-15.vlw"), 10);
  fill(255);
  text(asciiImage, 0, 0);
}
