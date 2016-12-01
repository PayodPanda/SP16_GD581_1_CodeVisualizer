
class Element {
    PVector position;
    float w, h;
    int paddingLeft, paddingRight, paddingTop, paddingBottom;
    color hoverColor, mainColor, clickedColor;
    boolean hoverCheck, selectedCheck;

    Element() {        
        hoverCheck = false;
        selectedCheck = false;
    }

    boolean checkHover() {
        if ( (mouseX > position.x) && (mouseX < position.x + w) && (mouseY > position.y) && (mouseY < position.y + h) ) {
            if (!hoverCheck) {                                                                                                            // this is the first time it's hovered - onHoverEnter
                hoverAnimation = new FillAnimation((float)mouseX, (float)mouseY, position.x, position.y, w, h, hoverColor, 0.3);
            }
            return true;
        }        
        return false;
    }

    void onHover() {
        rect(position, w, h);
        hoverAnimation.display();
    }

    void onClick() {       // call this from global click event - mouseClicked(){}
        selectedCheck = true;
        /*
        Ani.to(this, 1, "boundingBoxOpacity", 0, Ani.QUART_OUT);
        Ani.to(this, 1, "blueBoundingBoxOpacity", 0, Ani.QUART_OUT);
        */
    }

    void update() {
        hoverCheck = checkHover();
    }

    void display() {

        noStroke();
        fill(mainColor);
        if (selectedCheck) {
            fill(clickedColor);
        }
        if (hoverCheck) {
            //fill(hoverColor);
            onHover();
        } else {
            rect(position, w, h);
        }
    }
}