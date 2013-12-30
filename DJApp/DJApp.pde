Maxim maxim;
AudioPlayer player1, player2;
PImage [] anim;
int currentImage;
boolean playing;
boolean recordOn1, recordOn2;
PImage tv;
PImage [] record1, record2;
int currentrecord1, currentrecord2;
float disc1x, disc1y;
float disc2x, disc2y;
float sliderx;
float speedAdjust = 1.0;
void setup() {
  rectMode(CENTER);
  imageMode(CENTER);
  maxim = new Maxim(this);
  player1 = maxim.loadFile("191273__erokia__float-eml-s-loop-1.wav");
  player1.setLooping(true);
  player2 = maxim.loadFile("156370__thecluegeek__techno-beat.wav");
  
  tv = loadImage("TV.png");
  record1 = loadImages("data/black-record_", ".png", 15);
  record2 = loadImages("data/black-record_", ".png", 15);
  anim = loadImages("Animation_data/people", ".jpg", 256);
  size(displayWidth/2, displayHeight - (displayHeight/8));
  
  sliderx = width/2;
  currentImage = 0;
  currentrecord1 = 0;
  currentrecord2 = 0;
  playing = false;
}

void draw() {
  background(0, 122, 122);
  stroke(122,122,0);
  fill(122, 122, 0);
  rect(width/2, height*(.85), width, height*.1);
  stroke(0);
  fill(0);
  rect(sliderx, height*(.85), width*.1, height*.1);
  
  float marginx = tv.width * .1;
  float marginy = tv.height * .1;
  if(recordOn1 | recordOn2) {
    player1.speed(speedAdjust);
    player2.speed((player1.getLengthMs()/ player2.getLengthMs()) * speedAdjust);
    currentImage += 1*speedAdjust;
  }

  if (currentImage < anim.length) {
    image(anim[currentImage], width/2, height/4, tv.width - marginx
      , tv.height - marginy);
    if (playing) {
      currentImage++;
    }
  } 
  else {
    currentImage = 0;
  }

  image(tv, width/2, height/4);
  disc1x = width/2 - (tv.width/2);
  disc1y = height/2 + (tv.height/4);
  disc2x = width/2 + (tv.width/2);
  disc2y = height/2 + (tv.height/4);

  if (currentrecord1 < record1.length) {
    image(record1[currentrecord1], disc1x, 
    disc1y);
    if (recordOn1) {
      currentrecord1++;
    }
  }
  else {
    currentrecord1 = 0;
  }
  
  if(currentrecord2 < record2.length) {
    image(record2[currentrecord2], disc2x, disc2y);
    if(recordOn2) {
    currentrecord2++;
    }
  }else{
    currentrecord2 = 0;
  }
}

void mousePressed() {
  float disc1 = dist(mouseX, mouseY, disc1x, disc1y);
  float disc2 = dist(mouseX, mouseY, disc2x, disc2y);
  if (disc1 < record1[0].width/2) {
    recordOn1 = !recordOn1;
    if (recordOn1) {
      player1.cue(0);
      player1.play();
    } else {
      player1.stop();
    }
    if(!recordOn2)
    playing = !playing;
  }
 
 if(disc2 < record2[0].width/2) {
   recordOn2 = !recordOn2;
   if(recordOn2) {
     player2.cue(0);
     player2.play();
   } else {
     player2.stop();
   }
   if(!recordOn1)
     playing = !playing;
 }
  
}

void mouseDragged() {
  if(mouseY > (height*.85) - (height*.05) & mouseY < (height*.85)
  + (height*.05)) {
    if(recordOn1 | recordOn2) {
    sliderx = mouseX;
    constrain(sliderx, width*.05, width - (width*.05));
    speedAdjust = map(mouseX, 0, width, 0, 2);
    } 
  }
}

