

import peasy.*;
PeasyCam cam;

PFont font;

void setup() {
    size(displayWidth, displayHeight, P3D);
    cam = new PeasyCam(this, 0, 0, 0, 700);

    font = createFont("Consolas", 24);
    textFont(font);

    initialize();
    aniInitialize();
    initalizeVideos();
    initializeFunctions();
}

void draw() {
    println(globalExample);
    println(globalLesson);
    noStroke();
    background(white);

    cam.beginHUD();
    {
        fill(yellow);
        rect(boundingBoxX, boundingBoxY, boundingBoxWidth, boundingBoxHeight);

        fill(cyan, blueBoundingBoxOpacity);
        rect(boundingBoxX, boundingBoxY, boundingBoxWidth, boundingBoxHeight);

        if ((anyLessonSelected || anyExampleSelected) && (clickAnimation != null)) {
            clickAnimation.display();
        }
    }
    cam.endHUD();

    switch(globalLesson) {
    case 0:
        //variable.displayFunctions();
        variable.drawVar();
        variable.display();
        break;

    case 1:
        loop.displayFunctions();
        loop.display();
        break;

    case 2:
        break;

    case 3:
        break;

    case 4:
        break;

    case 5:
        break;
    }

    switch(globalExample) {
    case 0:
        //variable.displayFunctions();
        variable.drawVar();
        variable.display();
        break;

    case 1:
        loopVariable.displayFunctions();
        loopVariable.drawVar();
        loopVariable.display();
        break;

    case 2:
        break;

    case 3:
        break;

    case 4:
        break;

    case 5:
        break;
    }

    cam.beginHUD();
    {

        fill(black, blueBoundingBoxOpacity);
        if(globalExample == 1) {
            fill(black);
            text("function start(){\n    size(400, 800);\n}\n\nfunction update(){\n    var size = sin(frameCount);\n    background(255 * size);\n}", boundingBoxX + 20, boundingBoxY + 20);
            fill(map(sin(radians(15*loopVariable.flag)), -1, 1, 0, 255));
        }
        rect(boundingBoxX + boundingBoxWidth - 20, boundingBoxY + 20, outputWindowWidth, outputWindowHeight);
        
        
        beginShape();
        {
            fill(white);
            noStroke();
            vertex(0, 0);
            vertex(width, 0);
            vertex(width, height);
            vertex(0, height);
            beginContour();
            {
                vertex(boundingBoxX, boundingBoxY);
                vertex(boundingBoxX, boundingBoxY + boundingBoxHeight);
                vertex(boundingBoxX + boundingBoxWidth, boundingBoxY + boundingBoxHeight);
                vertex(boundingBoxX + boundingBoxWidth, boundingBoxY);
            }
            endContour();
        }
        endShape();

        for (int i=0; i<lessonCount; i++) {
            lessons[i].update();
            lessons[i].display();

            anyLessonSelected = false;
            anyLessonHovered = false;
            for (int temp = 0; temp<lessonCount; temp++) {
                anyLessonSelected = anyLessonSelected || lessons[temp].selectedCheck;
                anyLessonHovered = anyLessonHovered || lessons[temp].hoverCheck;
            }

            for (int j=0; j<examples[i].length; j++) {
                examples[i][j].update();
                examples[i][j].display();

                anyExampleSelected = false;
                anyExampleHovered = false;
                for (int tempI = 0; tempI<lessonCount; tempI++) {
                    for (int tempJ = 0; tempJ<examples[tempI].length /*  this is a max of four */; tempJ++) {                        // for all examples,
                        anyExampleHovered = anyExampleHovered || examples[tempI][tempJ].hoverCheck;
                        anyExampleSelected = anyExampleSelected || examples[tempI][tempJ].selectedCheck;
                    }
                }
            }
        }

        //if (globalState == 0) {
        tint(255, sidebarTextOpacity);
        image(sidebarText, sidebarTextPosX, sidebarTextPosY, sidebarTextW, sidebarTextH);
        //}

        homeButton.display();
        homeButton.update();
        //println(globalState);
    }
    cam.endHUD();
    
    //saveFrame("data/tiff/####.tiff");
    
}

void mousePressed() {

    if (homeButton.hoverCheck) {
        homeButton.onClick();
    }

    for (int i=0; i<lessonCount; i++) {
        if (lessons[i].checkHover()) {                                                                // do this if I click on a lesson element
            lessons[i].onClick();
            lessons[i].selectedCheck = true;
            globalLesson = i;
            //anyLessonSelected = true;
        } else {                                                                                        // do this if click was outisde this lesson
            if (anyLessonHovered || anyExampleHovered) lessons[i].selectedCheck = false;
        }

        for (int j=0; j<examples[i].length /*  this is a max of four */; j++) {                        // for all examples,
            if (examples[i][j].checkHover()) {                                                            // do this if an example is clicked
                globalExample = i;
                examples[i][j].onClick();
                examples[i][j].selectedCheck = true;
            } else {
                if (anyLessonHovered || anyExampleHovered) examples[i][j].selectedCheck = false;
            }
        }

        for (int j=0; j<examples[i].length /*  this is a max of four */; j++) {
            if (examples[i][j].rowHovered) {                                                                            // do this for all elements in a selected row of examples
                examples[i][j].transitionSort();
            } else {
                if (anyLessonHovered || anyExampleHovered) examples[i][j].transitionOut();
            }
        }
    }
}

