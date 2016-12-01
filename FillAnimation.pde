
FillAnimation hoverAnimation;
FillAnimation clickAnimation;
FillAnimation backgroundAnimation;

class FillAnimation {

    float centerX, centerY, posX, posY, w, h, radius;
    color c;

    FillAnimation() {
    }

    FillAnimation(float _centerX, float _centerY, float _posX, float _posY, float _w, float _h, color _c, float _t) {
        centerX = _centerX;
        centerY = _centerY;
        posX = _posX;
        posY = _posY;
        radius = 0;
        w = _w;
        h = _h;
        c = _c;
        Ani.to(this, _t, "radius", sqrt(2.3)*w, Ani.QUART_IN);
    }

    void display() {
        int circleRes = 36;
        PShape fillShape = createShape();
        float x, y;
        fillShape.beginShape();
        for (int i=0; i<circleRes; i++) {
            x = centerX + (radius * cos(2.0*PI*i / circleRes));
            y = centerY + (radius * sin(2.0*PI*i / circleRes));

            if (x < posX) {
                x = posX;
            }
            if (x > posX + w) {
                x = posX + w;
            }
            if (y < posY) {
                y = posY;
            }
            if (y > posY + h) {
                y = posY + h;
            }

            fillShape.fill(c);
            fillShape.noStroke();

            //colorMode(HSB, 360, 100, 100);

            fillShape.vertex(x, y);
        }
        fillShape.endShape();
        shape(fillShape);
        /*
        // once animation is complete,
        if(radius > w * sqrt(2)){
            boundingBoxOpacity = 100;
            blueBoundingBoxOpacity = 100;
        }
        */
    }
}