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
String[] tracks = { 
  "Crazy Dave (Intro Theme) _ Laura Shigihara.mp3", 
  "Track2.mp3", 
  "Track3.mp3" 
}; // List of music files
int currentTrackIndex = 0; // Index of the currently playing track
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
  player = minim.loadFile(tracks[currentTrackIndex]); // Load the first track
} //End setup
//
void draw() {
  image(myFirstImage, imageDivX, imageDivY, imageWidthChanged, imageHeightChanged); // Display image with corrected dimensions
  
  // Draw pause button
  fill(255, 0, 0); // Red color for the button
  rect(appWidth - 100, appHeight - 50, 80, 30); // Button dimensions
  fill(255); // White text
  textAlign(CENTER, CENTER);
  text("Pause", appWidth - 60, appHeight - 35); // Button label
} //End draw
//
void mousePressed() {
  // Check if the pause button is clicked
  if (mouseX >= appWidth - 100 && mouseX <= appWidth - 20 && mouseY >= appHeight - 50 && mouseY <= appHeight - 20) {
    player.pause(); // Pause the music
  }
} //End mousePressed
//
void keyPressed() {
  if (key == 'p') {
    player.play();  // Play audio on 'p' key press
  } else if (key == 's') {
    player.pause(); // Pause audio on 's' key press
  } else if (key == 'n') {
    nextTrack(); // Play the next track on 'n' key press
  } else if (key == 'b') {
    previousTrack(); // Play the previous track on 'b' key press
  }
}
//
void nextTrack() {
  player.close(); // Stop the current track
  currentTrackIndex = (currentTrackIndex + 1) % tracks.length; // Move to the next track
  player = minim.loadFile(tracks[currentTrackIndex]); // Load the next track
  player.play(); // Start playing the new track
}
//
void previousTrack() {
  player.close(); // Stop the current track
  currentTrackIndex = (currentTrackIndex - 1 + tracks.length) % tracks.length; // Move to the previous track
  player = minim.loadFile(tracks[currentTrackIndex]); // Load the previous track
  player.play(); // Start playing the new track
}
//
void stop() {
  player.close();
  minim.stop();
  super.stop();
}
// End Main Program