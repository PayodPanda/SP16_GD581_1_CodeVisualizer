
HomeButton homeButton;

class HomeButton extends Element{
    HomeButton(){
        super();
        
        paddingLeft = 5;
        paddingRight = 5;
        paddingTop = 5;
        paddingBottom = 5;
        
        w = sidebarWidth[1] - marginLeft - paddingLeft - paddingRight;
        h = marginTop - paddingTop - paddingBottom;
        
        position = new PVector(marginLeft + paddingLeft, paddingTop);
        
        mainColor = white;
        hoverColor = lGrey;
        clickedColor = yellow;
    }
    
    void onClick(){
        globalState = 0;
        onGlobalStateChange(0);
        for(int i=0; i<lessonCount; i++){
            lessons[i].selectedCheck = false;
            for(int j = 0; j<examples[i].length; j++){
                examples[i][j].selectedCheck = false;
            }
        }
    }
    
    void display(){
        if(globalState>0){
            super.display();
        }
    }
}