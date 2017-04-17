//
//  menuthank.m
//  At the Wheel
//
//  Created by Администратор on 6/22/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#import "menuthank.h"

@implementation MenuThank
-(id)init : (struct GameData*)data
{
    self = [super init : data];
    if (self)
    {
        //Объекты
        [self CreateObject2D: &Background : Game_Data->Game_Center - 568 : 0 : 1136 : 640 : [self Load_Texture:@"menuthank_bg"]];
        [self CreateObject2D: &Text : Background.Position[0] + 108: Background.Position[1] + 90 : 920 : 963 : [self Load_Texture:@"menuthank_text"]];
        
        Position = 0;
        Position_tmp = 0;
        
        //Настройка камеры 2D
        Game_Data->HUDMatrix = GLKMatrix4MakeTranslation(0, 0, 0);
        //        Game_Data->HUDMatrix = GLKMatrix4Rotate(Game_Data->HUDMatrix, GLKMathDegreesToRadians(90), 0.0f, 0.0f, 1.0f);
        Game_Data->HUDMatrix = GLKMatrix4Scale(Game_Data->HUDMatrix, 0.5f, 0.5f, 0.0f);
        
        [self Reset];
    }
    return self;
}

-(void)Reset
{    
    //Системные переменные
    Touch_Point = false;
    
//    Game_Data->Status_Next_Load = false;
}

-(void)Update
{
    Text.Position[1] = Background.Position[1] + 90 + Position;
}

-(void)Draw
{
    glDisable(GL_DEPTH_TEST);
    
    [self DrawObject2D: &Text];
    [self DrawObject2D: &Background];
    
    glEnable(GL_DEPTH_TEST);
}

-(void)Touch_Start: (NSSet *)touches
{
    for (touch in touches)
    {
        location = [touch locationInView:Game_Data->view];
        location.y *= 2;
        break;
    }
    
    Position_tmp = location.y;
    
    Touch_Point = true;
}

-(void)Touch_End: (NSSet *)touches
{
    if (Touch_Point)
    {
        for (touch in touches)
        {
            location = [touch locationInView:Game_Data->view];
            location.x *= 2;
            location.y *= 2;
            break;
        }
        
        if ([self Location_Touched: location.x : location.y : 0 : 0 : Background.Position[0] + 350 : Background.Position[1] + 100])
        {
            Game_Data->Status_Next = Stat_MenuMain;
        }
    }
}

-(void)Touch_Move: (NSSet *)touches
{
    for (touch in touches)
    {
        location = [touch locationInView:Game_Data->view];
        location.y *= 2;
        break;
    }
    
    Touch_Point = false;
    Position += location.y - Position_tmp;
    if (Position < -400)
        Position = -400;
    else if (Position > 0)
        Position = 0;
    
    Position_tmp = location.y;
}

-(void)dealloc
{
    //Объекты
    glDeleteTextures(1, &Background.Texture);
    glDeleteTextures(1, &Text.Texture);
    
	[super dealloc];
}
@end