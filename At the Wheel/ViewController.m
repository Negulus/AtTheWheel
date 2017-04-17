//
//  ViewController.m
//  At the Wheel
//
//  Created by Negulus on 4/12/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#import "ViewController.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

@interface ViewController ()
    @property (strong, nonatomic) EAGLContext *context;
    @property (strong, nonatomic) GLKBaseEffect *effect;
    -(void)setupGL;
    -(void)tearDownGL;
@end

@implementation ViewController

- (void)dealloc
{
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    
    [_context release];
    [_effect release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2] autorelease];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.multipleTouchEnabled = true;
    Game_Data.view = view;
    
    Game_Root = [[Game alloc] init : &Game_Data];
    [self setupGL];
    [self GameInit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }

    // Dispose of any resources that can be recreated.
}

int touch_l;
int touch_r;
int idi;

-(void)GameInit
{
    appDelegate = [[UIApplication sharedApplication]delegate];
    
    Game_Data.World_Num[0] = 20;
    Game_Data.World_Num[1] = 0;
    Game_Data.World_Num[2] = 0;
    Game_Data.Worlds = sizeof(Game_Data.World_Num) / sizeof(Game_Data.World_Num[0]);
    Game_Data.Set_World = 0;
    Game_Data.Status_Curent = Stat_Null;
    Game_Data.Status_Next = Stat_MenuMain;
    Game_Data.Status_Next_en = false;
    Game_Data.Status_Next_tmp = 0;
    Game_Data.firm_id = 432;
    [Game_Root CreateObject2D: &Game_Data.Loading : Game_Data.Game_Center - 568 : 0 : 1136 : 640 : [Game_Root Load_Texture:@"menu_loading"]];
    
    Game_Data.Menu_Main_Pos = 0;
    Game_Data.Menu_Sel_Pos = 0;
    
    Game_Data.Accel[0] = appDelegate.accel_x;
    Game_Data.Accel[1] = appDelegate.accel_y;
    Game_Data.Accel[2] = appDelegate.accel_z;
    
    [Game_Root Reset_Data];
    if (![Game_Root Load_Data])
        [Game_Root Save_Data : 2];
    [Game_Root Check_Data];
    
//    [Game_Root Check_Data];
    
    touch_l = 0;
    touch_r = 0;
    idi = 0;
}

GLKVector4 tmpv;

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = [[[GLKBaseEffect alloc] init] autorelease];
    Game_Data.effect = self.effect;
    
    if (self.view.bounds.size.height > 480)
        Game_Data.Game_Width = 1136;
    else
        Game_Data.Game_Width = 960;
    
    Game_Data.Game_Center = Game_Data.Game_Width / 2;
    
