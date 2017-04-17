//
//  menu.m
//  At the Wheel
//
//  Created by Администратор on 4/15/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#import "menumain.h"

@implementation MenuMain

-(id)init : (struct GameData*)data
{
    self = [super init : data];
    if (self)
    {
        //Постоянные объекты
        [self CreateObject2D: &Background : Game_Data->Game_Center - 568 : 0 : 1136 : 640 : [self Load_Texture:@"menumain_bg"]];
        
        //Кнопки главного меню
        [self CreateObject2D: &Button[0] : Game_Data->Game_Center - 210 : 270 : 420 : 256 : [self Load_Texture:@"menumain_game"]];
        [self CreateObject2D: &Button[1] : Button[0].Position[0] + 500 : Button[0].Position[1] : 420 : 256 : [self Load_Texture:@"menumain_settings"]];
        [self CreateObject2D: &Button[2] : Button[1].Position[0] + 500 : Button[0].Position[1] : 420 : 256 : [self Load_Texture:@"menumain_help"]];
        [self CreateObject2D: &Button[3] : Button[2].Position[0] + 500 : Button[0].Position[1] : 420 : 256 : [self Load_Texture:@"menumain_credits"]];
        
        //Настройка камеры
        Game_Data->HUDMatrix = GLKMatrix4MakeTranslation(0, 0, 0);
//        Game_Data->HUDMatrix = GLKMatrix4Rotate(Game_Data->HUDMatrix, GLKMathDegreesToRadians(90), 0.0f, 0.0f, 1.0f);
        Game_Data->HUDMatrix = GLKMatrix4Scale(Game_Data->HUDMatrix, 0.5f, 0.5f, 0.0f);
        
        [self Reset];        
    }
    return self;
}

-(void)Reset
{
    //Игровые переменные
    Position = Game_Data->Menu_Main_Pos;
    Position_tmp = 0;
    Position_V = 0;
    
    //Системные переменные
    Touch_Point = false;
    
//    Game_Data->Status_Next_Load = false;
}

-(void)Update
{
    Button[0].Position[0] = Game_Data->Game_Center - 210 + Position;
    Button[1].Position[0] = Button[0].Position[0] + 500;
    Button[2].Position[0] = Button[1].Position[0] + 500;
    Button[3].Position[0] = Button[2].Position[0] + 500;
}

-(void)Draw
{
    glDisable(GL_DEPTH_TEST);
    [self DrawObject2D: &Background];
    [self DrawObject2D: &Button[0]];
    [self DrawObject2D: &Button[1]];
    [self DrawObject2D: &Button[2]];
    [self DrawObject2D: &Button[3]];     
    glEnable(GL_DEPTH_TEST);
}

-(void)Touch_Start: (NSSet *)touches
{
    for (touch in touches)
    {
        location = [touch locationInView:Game_Data->view];
        location.x *= 2;
        location.y *= 2;
        break;
    }
    
    Position_tmp = location.x;
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
        
        if ([self Location_Touched: location.x : location.y :Button[0].Position[0] : Button[0].Position[1] : Button[0].Vertex[2] : Button[0].Vertex[5]])
        {
            Game_Data->Status_Next_tmp = Stat_MenuSelect;
        }
        else if ([self Location_Touched: location.x : location.y :Button[1].Position[0] : Button[1].Position[1] : Button[1].Vertex[2] : Button[1].Vertex[5]])
        {
            Game_Data->Status_Next_tmp = Stat_MenuSet;
        }
        else if ([self Location_Touched: location.x : location.y :Button[2].Position[0] : Button[2].Position[1] : Button[2].Vertex[2] : Button[2].Vertex[5]])
        {
            Game_Data->Status_Next_tmp = Stat_MenuHelp;
        }
        else if ([self Location_Touched: location.x : location.y :Button[3].Position[0] : Button[3].Position[1] : Button[3].Vertex[2] : Button[3].Vertex[5]])
        {
            Game_Data->Status_Next_tmp = Stat_MenuThank;
        }
    }
}

-(void)Touch_Move: (NSSet *)touches
{
    for (touch in touches)
    {
        location = [touch locationInView:Game_Data->view];
        location.x *= 2;
        location.y *= 2;
        break;
    }
    
    Touch_Point = false;
    Position += location.x - Position_tmp;
    if (Position < -1500)
        Position = -1500;
    else if (Position > 0)
        Position = 0;
    
    Position_tmp = location.x;
}

-(void)dealloc
{
    Game_Data->Menu_Main_Pos = Position;
    //Постоянные объекты
    glDeleteTextures(1, &Background.Texture);
    
    //Кнопки главного меню
    glDeleteTextures(1, &Button[0].Texture);
    glDeleteTextures(1, &Button[1].Texture);
    glDeleteTextures(1, &Button[2].Texture);
    glDeleteTextures(1, &Button[3].Texture);
    
	[super dealloc];
}
@end
