class Box {
 //top left corner
 PVector tl = new PVector();
 
 //width and height
 PVector wh = new PVector();
 
 //bools for alive and wall
 boolean alive = true;
 boolean wall;
 int lives = levell;
 
 //vector for image's source location
 PVector src = new PVector();
  PImage level1 = loadImage("black.jpg");
  PImage level2 = loadImage("green.jpg");
  PImage level3 = loadImage("blue.jpg");
  PImage level4 = loadImage("red.jpg");
  PImage level5 = loadImage("white.jpg");
 
 
 Box(float x1, float y1, float x2, float y2, boolean wall_){
   lives = levell;
   //Set the vectors for the top right, and the width and height
   tl.x = x1;
   tl.y = y1;
   wh.x = x2 - x1;
   wh.y = y2 - y1;
   //Set the wall boolean
   wall = wall_;
   //Set the src x and y positions from the pimage
   src.x = 50; //set random
   src.y = 50;
   //  Make sure to subtract the pimg's width and height to stay within the image
   src.x -= wh.x;
   src.y -= wh.y;
 }

 void draw(){
   //If it's alive, draw the rect
   if(alive){
     if(!wall){
       switch(lives){
         case 1:
         image(level1, tl.x, tl.y, wh.x, wh.y);
           break;
         case 2:
         image(level2, tl.x, tl.y, wh.x, wh.y);
           break;
         case 3:
         image(level3, tl.x, tl.y, wh.x, wh.y);
           break;
         case 4:
         image(level4, tl.x, tl.y, wh.x, wh.y);
           break;
         case 5:
         image(level5, tl.x, tl.y, wh.x, wh.y);
           break;
         default:
         image(level1, tl.x, tl.y, wh.x, wh.y);
           break;
       }
     
     }else {
     //Use copy to crop part of the pimage
       switch(levell){
         case 1:
         image(level1, tl.x, tl.y, wh.x, wh.y);
           break;
         case 2:
         image(level2, tl.x, tl.y, wh.x, wh.y);
           break;
         case 3:
         image(level3, tl.x, tl.y, wh.x, wh.y);
           break;
         case 4:
         image(level4, tl.x, tl.y, wh.x, wh.y);
           break;
         case 5:
         image(level5, tl.x, tl.y, wh.x, wh.y);
           break;
         default:
         image(level1, tl.x, tl.y, wh.x, wh.y);
           break;
       }
     }
   }
   else{
     dead++;
   }
 }
}