//    self.effect.light0.enabled = GL_TRUE;
    Game_Data.light = true;
    self.effect.light0.position = GLKVector4Make(-50.0f, 50.0f, 2.0f, 0.04f);
    self.effect.light0.diffuseColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    self.effect.light0.specularColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    self.effect.light0.ambientColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    
    self.effect.light1.position = GLKVector4Make(100.0f, 50.0f, 0.0f, 0.0f);
    self.effect.light1.diffuseColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    self.effect.light1.specularColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    self.effect.light1.ambientColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    tmpv = self.effect.light0.position;
    
    glEnable(GL_DEPTH_TEST);
    
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    glGenVertexArraysOES(1, &Game_Data.Array_2D);
    glGenBuffers(1, &Game_Data.BufferPos_2D);
    glGenBuffers(1, &Game_Data.BufferTex_2D);
    glGenBuffers(1, &Game_Data.BufferCol_2D);
    glBindVertexArrayOES(0);
    
    Game_Data.ViewMatrix3D = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(45.0f), fabsf(self.view.bounds.size.height / self.view.bounds.size.width), 0.1f, 3000.0f);
    Game_Data.ViewMatrix2D = GLKMatrix4MakeOrtho(0, self.view.bounds.size.height, self.view.bounds.size.width, 0, -1.0f, 1.0f);
    
    //Настройка камеры
    Game_Data.HUDMatrix = GLKMatrix4MakeTranslation(0, 0, 0);
    //        Game_Data->HUDMatrix = GLKMatrix4Rotate(Game_Data->HUDMatrix, GLKMathDegreesToRadians(90), 0.0f, 0.0f, 1.0f);
    Game_Data.HUDMatrix = GLKMatrix4Scale(Game_Data.HUDMatrix, 0.5f, 0.5f, 0.0f);
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix3D;
    
    self.effect.texture2d0.envMode = GLKTextureEnvModeModulate;
    self.effect.texture2d0.target = GLKTextureTarget2D;
    self.effect.texture2d0.enabled = true;
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = nil;
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    self.effect.light0.position = tmpv;
    Game_Data.timeSinceLastUpdate = self.timeSinceLastUpdate;
    
    Game_Data.Accel[0] = appDelegate.accel_x;
    Game_Data.Accel[1] = appDelegate.accel_y;
    Game_Data.Accel[2] = appDelegate.accel_z;
        
    if (Game_Data.Status_Next_en)
    {
        Game_Data.Status_Next = Game_Data.Status_Next_tmp;
        Game_Data.Status_Next_tmp = 0;
        Game_Data.Status_Next_en = false;
    }
    
    [self ChangeStat];

    if (Game_Data.Status_Next_tmp == 0)
    {
        switch (Game_Data.Status_Curent)
        {
            case Stat_MenuMain:
                [Menu_Main Update];
                break;
            case Stat_MenuSet:
                [Menu_Set Update];
                break;
            case Stat_MenuSelect:
                [Menu_Select Update];
                break;
            case Stat_MenuThank:
                [Menu_Thank Update];
                break;
            case Stat_MenuHelp:
                [Menu_Help Update];
                break;
            case Stat_Play:
            case Stat_Win:
            case Stat_Lose:
            case Stat_Pause:
                [Game_Play Update];
                break;
            case Stat_NewGame:
                [New_Game Update];
                break;
            default:
                Game_Data.Status_Next = Stat_MenuMain;
                break;
        }
    }
}

-(void)ChangeStat
{
    if (Game_Data.Status_Next == Stat_Null)
        return;
    
    switch (Game_Data.Status_Next)
    {
        case Stat_MenuMain:
            [self Stat_Menu_Main];
            break;
        case Stat_MenuSelect:
            [self Stat_Menu_Select];
            break;
        case Stat_MenuSet:
            [self Stat_Menu_Set];
            break;
        case Stat_MenuThank:
            [self Stat_Menu_Thank];
            break;
        case Stat_MenuHelp:
            [self Stat_Menu_Help];
            break;
        case Stat_Start:
            [self Stat_Game_Start];
            break;
        case Stat_Win:
            [self Stat_Game_Win];
            break;
        case Stat_Lose:
            [self Stat_Game_Lose];
            break;
        case Stat_Pause:
            [self Stat_Game_Pause];
            break;
        case Stat_Next:
            [self Stat_Game_Next];
            break;
        case Stat_Resume:
            [self Stat_Game_Resume];
            break;
        case Stat_Restart:
            [self Stat_Game_Restart];
            break;
        case Stat_NewGame:
            [self Stat_NewGame];
    }
    glFlush();
    
    Game_Data.Status_Next = Stat_Null;
}

