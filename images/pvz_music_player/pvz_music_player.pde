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
AudioPlayer[] playList = new AudioPlayer[2]; // Array to hold two songs
int currentSongIndex = 0; // Index of the currently playing song
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
  playList[0] = minim.loadFile("Crazy Dave (Intro Theme) _ Laura Shigihara.mp3"); // First song
  playList[1] = minim.loadFile("pvz_music_player\\Loonboon _ Laura Shigihara.mp3"); // Second song
  playList[currentSongIndex].play(); // Start with the first song
} //End setup
//
void draw() {
  image(myFirstImage, imageDivX, imageDivY, imageWidthChanged, imageHeightChanged); // Display image with corrected dimensions

  // Draw buttons
  fill(0, 255, 0); // Green for Play
  rect(50, appHeight - 300, 100, 40);
  fill(255);
  text("Play", 100, appHeight - 280);

  fill(255, 0, 0); // Red for Pause
  rect(50, appHeight - 250, 100, 40);
  fill(255);
  text("Pause", 100, appHeight - 230);

  fill(0); // Black for Stop
  rect(50, appHeight - 200, 100, 40);
  fill(255);
  text("Stop", 100, appHeight - 180);

  fill(0, 0, 255); // Blue for Loop Once
  rect(50, appHeight - 150, 100, 40);
  fill(255);
  text("Loop Once", 100, appHeight - 130);

  fill(0, 0, 128); // Dark Blue for Loop Infinite
  rect(50, appHeight - 100, 100, 40);
  fill(255);
  text("Loop Infinite", 100, appHeight - 80);

  fill(255, 165, 0); // Orange for Fast Forward
  rect(200, appHeight - 300, 100, 40);
  fill(255);
  text("Fast Forward", 250, appHeight - 280);

  fill(255, 140, 0); // Dark Orange for Fast Rewind
  rect(200, appHeight - 250, 100, 40);
  fill(255);
  text("Fast Rewind", 250, appHeight - 230);

  fill(128, 128, 128); // Gray for Mute
  rect(200, appHeight - 200, 100, 40);
  fill(255);
  text("Mute", 250, appHeight - 180);

  fill(255, 255, 0); // Yellow for Next Song
  rect(200, appHeight - 150, 100, 40);
  fill(0);
  text("Next Song", 250, appHeight - 130);

  fill(255, 255, 0); // Yellow for Previous Song
  rect(200, appHeight - 100, 100, 40);
  fill(0);
  text("Previous Song", 250, appHeight - 80);

  fill(75, 0, 130); // Indigo for Shuffle
  rect(350, appHeight - 300, 100, 40);
  fill(255);
  text("Shuffle", 400, appHeight - 280);

  fill(255, 0, 255); // Magenta for Exit
  rect(350, appHeight - 250, 100, 40);
  fill(255);
  text("Exit", 400, appHeight - 230);
} //End draw
//
void mousePressed() {
  if (mouseX >= 50 && mouseX <= 150 && mouseY >= appHeight - 300 && mouseY <= appHeight - 260) {
    playList[currentSongIndex].play(); // Play
  }
  if (mouseX >= 50 && mouseX <= 150 && mouseY >= appHeight - 250 && mouseY <= appHeight - 210) {
    playList[currentSongIndex].pause(); // Pause
  }
  if (mouseX >= 50 && mouseX <= 150 && mouseY >= appHeight - 200 && mouseY <= appHeight - 160) {
    playList[currentSongIndex].pause();
    playList[currentSongIndex].rewind(); // Stop
  }
  if (mouseX >= 50 && mouseX <= 150 && mouseY >= appHeight - 150 && mouseY <= appHeight - 110) {
    playList[currentSongIndex].loop(1); // Loop Once
  }
  if (mouseX >= 50 && mouseX <= 150 && mouseY >= appHeight - 100 && mouseY <= appHeight - 60) {
    playList[currentSongIndex].loop(); // Loop Infinite
  }
  if (mouseX >= 200 && mouseX <= 300 && mouseY >= appHeight - 300 && mouseY <= appHeight - 260) {
    playList[currentSongIndex].skip(10000); // Fast Forward
  }
  if (mouseX >= 200 && mouseX <= 300 && mouseY >= appHeight - 250 && mouseY <= appHeight - 210) {
    playList[currentSongIndex].skip(-10000); // Fast Rewind
  }
  if (mouseX >= 200 && mouseX <= 300 && mouseY >= appHeight - 200 && mouseY <= appHeight - 160) {
    if (playList[currentSongIndex].isMuted()) {
      playList[currentSongIndex].unmute(); // Unmute
    } else {
      playList[currentSongIndex].mute(); // Mute
    }
  }
  if (mouseX >= 200 && mouseX <= 300 && mouseY >= appHeight - 150 && mouseY <= appHeight - 110) {
    // Next Song
    playList[currentSongIndex].close();
    currentSongIndex = (currentSongIndex + 1) % playList.length; // Switch to the next song
    playList[currentSongIndex].play();
  }
  if (mouseX >= 200 && mouseX <= 300 && mouseY >= appHeight - 100 && mouseY <= appHeight - 60) {
    // Previous Song
    playList[currentSongIndex].close();
    currentSongIndex = (currentSongIndex - 1 + playList.length) % playList.length; // Switch to the previous song
    playList[currentSongIndex].play();
  }
  if (mouseX >= 350 && mouseX <= 450 && mouseY >= appHeight - 300 && mouseY <= appHeight - 260) {
    // Shuffle
    playList[currentSongIndex].close();
    playList[currentSongIndex] = minim.loadFile("RandomSong.mp3"); // Replace with actual shuffle logic
    playList[currentSongIndex].play();
  }
  if (mouseX >= 350 && mouseX <= 450 && mouseY >= appHeight - 250 && mouseY <= appHeight - 210) {
    exit(); // Exit
  }
} //End mousePressed
//
void keyPressed() {
  if (key == 'p') {
    playList[currentSongIndex].play();  // Play audio on 'p' key press
  }
  if (key == 's') {
    playList[currentSongIndex].pause(); // Pause audio on 's' key press
  }
}
//
void stop() {
  for (AudioPlayer player : playList) {
    player.close();
  }
  minim.stop();
  super.stop();
}
// End Main Program