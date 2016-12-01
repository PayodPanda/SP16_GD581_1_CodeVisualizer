


class Looping {    
    PShape whole, flow;
    float padding = 30, margin = 75, lines = 220;
    int flag = 0;
    PFont font;

    Looping() {
        initialize();
    }

    void initialize() {
        whole = createShape(GROUP);
        flow = createShape(GROUP);
        noStroke();
        smooth(16);
        textMode(SHAPE);
        font = createFont("Consolas", 12);
        textFont(font);
    }

    void display() {


        //process();                           

        translate(0, 0, 1/* - (padding*(flag-1))*/);

        shape(whole);                    // everythng else
        shape(flow);                // flow lines
    }

    void displayFunctions() {
        fill(black);
        pushMatrix();
        {
            translate(0, 0, 2);
            text("start()", -30, -lines+32);
            translate(0, 0, padding * (flag-1));
            text("update()", -70, 36);
        }
        popMatrix();

        fill(white);

        pushMatrix();
        {
            rotateY(0);
            rect(-150, -250, 300, 500);
        }
        popMatrix();
    }

    void defineUpdateBound() {

        PShape update = createShape();        
        update.beginShape();
        {    
            float scaleFactor = 20 * sin(radians(2*flag));
            scaleFactor = 0;
            update.fill(cyan, 64);
            update.vertex(-80 - scaleFactor, 20 - scaleFactor, padding * (flag));
            update.vertex(80 + scaleFactor, 20 - scaleFactor, padding * (flag));
            update.vertex(80 + scaleFactor, 180 + scaleFactor, padding * (flag));
            update.vertex(-80 - scaleFactor, 180 + scaleFactor, padding * (flag));
            //update.vertex(0, 0, padding * (flag+1) -1);
        }
        update.endShape();         

        if (flag == 0) {
            fill(magenta, 164);
            whole.addChild(createShape(RECT, -40, -lines + 20, 80, 40));
        }

        whole.addChild(update);
    }

    void process() {                                            // this is the function that updates everything

        //defineFlowlines();            // flow lines, added to flow parent object
        //defineUpdateBound();            // update and start function boxes bounding

        //whole.addChild(drawVar());        // the variable

        flag++;  
        //drawVar();
    }

    void defineFlowlines() {
        // The main lines for the flow lines
        PShape s = createShape();
        s.beginShape();
        {
            s.noFill();
            s.stroke(0, 32);
            if (flag == 0) {
                s.vertex(0, -lines, padding * flag -1);
                s.vertex(0, lines, padding * flag -1);
                s.vertex(0, -lines, padding * flag -1);
            } else {
                s.vertex(0, lines, padding * (flag-1) -1);
                s.vertex(-margin, lines, padding * (flag-1) -1);
                s.vertex(-margin, 0, padding * (flag) -1);
                s.vertex(0, 0, padding * (flag) -1);
                s.vertex(0, lines, padding * (flag) -1);
            }
        }
        s.endShape();   

        PShape arrow1 = createShape();
        arrow1.beginShape();
        {    
            arrow1.noFill();
            arrow1.stroke(0, 32);
            arrow1.vertex(-10, lines-20, padding * flag - 1);
            arrow1.vertex(0, lines-10, padding * flag - 1);
            arrow1.vertex(10, lines-20, padding * flag - 1);
        }
        arrow1.endShape();  

        PShape arrow2 = createShape();
        arrow2.beginShape();
        {    
            arrow2.noFill();
            arrow2.stroke(0, 32);
            if (flag > 0) {
                arrow2.vertex(-margin - 10, 10 + lines/2, -padding/2 + padding * flag - 1 - (10*padding/lines));
                arrow2.vertex(-margin, lines/2, -padding/2 + padding * flag - 1);
                arrow2.vertex(-margin + 10, 10 + lines/2, -padding/2 + padding * flag - 1 - (10*padding/lines));
            }
        }
        arrow2.endShape();  

        flow.addChild(s);
        flow.addChild(arrow1);
        flow.addChild(arrow2);
    }

    void drawVar() {
        PShape varShape = createShape();
        pushMatrix();
        {    
            //translate(0,40,0);
            float scaleFactor = 0.3 * 150 * sin(radians(15*flag));
            //scale(scaleFactor);
            varShape.beginShape();
            {
                varShape.noStroke();
                varShape.fill(cyan);
                varShape.vertex(-1 * scaleFactor, -1 * scaleFactor + 100, 1 + flag * padding /*scaleFactor*/ * 1.0);
                varShape.fill(magenta);
                varShape.vertex(-1 * scaleFactor, 1 * scaleFactor + 100, 1 + flag * padding /*scaleFactor*/ * 1.0);
                varShape.fill(yellow);
                varShape.vertex(1 * scaleFactor, 1 * scaleFactor + 100, 1 + flag * padding /*scaleFactor*/ * 1.0);
                varShape.fill(black);
                varShape.vertex(1 * scaleFactor, -1 * scaleFactor + 100, 1 + flag * padding /*scaleFactor*/ * 1.0);
            }
            varShape.endShape();
        }
        popMatrix();
        //scale(1);
        //whole.addChild(varShape);
        //flag++;
        whole.addChild(varShape);
        //return varShape;
        //shape(whole);
    }
}