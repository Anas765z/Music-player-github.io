import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//Dynamic Programming v Static
//
//Library - Minim
Minim minim;
AudioPlayer player;
//
//Global Variables
int appWidth, appHeight;
float imageDivX, imageDivY, imageDivWidth, imageDivHeight;
float imageWidthChanged=0.0, imageHeightChanged=0.0; //IN if-statement
//
PImage myFirstImage;
//
void setup() {
  //Display
  fullScreen();
  // size(700, 500);
  appWidth = width; //displayWidth
  appHeight = height; //displayHeight
  //
  //Population
  imageDivX = appWidth*1/4;
  imageDivY = appHeight*1/4;
  imageDivWidth = appWidth*1/2;
  imageDivHeight = appHeight*1/2;
  //
  //Image Aspect Ratio Algorithm
  String myFirstImagePathway = "images/pvz.jpg";
  myFirstImage = loadImage( myFirstImagePathway);
  int myFirstImageWidth = 640;
  int myFirstImageHeight = 360;
  float imageAspectRatioGreaterOne = ( myFirstImageWidth >= myFirstImageHeight ) 
    ? float(myFirstImageWidth) / myFirstImageHeight 
    : float(myFirstImageHeight) / myFirstImageWidth; // Fixed aspect ratio calculation
  println(imageAspectRatioGreaterOne);
  Boolean imageLandscape = ( myFirstImageWidth >= myFirstImageHeight ) ? true : false ;
  Boolean divLandscape = (imageDivWidth >= imageDivHeight ) ? true : false ;
  if ( imageLandscape ) {
    imageWidthChanged = imageDivWidth;
    imageHeightChanged = imageWidthChanged / imageAspectRatioGreaterOne; // Fixed height calculation
  } else {
    imageHeightChanged = imageDivHeight;
    imageWidthChanged = imageHeightChanged * imageAspectRatioGreaterOne; // Fixed width calculation
  }

  //Landscape includes square
  //imageWidthChanged, imageHeightChanged
  //
  //DIV
  rect( imageDivX, imageDivY, imageDivWidth, imageDivHeight );
  //
  //Prototype Images
  // Initialize Minim
  minim = new Minim(this);
  player = minim.loadFile("Crazy Dave (Intro Theme) _ Laura Shigihara.mp3"); // Ensure file exists in `data` folder
} //End setup
//
void draw() {
  image(myFirstImage, imageDivX, imageDivY, imageWidthChanged, imageHeightChanged); // Display image with corrected dimensions
} //End draw
//
void mousePressed() {
} //End mousePressed
//
void keyPressed() {
  if (key == 'p') {
    player.play();  // Play audio on 'p' key press
  } else if (key == 's') {
    player.pause(); // Pause audio on 's' key press
  }
}
//
void stop() {
  player.close();
  minim.stop();
  super.stop();
}
// End Main Program