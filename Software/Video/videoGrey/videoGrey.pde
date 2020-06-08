import processing.video.*;
Movie myMovie;
color luma[];

void setup() {
  size(1000, 800);
  noStroke();
  myMovie = new Movie(this, "small.mp4");
  myMovie.play();
  //myMovie.loop();
  luma = new color[1920 * 1080];
}

void draw() {
  if (myMovie.available() == true) {
    myMovie.read();
    myMovie.loadPixels();
    for (int i = 0; i < (myMovie.width * myMovie.height); i++) {
      color c = myMovie.pixels[i];
      luma[i] = int(0.299*red(c)) + int(0.587*green(c)) + int(0.114*blue(c));
    }
  }
  
  //Salida de video con efecto
  background(255);
  for (int j = 0; j < myMovie.height; j++) {
    for (int i = 0; i < myMovie.width; i++) {
      fill(luma[(j*myMovie.width) + i]);
      rect(i, j, 1, 1);
    }
  }
}
