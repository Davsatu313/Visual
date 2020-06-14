/**
 * Convolution
 * by Daniel Shiffman.  
 * 
 * Applies a convolution matrix to a portion of an image. Move mouse to 
 * apply filter to different parts of the image. This example is currently
 * not accurate in JavaScript mode.
 */

PImage img;
int w = 120;
int img_size = 350;

// It's possible to convolve the image with many different 
// matrices to produce different effects. This is a high-pass 
// filter; it accentuates the edges. 

float filterScalar = 1.0;

float[][] Saturation = { { -1.0, -1.0, -1.0 },
                     { -1.0,  9.0, -1.0 },
                     { -1.0, -1.0, -1.0 } }; 

float[][] Edge = { { -1.0, -1.0, -1.0 },
                     { -1.0,  8.0, -1.0 },
                     { -1.0, -1.0, -1.0 } }; 

float[][] Sharpen = { { 0, -1, 0 },
                     { -1,  5, -1 },
                     { 0, -1, 0 } }; 
                     
float[][] SSaturation ={ { 1.0,1.0,1.0 },
                         { 1.0,1.0,1.0 },
                         { 1.0,1.0,1.0 } }; 

float[][] GaussianBlur = { { 1.0,2.0,1.0 },
                         { 2.0,4.0,2.0 },
                         { 1.0,2.0,1.0 } };


void setup() {
  size(700, 700);
  img = loadImage("https://www.seekpng.com/png/detail/174-1740914_27kib-423x632-kirby-sword-sword-kirby-battle-royale.png"); // Load the original image
  img.resize(img_size, img_size);
}

void draw(){
  image(img, 0, 0);
  image(create_image(Sharpen), img_size, 0);
  image(create_image(GaussianBlur), 0, img_size);
  image(create_image(Edge), img_size, img_size);
}

PImage create_image(float[][] matrix) {
  
  PImage new_image = createImage(img.width, img.height, RGB);
  
  // set the scalar filter in case is a blur  
  filterScalar = (matrix==GaussianBlur)? 0.0625 : 1;
  
  int matrixsize = 3;
  loadPixels();
  
  // Begin our loop
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      color c = convolution(x, y, matrix, matrixsize, img);
      int loc = x + y*img.width;
      new_image.pixels[loc] = c;
    }
  }
  new_image.updatePixels();
  
  return new_image;
}

color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc,0,img.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(img.pixels[loc]) * matrix[i][j] * filterScalar   );
      gtotal += (green(img.pixels[loc]) * matrix[i][j] * filterScalar );
      btotal += (blue(img.pixels[loc]) * matrix[i][j] * filterScalar  );
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}
