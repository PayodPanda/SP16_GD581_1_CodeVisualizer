

String[][] frameNames;
int[][] numFrames;

PImage[][] lessonIconFrames;
PImage[] lessonTexts;

PImage sidebarText;
float sidebarTextPosX, sidebarTextPosY, sidebarTextW, sidebarTextH, sidebarTextOpacity;

void initalizeVideos() {
    sidebarText = loadImage("/data/text/sidebarText.png");
    sidebarTextPosX = marginLeft;
    sidebarTextPosY = marginTop;
    sidebarTextW = sidebarWidth[globalState];
    sidebarTextH = 482;
    sidebarTextOpacity = 255;

    lessonTexts = new PImage[lessonCount];

    lessonIconFrames = new PImage[lessonCount][];    

    //numFrames[frameCount][offset in naming]
    int fr = 26;
    int offset = 104;
    numFrames = new int[][]{{360, 0}, 
        {26, 104}, 
        {151, 76}, 
        {259, 263}, 
        {84, 0}, 
        {fr, offset}, 
    };
    frameNames = new String[lessonCount][];

    for (int i=0; i<lessonCount; i++) {
        lessonTexts[i] = loadImage("/data/text/lessons/lessonText_" + i + ".png");
        lessonIconFrames[i] = new PImage[numFrames[i][0]];
        for (int j=0; j<numFrames[i][0]; j++) {
            lessonIconFrames[i][j] = loadImage("/data/icons/lessons/" + i + "/" + nf((j+numFrames[i][1]), 4) + ".png");
        }
    }
}