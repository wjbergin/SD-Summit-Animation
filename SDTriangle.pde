class SDTriangle {
    float    mSize;
    boolean  mOrientation;
    color    mColor;
    PVector  mOrigin;
    boolean  mFill;
    float    startX;
    float    mStartTime;
    float    mEasing;
    float    mDestination_x;
    float    mDeltaDistance;
    boolean  mActive;
    boolean  mAlive;
    boolean  isAnimating;
    float    mScale;
    float    mLineWidth;
    float    mLifetime, mPauseDuration, mPauseEnd;
    boolean  mPaused;
    Ani      xAni;
    float    x;
    PApplet  pa;
    AniSequence seq;
    PVector gridPosition;


    int mLoopPause = 5000;
    GridController controller;


    SDTriangle(PApplet _pa, GridController _controller, PVector _origin, PVector _gridPosition, float _size, boolean _orientation, boolean _fill, color _color, float _scale){
      mSize = _size;
      mOrientation = _orientation;
      mColor = _color;
      mOrigin = _origin;
      mFill = _fill;
      mStartTime = random(1, 3000);
      mDestination_x = width + 500 + mOrigin.x;
      mDeltaDistance = mDestination_x - mOrigin.x;
      mActive = false;
      isAnimating = false;
      mAlive = true;
      mScale = _scale;
      x = _origin.x;
      //startX = _origin.x;
      controller = _controller;
      //mEasing = random(controller.easingMin, controller.easingMax) / 100;
      pa = _pa;
      gridPosition = _gridPosition;
      mLineWidth = mScale * 0.75f;

      startAnimation(controller.randomStartPosition, controller.minEnterDuration, controller.maxEnterDuration);
}


void startAnimation(float randomPosition, float minDuration, float maxDuration){
      seq = new AniSequence(pa);
      seq.beginSequence();
      seq.add(Ani.to(this, random(minDuration, maxDuration), "x", randomPosition + gridPosition.x, Ani.EXPO_IN_OUT));
      seq.add(Ani.to(this, random(minDuration, maxDuration), maxDuration + 2, "x", width * 1.1,  Ani.EXPO_IN_OUT, "onEnd:updateCounter"));
      seq.endSequence();
      // start the whole sequence
      seq.start();
}

void updateCounter(){


  if(mFill){
    controller.currNumSolidTriangles--;
  }else{
    controller.currNumStrokedTriangles--;
  }

  if(controller.currNumSolidTriangles == 0 && controller.currNumStrokedTriangles == 0){
    controller.loopAni();
  }

}

int randomEvenNumber(int min, int max)
{
    int i = int(min + (random(100)/100) % (max - min + 1));
    return i;
}

void update(){

    if( millis() > mStartTime && !mPaused )
    {
        mActive = true;
    }

    // animate
    if( mActive && mDeltaDistance >= 1 ){

        x += mDeltaDistance * mEasing;
        mDeltaDistance = mDestination_x - mOrigin.x;
    } else if (mActive && mDeltaDistance < 1){

        mActive = false;
        mPaused = true;
        mPauseEnd = millis() + mPauseDuration;
        mDestination_x = width + 100;
        mDeltaDistance = mDestination_x - mOrigin.x;
    }

    if(millis() > mPauseEnd)
    {
        mActive = true;
    }

    // Reset to initial position and pause
    if(x > width)
    {
        mAlive = false;
        x = startX;
        mStartTime = millis() + mLoopPause;
    }

}

void draw(){

    if (mFill){
        // Filled triangle
        //smooth();
        noStroke();
        fill(mColor);
    } else {
        // Stroked triangle
        //smooth();
        strokeJoin(MITER);
        strokeCap(SQUARE);
        strokeWeight(1.5);
        stroke(255, 255, 255, 50);
        noFill();
    }
    if (mOrientation) {
        // Facing right
        triangle(x, mOrigin.y,
                 x + mSize, mOrigin.y + (mSize * 0.5f),
                 x, mOrigin.y + mSize);

    } else {
        // Facing left
        triangle(x + mSize, mOrigin.y,
                 x, mOrigin.y + (mSize * 0.5f),
                 x + mSize, mOrigin.y + mSize);
        }
    }
}
