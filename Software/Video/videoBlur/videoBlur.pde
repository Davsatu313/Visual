import processing.video.*;
Movie myMovie;
color imgv[];
color blur[];

void setup() {
  size(1000, 800);
  noStroke();
  myMovie = new Movie(this, "small.mp4");
  myMovie.play();
  //myMovie.loop();
  imgv = new color[1920 * 1080];
  blur = new color[1920 * 1080];
}

void draw() {
  //Matriz Gauss
  float e = 2.7182818284;
  int sigma = 3;
  float pi = 3.14159265359;
  int kernel = 15; 
  double gauss[] = new double[kernel];
  // Se llena la matriz de convolucion gaussiana
  float sum = 0;
  float s = pow(sigma, 2);
  for (int i = -kernel/2; i < kernel/2; i++) {
    gauss[i+int(kernel/2)] = (1/(2*pi*s)) * (Math.pow(e, (-(i*i)/(2*s))));
    sum += gauss[i+int(kernel/2)];
  }
  // Normalizacion
  for (int i = 0; i < kernel; i++) {
    gauss[i] /=sum;
  }
  double convolution[] = gauss;

  //Lectura de Pixeles
  if (myMovie.available() == true) {
    myMovie.read();
    myMovie.loadPixels();
    for (int i = 0; i < (myMovie.width * myMovie.height); i++) {
      color c = myMovie.pixels[i];
      imgv[i] = c;
    }
  }

  //Convolucion
  for (int i = 0; i < imgv.length; i++) {
    float r = 0;
    float g = 0;
    float b = 0;
    for (int k = -convolution.length/2; k < convolution.length/2; k++) {
      if (i+k < imgv.length && i+k > 0) {
        r += red(imgv[i+k])*(float)(convolution[k+convolution.length/2]);
        g += green(imgv[i+k])*(float)(convolution[k+convolution.length/2]);
        b += blue(imgv[i+k])*(float)(convolution[k+convolution.length/2]);
      }
    }
    blur[i] = color(r, g, b);
  }

  //Salida de video con efecto
  background(255);
  for (int j = 0; j < myMovie.height; j++) {
    for (int i = 0; i < myMovie.width; i++) {
      fill(blur[(j*myMovie.width) + i]);
      rect(i, j, 1, 1);
    }
  }
}
