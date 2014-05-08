class GridController {
    
    int[][] pattern = { {0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,1,1,1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,1,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,1,1,0,0,1,1,1,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,1,1,0,1,1,1,1,1,1,0,1,1,0,1,0,0,1,1,1,1,0,0,0,0,0},
                        {0,0,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,0,0,0,0},
                        {0,1,1,1,1,1,1,1,1,0,0,1,1,0,1,1,1,0,1,1,1,1,1,1,0,0,0,0},
                        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0},
                      };
    
    int[][] strokedPattern = {{0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                              {0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                              {0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                              {0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                              {0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                              {0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                              {0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0},
                              {0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,1,1,0,0,0,0,0,0},
                              {0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,0,0,0,0,0},
                              {0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0},
                              {0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0},
                              {0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0},
                              {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0},
                              {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0},
                              {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                              };
 
    ArrayList<SDTriangle> triangles = new ArrayList<SDTriangle>();
    float triangleSize; // = height * 0.10f;
    float strokedSize;

    //int rows = int(random(20, 50));
    //int cols = int(random(6,15));
    
    float mScale = 1; //random(0.5, 3);
    float startY = height * 0.6; //height - (pattern.length * (triangleSize/2));
    float xOffset = -width;    
    
    int numSolidTriangles, numStrokedTriangles;
    int currNumSolidTriangles, currNumStrokedTriangles;
    
    float minEnterDuration = 5; // Triangle min entrance duration
    float maxEnterDuration = 10; // Triangle max max
    float minExitDuration = 5; // Triangle min exit duration
    float maxExitDuration = 10; // Triangle max exit duration
    
    PApplet pa;
    int h = height;
    float randomDestination = random(width * .05, width * .60);
    float randomStartPosition = random(width * .10, width * .60);

    
   
    GridController(PApplet _pa, float _size){
      pa = _pa;
      triangleSize = _size;
      strokedSize = _size * 0.5;
    }
    
    
    int randomRange(int min, int max, int step){
      float delta, range, rand;
      delta = max - min;
      range = delta / step;
      rand = random(100)/100;
      rand *= range;
      rand = floor(rand);
      rand *= step;
      rand += min;
      return int(rand);
    }
   
    
    void loopAni(){
      //Set numTriangles back
      //set random position
     float randomPosition = random(width*.10, width*0.5);
     
     currNumSolidTriangles = numSolidTriangles;
     currNumStrokedTriangles = numStrokedTriangles;
      
      
      for(int i=0; i< grid.triangles.size(); i++){
        //set destination
        triangles.get(i).x = xOffset;
        triangles.get(i).startAnimation(randomPosition, minEnterDuration, maxEnterDuration);
      }
    }
   
    void build(){  
    // Create solid triangles
    for (int i = 0; i < pattern.length; i++) {
        for(int j = 0; j < pattern[i].length; j++) {
          
            if(pattern[i][j] == 0){
              continue;
            } else {
              color tempC = rainbowColors[int(map(j, 0, pattern[i].length-1, 0, rainbowColors.length))];
              
              color c = color(red(tempC), green(tempC), blue(tempC), randomRange(10, 255, 5));
              
              boolean direction;
              if (i % 2 == 0) {
                  direction = j % 2 == 0 ? true : false;
              } else{
                  direction = j % 2 == 0 ? false : true;
              }
              
              PVector gridPosition = new PVector( (j * triangleSize) + 0,  startY + i * (triangleSize * 0.50f) );
              PVector origin = new PVector( (j * triangleSize) + xOffset,  startY + i * (triangleSize * 0.50f) );
              SDTriangle tri = new SDTriangle(pa, this, origin, gridPosition, triangleSize, direction, true, c, mScale);
              //println(tri.mOrigin.x + "   y: " + tri.mOrigin.y + "  trisize: " + tri.mSize + "   direction: " + tri.mOrientation);
              numSolidTriangles++;
              triangles.add(tri);
            }
        }        
    }
    
    
    // Create stroked triangles
    for (int i = 0; i < strokedPattern.length; i++) {
        for(int j = 0; j < strokedPattern[i].length; j++) {
          
          if(strokedPattern[i][j] == 0){
              continue;
            } else {
            
              boolean direction;
              
              if (i % 2 == 0) {
                  direction = j % 2 == 0 ? true : false;
              } else{
                  direction = j % 2 == 0 ? false : true;
              }
              
              PVector gridPosition = new PVector( (j * strokedSize) + 0,  startY + i * (strokedSize * 0.50f) );
              PVector origin = new PVector( (j * strokedSize) + xOffset, startY + i * (strokedSize * 0.50f));
              SDTriangle tri = new SDTriangle(pa, this, origin, gridPosition, strokedSize, direction, false, color(255,255,255, 100), mScale);
              numStrokedTriangles++;
              triangles.add(tri);
            }
        }
      }  
      
       currNumSolidTriangles = numSolidTriangles;
       currNumStrokedTriangles = numStrokedTriangles;

  }
  
}