-(void)Stat_Menu_Main
{
    switch (Game_Data.Status_Curent)
    {
        case Stat_MenuSelect:
            if (Menu_Main)
                [Menu_Main dealloc];
            Menu_Main = nil;
            Menu_Main = [[MenuMain alloc] init : &Game_Data];
            [Menu_Select dealloc];
            Menu_Select = nil;
            break;
        case Stat_MenuSet:
            if (Menu_Main)
                [Menu_Main dealloc];
            Menu_Main = nil;
            Menu_Main = [[MenuMain alloc] init : &Game_Data];
            [Menu_Set dealloc];
            Menu_Set = nil;
            break;
        case Stat_MenuThank:
            if (Menu_Main)
                [Menu_Main dealloc];
            Menu_Main = nil;
            Menu_Main = [[MenuMain alloc] init : &Game_Data];
            [Menu_Thank dealloc];
            Menu_Thank = nil;
            break;
        case Stat_MenuHelp:
            if (Menu_Main)
                [Menu_Main dealloc];
            Menu_Main = nil;
            Menu_Main = [[MenuMain alloc] init : &Game_Data];
            [Menu_Help dealloc];
            Menu_Help = nil;
            break;
        case Stat_Win:
        case Stat_Pause:
        case Stat_Lose:
        case Stat_Play:
            if (Menu_Main)
                [Menu_Main dealloc];
            Menu_Main = nil;
            Menu_Main = [[MenuMain alloc] init : &Game_Data];
            if (Game_Play)
                [Game_Play dealloc];
            Game_Play = nil;
            break;
        case Stat_Null:
            if (Menu_Main)
                [Menu_Main dealloc];
            Menu_Main = nil;
            Menu_Main = [[MenuMain alloc] init : &Game_Data];
            break;
        case Stat_NewGame:
            if (Menu_Main)
                [Menu_Main dealloc];
            Menu_Main = nil;
            Menu_Main = [[MenuMain alloc] init : &Game_Data];
            if (New_Game)
                [New_Game dealloc];
            New_Game = nil;
            break;
    }
    Game_Data.Status_Curent = Stat_MenuMain;
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix2D;
}

-(void)Stat_Menu_Select
{
    switch (Game_Data.Status_Curent)
    {
        case Stat_MenuMain:
            if (Menu_Main)
                [Menu_Main dealloc];
            Menu_Main = nil;
            Menu_Select = [[MenuSelect alloc] init : &Game_Data];
            break;
    }
    Game_Data.Status_Curent = Stat_MenuSelect;
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix2D;
}

-(void)Stat_Menu_Set
{
    switch (Game_Data.Status_Curent)
    {
        case Stat_MenuMain:
            if (Menu_Main)
                [Menu_Main dealloc];
            Menu_Main = nil;
            Menu_Set = [[MenuSet alloc] init : &Game_Data];
            break;
    }
    Game_Data.Status_Curent = Stat_MenuSet;
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix2D;
}

-(void)Stat_Menu_Thank
{
    switch (Game_Data.Status_Curent)
    {
        case Stat_MenuMain:
            if (Menu_Main)
                [Menu_Main dealloc];
            Menu_Main = nil;
            Menu_Thank = [[MenuThank alloc] init : &Game_Data];
            break;
    }
    Game_Data.Status_Curent = Stat_MenuThank;
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix2D;
}

-(void)Stat_Menu_Help
{
    switch (Game_Data.Status_Curent)
    {
        case Stat_MenuMain:
            if (Menu_Main)
                [Menu_Main dealloc];
            Menu_Main = nil;
            Menu_Help = [[MenuHelp alloc] init : &Game_Data];
            break;
    }
    Game_Data.Status_Curent = Stat_MenuHelp;
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix2D;
}

-(void)Stat_NewGame
{
    if (Menu_Select)
        [Menu_Select dealloc];
    Menu_Select = nil;
    
    if (Menu_Main)
        [Menu_Main dealloc];
    Menu_Main = nil;
    
    if (Game_Play)
        [Game_Play dealloc];
    Game_Play = nil;
    
    New_Game = [[NewGame alloc] init : &Game_Data];
    
    Game_Data.Status_Curent = Stat_NewGame;
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix3D;
}

