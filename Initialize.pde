

Lesson[] lessons;
Example[][] examples;

int lessonCount;
int globalLesson;           // to store which lesson is currently SELECTED not hovered
int globalExample;           // to store which lesson is currently SELECTED not hovered
int globalExampleHover;           // to store which lesson is currently HOVERED
int globalState;        // 0 = homepage, 1 = construct, 2 = example

boolean anyLessonHovered = false;
boolean anyExampleHovered = false;
boolean anyLessonSelected = false;
boolean anyExampleSelected = false;

float[] sidebarWidth, mainWidth, secondaryWidth;
float marginTop, marginBottom, marginLeft, marginRight;
float effectiveWidth, effectiveHeight;

float boundingBoxWidth, boundingBoxHeight, boundingBoxX, boundingBoxY;
float boundingBoxOpacity, blueBoundingBoxOpacity;
float outputWindowWidth, outputWindowHeight, outputWindowX, outputWindowY;

void initialize() {
    lessonCount = 6;
    globalState = 0;
    globalLesson = -1;
    globalExample = -1;
    globalExampleHover = -1;

    marginTop = 60;
    marginBottom = 36;
    marginLeft = 0;
    marginRight = 0;
    effectiveWidth = (width-marginRight-marginLeft);
    effectiveHeight = (height-marginTop-marginBottom);

    //define the width for three states: 0: homepage, 1: construct viz, 2: example open
    sidebarWidth = new float[]{ 1 * effectiveWidth/6, (effectiveHeight/lessonCount) , (effectiveHeight/lessonCount) };
    mainWidth = new float[]{ 3 * effectiveWidth/6, 5.0 * effectiveWidth/6, 5.0 * effectiveWidth/6 };
    secondaryWidth = new float[]{ 2 * effectiveWidth/6, 0 * effectiveWidth/6, 0 * effectiveWidth/6 };
    
    boundingBoxX = marginLeft+sidebarWidth[0];
    boundingBoxY = marginTop;
    boundingBoxWidth = mainWidth[0];
    boundingBoxHeight = effectiveHeight;
    boundingBoxOpacity = 255;
    blueBoundingBoxOpacity = 0;
    outputWindowWidth = 0; 
    outputWindowHeight = 0;
    
    homeButton = new HomeButton();
    lessons = new Lesson[lessonCount];
    examples = new Example[lessonCount][];
    
    maxExampleCount = 4;
    
    int temp = 0;

    for (int i=0; i<lessonCount; i++) {
        lessons[i] = new Lesson(i);
        temp = floor(random(1, 5));

        examples[i] = new Example[temp];

        for (int j=0; j<temp; j++) {
            examples[i][j] = new Example(i, j);
        }
    }
}