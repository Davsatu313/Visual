PImage img;
PShader kernel;
PShape frame, original;
int counter = 0;

final String[] k_variables = {"scalar", "k0", "k1", "k2", "k3", "k4", "k5", "k6", "k7", "k8"};

final float[] Saturation = { 1.0, -1.0, -1.0, -1.0, -1.0, 9.0, -1.0, -1.0, -1.0, -1.0 }; 

final float[] Edge = { 1.0, -1.0, -1.0, -1.0, -1.0, 8.0, -1.0, -1.0, -1.0, -1.0 }; 
 
final float[] Sharpen = { 1.0, 0.0, -1.0, 0.0, -1.0, 5.0, -1.0, 0.0, -1.0, 0.0 }; 
                   
final float[] SSaturation ={ 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 }; 
 
final float[] GaussianBlur = { 0.0625, 1.0, 2.0, 1.0, 2.0, 4.0, 2.0, 1.0, 2.0, 1.0 };

void setup(){
  size(1000, 500, P2D);
  img = loadImage("https://www.seekpng.com/png/detail/174-1740914_27kib-423x632-kirby-sword-sword-kirby-battle-royale.png"); // Load the original image
  img.resize(500, 500);
  
  original = createShape(RECT, 0, 0, 500, 500);
  original.setTexture(img);
  
  frame = createShape(RECT, 500, 0, 500, 500);
  frame.setTexture(img);
  
  kernel = loadShader("kernel.glsl");
}

void draw(){
  float[] matrix;
  switch (counter % 5) {
    case 0:
      matrix = Saturation;
    break;	
    case 1:
      matrix = Edge;
    break;	
    case 2:
      matrix = Sharpen;
    break;	
    case 3:
      matrix = SSaturation;
    break;	
    case 4:
      matrix = GaussianBlur;
    break;	
    default:
      matrix = new float[0];
    break;
  }

  for(int i = 0; i < k_variables.length; i++)
    kernel.set(k_variables[i], matrix[i]);
  
  shader(kernel);
  shape(frame);
  
  resetShader();
  shape(original);
}

void mousePressed(){
  counter++;
}