void keyPressed() {


    switch(globalLesson) {
    case 0:
        //variable.defineUpdateBound();
        //variable.defineFlowlines();
        variable.process();

        break;

    case 1:
        loop.defineUpdateBound();
        loop.defineFlowlines();
        loop.process();
        break;

    case 2:
        break;

    case 3:
        break;

    case 4:
        break;

    case 5:
        break;
    }
    
    switch(globalExample) {
    case 0:
        //variable.defineUpdateBound();
        //variable.defineFlowlines();
        //variable.process();

        break;

    case 1:
        loopVariable.defineUpdateBound();
        //loopVariable.defineFlowlines();
        loopVariable.process();
        break;

    case 2:
        break;

    case 3:
        break;

    case 4:
        break;

    case 5:
        break;
    }
}

void rect(PVector p, float w, float h) {
    rect(p.x, p.y, w, h);
}

void onGlobalStateChange(int state) {

    switch(state) {
    case 0:
        globalLesson = -1;
        globalExample = -1;
        Ani.to(this, 0.6, "boundingBoxX", marginLeft+sidebarWidth[0], Ani.QUAD_IN_OUT);
        Ani.to(this, 0.6, "boundingBoxY", marginTop, Ani.QUAD_IN_OUT);
        Ani.to(this, 0.8, "boundingBoxWidth", mainWidth[0], Ani.QUAD_IN_OUT);
        Ani.to(this, 0.8, "boundingBoxHeight", effectiveHeight, Ani.QUAD_IN_OUT);

        Ani.to(this, 0.6, "sidebarTextPosX", marginLeft, Ani.QUAD_IN_OUT);
        Ani.to(this, 0.6, "sidebarTextPosY", marginTop, Ani.QUAD_IN_OUT);
        Ani.to(this, 0.8, "sidebarTextW", sidebarWidth[globalState], Ani.QUAD_IN_OUT);
        Ani.to(this, 0.8, "sidebarTextH", 482, Ani.QUAD_IN_OUT);
        Ani.to(this, 1, "sidebarTextOpacity", 255, Ani.QUAD_IN);

        Ani.to(this, 1, "blueBoundingBoxOpacity", 0, Ani.QUAD_IN);
        Ani.to(this, 1, "outputWindowWidth", 0, Ani.QUAD_IN_OUT);
        Ani.to(this, 1, "outputWindowHeight", 0, Ani.QUAD_IN_OUT);

        Ani.to(this, 1, "currentLessonPosition", marginLeft + sidebarWidth[0], Ani.QUAD_IN_OUT);
        Ani.to(this, 0.6, "currentLessonWidth", mainWidth[0], Ani.QUAD_IN_OUT);
        break;

    case 1:
        globalExample = -1;
        Ani.to(this, 0.8, "boundingBoxX", marginLeft+sidebarWidth[1], Ani.QUAD_IN_OUT);
        Ani.to(this, 0.8, "boundingBoxY", marginTop + 5, Ani.QUAD_IN_OUT);
        Ani.to(this, 1, "boundingBoxWidth", mainWidth[1], Ani.QUAD_IN_OUT);
        Ani.to(this, 1, "boundingBoxHeight", effectiveHeight - 10, Ani.QUAD_IN_OUT);

        Ani.to(this, 0.6, "sidebarTextPosX", -100, Ani.QUAD_IN);
        Ani.to(this, 0.6, "sidebarTextPosY", marginTop, Ani.QUAD_IN);
        Ani.to(this, 1.5, "sidebarTextW", 0, Ani.QUAD_IN);
        Ani.to(this, 1.5, "sidebarTextH", 0, Ani.QUAD_IN);
        Ani.to(this, 1, "sidebarTextOpacity", 0, Ani.QUAD_IN);

        Ani.to(this, 1, "blueBoundingBoxOpacity", 0, Ani.QUAD_IN);
        Ani.to(this, 1, "outputWindowWidth", 0, Ani.QUAD_IN_OUT);
        Ani.to(this, 1, "outputWindowHeight", effectiveHeight - 50, Ani.QUAD_IN_OUT);

        Ani.to(this, 1.4, "currentLessonPosition", marginLeft, Ani.QUAD_IN_OUT);
        Ani.to(this, 1.2, "currentLessonWidth", sidebarWidth[1], Ani.QUAD_IN_OUT);
        break;

    case 2:
        globalLesson = -1;
        Ani.to(this, 0.8, "boundingBoxX", marginLeft+sidebarWidth[1]+20, Ani.QUAD_IN_OUT);
        Ani.to(this, 0.8, "boundingBoxY", marginTop + 5, Ani.QUAD_IN_OUT);
        Ani.to(this, 1, "boundingBoxWidth", mainWidth[2], Ani.QUAD_IN_OUT);
        Ani.to(this, 1, "boundingBoxHeight", effectiveHeight - 10, Ani.QUAD_IN_OUT);

        Ani.to(this, 0.6, "sidebarTextPosX", -100, Ani.QUAD_IN);
        Ani.to(this, 0.6, "sidebarTextPosY", marginTop, Ani.QUAD_IN);
        Ani.to(this, 1.5, "sidebarTextW", 0, Ani.QUAD_IN);
        Ani.to(this, 1.5, "sidebarTextH", 0, Ani.QUAD_IN);
        Ani.to(this, 1, "sidebarTextOpacity", 0, Ani.QUAD_IN);

        Ani.to(this, 1, "blueBoundingBoxOpacity", 255, Ani.QUAD_IN);        
        Ani.to(this, 1, "outputWindowWidth", -mainWidth[2]/3, Ani.QUAD_IN_OUT);
        Ani.to(this, 1, "outputWindowHeight", effectiveHeight - 50, Ani.QUAD_IN_OUT);

        Ani.to(this, 1, "currentLessonPosition", marginLeft, Ani.QUAD_IN_OUT);
        Ani.to(this, 0.6, "currentLessonWidth", sidebarWidth[2], Ani.QUAD_IN_OUT);
        break;
    }
}