-(void)Stat_Game_Start
{
    if (Menu_Select)
        [Menu_Select dealloc];
    Menu_Select = nil;
    
    if (Menu_Main)
        [Menu_Main dealloc];
    Menu_Main = nil;
    
    if (Game_Play)
        [Game_Play dealloc];
    Game_Play = nil;
    
    if (New_Game)
        [New_Game dealloc];
    New_Game = nil;
    
    Game_Play = [[GamePlay alloc] init : &Game_Data];
    
    Game_Data.Status_Curent = Stat_Play;
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix3D;
}

-(void)Stat_Game_Restart
{
    if (!Game_Play)
    {
        Game_Data.Status_Next = Stat_Start;
        return;
    }
    
    [Game_Play Reset];
    Game_Data.Status_Curent = Stat_Play;
}

-(void)Stat_Game_Next
{
    Game_Data.Level++;
    if (Game_Play)
        [Game_Play dealloc];
    Game_Play = nil;
//    Game_Play = [[GamePlay alloc] init : &Game_Data];
    Game_Data.Status_Next_tmp = Stat_Start;
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix3D;
}

-(void)Stat_Game_Resume
{
    Game_Data.Status_Curent = Stat_Play;
//    Game_Play->Return_En = true;
//    Game_Play->Return_Time = 3;
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix3D;
}

-(void)Stat_Game_Pause
{
    if (Game_Data.Status_Curent == Stat_Play)
    {
        [Game_Play->Menu_Game Pause];
        Game_Data.Status_Curent = Stat_Pause;
    }
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix3D;
}

-(void)Stat_Game_Win
{    
    Game_Data.Level_Data[Game_Data.Level].Used = true;
    if (Game_Data.Set_Dif)
    {
        if (Game_Data.Level_Data[Game_Data.Level].Score[1] < Game_Data.Score_Calc)
        {
            Game_Data.Level_Data[Game_Data.Level].Score[1] = Game_Data.Score_Calc;
            [Game_Root Save_Data : 1];
        }
    }
    else
    {
        if (Game_Data.Level_Data[Game_Data.Level].Score[0] < Game_Data.Score_Calc)
        {
            Game_Data.Level_Data[Game_Data.Level].Score[0] = Game_Data.Score_Calc;
            [Game_Root Save_Data : 1];
        }
    }
    [Game_Root Check_Data];
    
    [Game_Play->Menu_Game Win];
    Game_Data.Status_Curent = Stat_Win;
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix3D;
}

-(void)Stat_Game_Lose
{
    [Game_Play->Menu_Game Lose];
    
    Game_Data.Status_Curent = Stat_Lose;
    
    self.effect.transform.projectionMatrix = Game_Data.ViewMatrix3D;
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    if (Game_Data.Status_Next_tmp != 0)
    {
        Game_Data.HUDMatrix = GLKMatrix4MakeTranslation(0, 0, 0);
        //        Game_Data->HUDMatrix = GLKMatrix4Rotate(Game_Data->HUDMatrix, GLKMathDegreesToRadians(90), 0.0f, 0.0f, 1.0f);
        Game_Data.HUDMatrix = GLKMatrix4Scale(Game_Data.HUDMatrix, 0.5f, 0.5f, 0.0f);
        Game_Data.effect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
        Game_Data.ViewMatrixTmp = self.effect.transform.projectionMatrix;
        self.effect.transform.projectionMatrix = Game_Data.ViewMatrix2D;
        glDisable(GL_DEPTH_TEST);
        [Game_Root DrawObject2D: &Game_Data.Loading];
        Game_Data.Status_Next_en = true;
        glEnable(GL_DEPTH_TEST);
        self.effect.transform.projectionMatrix = Game_Data.ViewMatrixTmp;
    }
    else
    {
        switch (Game_Data.Status_Curent)
        {
            case Stat_MenuMain:
                [Menu_Main Draw];
                break;
            case Stat_MenuSet:
                [Menu_Set Draw];
                break;
            case Stat_MenuSelect:
                [Menu_Select Draw];
                break;
            case Stat_MenuThank:
                [Menu_Thank Draw];
                break;
            case Stat_MenuHelp:
                [Menu_Help Draw];
                break;
            case Stat_Play:
            case Stat_Win:
            case Stat_Lose:
            case Stat_Pause:
                [Game_Play Draw];
                break;
            case Stat_NewGame:
                [New_Game Draw];
                break;
        };
    }
}

