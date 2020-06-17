import processing.video.*;

Movie myMovie;
PImage original, average, luma;

void setup() {
  size(1120, 640);
  noStroke();
  myMovie = new Movie(this, "small.mp4");
  myMovie.play();
  background(0);
}

void movieEvent(Movie m) {
  m.read();
}

void draw(){
  myMovie.loadPixels();
  if(myMovie.width * myMovie.height > 0){
    original = createImage(myMovie.width, myMovie.height, RGB);
    average = createImage(myMovie.width, myMovie.height, RGB);
    luma = createImage(myMovie.width, myMovie.height, RGB);
    
    for(int i = 0; i < myMovie.width * myMovie.height; i++){
      color c = myMovie.pixels[i];
      original.pixels[i] = c;
      average.pixels[i] = color((red(c) + green(c) + blue(c))/3);
      luma.pixels[i] = color(int(0.299*red(c)) + int(0.587*green(c)) + int(0.114*blue(c)));
    }
    original.updatePixels();
    average.updatePixels();
    luma.updatePixels();
    
    image(original, myMovie.width/2, 0);
    image(average, 0, myMovie.height);
    image(luma, myMovie.width, myMovie.height);
  }
  
  surface.setTitle("FPS " + nf(int(frameRate), 2) + " || videoGrey ");
}
