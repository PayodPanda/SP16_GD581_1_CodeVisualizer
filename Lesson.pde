

float currentLessonPosition, currentLessonWidth;

class Lesson extends Element {
    int index;
    float textWidth, textHeight;
    int currentFrame;

    Lesson(int n) {          
        index = n;        

        paddingLeft = 0;
        paddingRight = 0;
        paddingTop = 5;
        paddingBottom = 5;

        w = mainWidth[globalState] - paddingLeft - paddingRight;
        h = (effectiveHeight/lessonCount) - paddingTop - paddingBottom;

        position = new PVector(marginLeft + paddingLeft + sidebarWidth[globalState], marginTop + paddingTop + 1.0 * index * effectiveHeight/lessonCount);

        currentLessonPosition = position.x;


        currentLessonWidth = w;

        mainColor = lGrey;
        hoverColor = yellow;
        clickedColor = yellow;

        textWidth = w;
        textHeight = h;
        currentFrame = 0;
    }

    void onHover() {
        super.onHover();
        anyLessonHovered = true;
    }

    void onClick() {       // call this from global click event - mouseClicked(){}
        globalState = 1;
        onGlobalStateChange(1);
        super.onClick();
        clickAnimation = new FillAnimation((float)mouseX, (float)mouseY, marginLeft+sidebarWidth[1], marginTop + 5, mainWidth[globalState], effectiveHeight - 10, clickedColor, 1);
    }    

    void playAnimation() {
        if ((!anyLessonHovered && !anyLessonSelected && !anyExampleSelected) || hoverCheck || selectedCheck) {
            tint(255, 255);
        } else {
            tint(255, 64);
        }
            currentFrame++;
        image(lessonIconFrames[index][currentFrame % numFrames[index][0]], position.x, position.y, h, h);
        image(lessonTexts[index], position.x, position.y, textWidth, textHeight);
            tint(255, 255);
    }

    void update() {
        super.update();

        if (checkHover()) {
            onHover();
        }

        position.x = currentLessonPosition;
        w = currentLessonWidth;
        textWidth = map(currentLessonWidth, sidebarWidth[1], mainWidth[0], 0, mainWidth[0]);
        textHeight = map(currentLessonWidth, sidebarWidth[1], mainWidth[0], 0, h);
    }

    void display() {
        super.display();

        playAnimation();
    }
}