float tmp_x, tmp_y;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (Game_Data.Status_Next_tmp != 0)
    {
        return;
    }
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    location.x *= 2;
    location.y *= 2;
  
    switch (Game_Data.Status_Curent)
    {
        case Stat_MenuMain:
            [Menu_Main Touch_Start: touches];
            break;
        case Stat_MenuSet:
            [Menu_Set Touch_Start: touches];
            break;
        case Stat_MenuSelect:
            [Menu_Select Touch_Start: touches];
            break;
        case Stat_MenuThank:
            [Menu_Thank Touch_Start: touches];
            break;
        case Stat_MenuHelp:
            [Menu_Help Touch_Start: touches];
            break;
        case Stat_Play:
        case Stat_Win:
        case Stat_Lose:
        case Stat_Pause:
            [Game_Play Touch_Start: touches];
            break;
        case Stat_NewGame:
            [New_Game Touch_Start: touches];
            break;
    };
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (Game_Data.Status_Next_tmp != 0)
    {
        return;
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    location.x *= 2;
    location.y *= 2;
    
    switch (Game_Data.Status_Curent)
    {
        case Stat_MenuMain:
            [Menu_Main Touch_End: touches];
            break;
        case Stat_MenuSet:
            [Menu_Set Touch_End: touches];
            break;
        case Stat_MenuSelect:
            [Menu_Select Touch_End: touches];
            break;
        case Stat_MenuThank:
            [Menu_Thank Touch_End: touches];
            break;
        case Stat_MenuHelp:
            [Menu_Help Touch_End: touches];
            break;
        case Stat_Play:
        case Stat_Win:
        case Stat_Lose:
        case Stat_Pause:
            [Game_Play Touch_End: touches];
            break;
        case Stat_NewGame:
            [New_Game Touch_End: touches];
            break;
    };
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (Game_Data.Status_Next_tmp != 0)
    {
        return;
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    location.x *= 2;
    location.y *= 2;
    
    switch (Game_Data.Status_Curent)
    {
        case Stat_MenuMain:
            [Menu_Main Touch_End: touches];
            break;
        case Stat_MenuSet:
            [Menu_Set Touch_End: touches];
            break;
        case Stat_MenuSelect:
            [Menu_Select Touch_End: touches];
            break;
        case Stat_MenuThank:
            [Menu_Thank Touch_End: touches];
            break;
        case Stat_MenuHelp:
            [Menu_Help Touch_End: touches];
            break;
        case Stat_Play:
        case Stat_Win:
        case Stat_Lose:
        case Stat_Pause:
            [Game_Play Touch_End: touches];
            break;
        case Stat_NewGame:
            [New_Game Touch_End: touches];
            break;
    };
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (Game_Data.Status_Next_tmp != 0)
    {
        return;
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    location.x *= 2;
    location.y *= 2;
    
    switch (Game_Data.Status_Curent)
    {
        case Stat_MenuMain:
            [Menu_Main Touch_Move: touches];
            break;
        case Stat_MenuSet:
            [Menu_Set Touch_Move: touches];
            break;
        case Stat_MenuSelect:
            [Menu_Select Touch_Move: touches];
            break;
        case Stat_MenuThank:
            [Menu_Thank Touch_Move: touches];
            break;
        case Stat_MenuHelp:
            [Menu_Help Touch_Move: touches];
            break;
        case Stat_Play:
        case Stat_Win:
        case Stat_Lose:
        case Stat_Pause:
            [Game_Play Touch_Move: touches];
            break;
        case Stat_NewGame:
            [New_Game Touch_Move: touches];
            break;
    };
}

@end
