
int maxExampleCount;

class Example extends Element {
    int indexI, indexJ;
    float posX, posY;
    float opacity;
    float initialPosX, initialPosY, initialW, initialH;
    float initialOpacity;
    boolean hoverExample;
    boolean rowHovered, rowSelected;
    int tempState;

    Example(int m, int n) {
        tempState = 0;

        indexI = m;
        indexJ = n;


        //currentLessonPosition = position.x;

        paddingLeft = 20;
        paddingRight = 20;
        paddingTop = 20;
        paddingBottom = 20;

        h = (effectiveHeight/lessonCount) - paddingTop - paddingBottom;
        w = h;

        position = new PVector(marginLeft + paddingLeft + sidebarWidth[globalState] + mainWidth[globalState] + (indexJ * secondaryWidth[globalState]/4.0), marginTop + paddingTop + 1.0 * indexI * effectiveHeight/lessonCount);
        posX = position.x;
        posY = position.y;

        mainColor = lGrey;
        hoverColor = cyan;
        clickedColor = cyan;
        opacity = 255;

        hoverExample = false;
        initialPosX = position.x;
        initialPosY = position.y;
        initialW = w;
        initialH = h; 
        initialOpacity = 255;
    }

    void transitionSort() {
        float delay = indexJ * 0.2;

        Ani.to(this, 0.6, delay, "w", (effectiveHeight/lessonCount) - paddingTop - paddingBottom, Ani.QUAD_IN);
        Ani.to(this, 0.6, delay, "h", (effectiveHeight/lessonCount) - paddingTop - paddingBottom, Ani.QUAD_IN);
        Ani.to(this, 1, delay, "posX", marginLeft + paddingLeft + sidebarWidth[0] + mainWidth[0] + (3 * secondaryWidth[0]/4.0), Ani.SINE_IN_OUT);
        Ani.to(this, 1.4, delay, "posY", marginTop + paddingTop + indexJ * (effectiveHeight/lessonCount), Ani.QUAD_IN_OUT);
        Ani.to(this, 0.6, delay, "opacity", 255, Ani.QUAD_IN);
    }

    void transitionOut() {
        float delay = indexJ * 0.1;
        Ani.to(this, 0.6, delay, "w", 0, Ani.QUAD_IN);
        Ani.to(this, 0.6, delay, "h", 0, Ani.QUAD_IN);
        Ani.to(this, 1, delay, "posX", width+ 5*w, Ani.QUAD_IN);
        Ani.to(this, 1.4, delay, "posY", -5*marginTop + indexJ * (effectiveHeight/lessonCount), Ani.EXPO_IN);
        Ani.to(this, 0.6, delay, "opacity", 0, Ani.QUAD_IN);
    }

    void onStateChange(int state) {
        println("hi there");
        float delay = indexJ * 0.1;
        switch(state) {
        case 0:
            Ani.to(this, 0.6, delay, "w", initialW, Ani.QUAD_OUT);
            Ani.to(this, 0.6, delay, "h", initialH, Ani.QUAD_OUT);
            Ani.to(this, 1, delay, "posX", initialPosX, Ani.QUAD_OUT);
            Ani.to(this, 1.4, delay, "posY", initialPosY, Ani.EXPO_OUT);
            Ani.to(this, 0.6, delay, "opacity", initialOpacity, Ani.QUAD_OUT);
            break;

        case 1:
            /*Ani.to(this, 0.6, delay, "w", 0, Ani.QUAD_IN);
            Ani.to(this, 0.6, delay, "h", 0, Ani.QUAD_IN);
            Ani.to(this, 1, delay, "posX", width+ 5*w, Ani.QUAD_IN);
            Ani.to(this, 1.4, delay, "posY", -5*marginTop + indexJ * (effectiveHeight/lessonCount), Ani.EXPO_IN);
            Ani.to(this, 0.6, delay, "opacity", 0, Ani.QUAD_IN);*/
            break;

        case 2:
            /*Ani.to(this, 0.6, delay, "w", 0, Ani.QUAD_IN);
            Ani.to(this, 0.6, delay, "h", 0, Ani.QUAD_IN);
            Ani.to(this, 1, delay, "posX", width+ 5*w, Ani.QUAD_IN);
            Ani.to(this, 1.4, delay, "posY", -5*marginTop + indexJ * (effectiveHeight/lessonCount), Ani.EXPO_IN);
            Ani.to(this, 0.6, delay, "opacity", 0, Ani.QUAD_IN);*/
            break;
        }
    }

    boolean checkRowHover() {
        boolean temp = false;
        for (int j=0; j<examples[indexI].length; j++) {
            temp = temp || examples[indexI][j].hoverCheck;
        }
        temp = temp || lessons[indexI].hoverCheck;
        return temp;
    }

    void onHover() {
        super.onHover();
    }

    void onClick() {       // call this from global click event - mouseClicked(){}
        globalState = 2;
        onGlobalStateChange(2);
        super.onClick();
        clickAnimation = new FillAnimation((float)mouseX, (float)mouseY, marginLeft+sidebarWidth[1] + 20, marginTop + 5, mainWidth[globalState], effectiveHeight - 10, clickedColor, 1);
    }    

    void update() {
        super.update();

        rowHovered = checkRowHover();
        position.x = posX;
        position.y = posY;

        if (globalState != tempState) {
            onStateChange(globalState);
            tempState = globalState;
        }
    }

    void display() {

        noStroke();

        fill(mainColor, opacity);

        if (rowHovered) {
            strokeWeight(2);
            stroke(hoverColor);
        } else {
            noStroke();
        }

        if (selectedCheck) {
            fill(clickedColor);
        }

        if (hoverCheck) {
            onHover();
            strokeWeight(5);
            stroke(hoverColor);
            //fill(hoverColor);
        } else {
            rect(position, w, h);
        }
    }
}