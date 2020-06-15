#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

const vec4 lumcoeff = vec4(0.299, 0.587, 0.114, 0);

void main() {
  vec4 col = texture2D(texture, vertTexCoord.st);
  float R = col[0] * lumcoeff[0];
  float G = col[1] * lumcoeff[1];
  float B = col[2] * lumcoeff[2];

  float value = R + G + B;
  gl_FragColor = vec4(value, value, value, 1);
}