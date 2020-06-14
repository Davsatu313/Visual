/**
 * Histogram. 
 * 
 * Calculates the histogram of an image. 
 * A histogram is the frequency distribution 
 * of the gray levels with the number of pure black values
 * displayed on the left and number of pure white values on the right. 
 *
 * Note that this sketch will behave differently on Android, 
 * since most images will no longer be full 24-bit color.
 */

size(700, 700);

// Load an image from the data directory
// Load a different image by modifying the comments
PImage img;
img = loadImage("https://pm1.narvii.com/6737/a0189ca5eae2ccd5916b8df883ac3749cfec58d8v2_hq.jpg");
//img = loadImage("https://poesiabinaria.net/wp-content/uploads/2010/03/lenna_main.jpg");
img.resize(700, 700);
image(img, 0, 0);
img.loadPixels();


int[] hist = new int[256];

for(int i = 0; i < img.width * img.height; ++i)
{
  int sum = 0; // Kernel sum for this pixel
    sum = (int) ( (red(img.pixels[i]) * 0.299) + (green(img.pixels[i]) * 0.587) + (blue(img.pixels[i]) * 0.114) );
    hist[sum]++;
}

// Find the largest value in the histogram
int histMax = max(hist);

stroke(255);
// Draw half of the histogram (skip every second value)
for (int i = 0; i < img.width; i += 2) {
  // Map i (from 0..img.width) to a location in the histogram (0..255)
  int which = int(map(i, 0, img.width, 0, 255));
  // Convert the histogram value to a location between 
  // the bottom and the top of the picture
  int y = int(map(hist[which], 0, histMax, img.height, 0));
  line(i, img.height, i, y);
}
