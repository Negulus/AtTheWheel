//
//  menuselect.c
//  At the Wheel
//
//  Created by Администратор on 5/11/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#import "menuselect.h"

@implementation MenuSelect
-(id)init : (struct GameData*)data
{
    self = [super init : data];
    if (self)
    {
        //Объекты
        [self CreateObject2D: &Background : Game_Data->Game_Center - 568 : 0 : 1136 : 640 : [self Load_Texture:@"menusel_bg"]];
        [self CreateObject2D: &Quest : Game_Data->Game_Center - 207 : 163 : 414 : 314 : [self Load_Texture:@"menusel_quest"]];
        [self CreateObject2D: &Obj_Start : Background.Position[0] + 884 : Background.Position[1] + 536 : 146 : 51 : [self Load_Texture:@"menusel_start"]];
        [self CreateObject2D: &Obj_Reset : Background.Position[0] + 495 : Background.Position[1] + 536 : 154 : 51 : [self Load_Texture:@"menusel_reset"]];
        [self CreateObject2D: &Obj_World : Background.Position[0] + 393 : Background.Position[1] + 128 : 350 : 180 : [self Load_Texture:@"sky"]];
        [self CreateObject2D: &Obj_Button : 0 : 0 : 290 : 140 : [self Load_Texture:@"menusel_button"]];
        [self CreateObject2D: &Obj_Lock : 0 : 0 : 290 : 140 : [self Load_Texture:@"menusel_button_lock"]];
        [self CreateObject2D: &Obj_Select : 0 : 0 : 330 : 180 : [self Load_Texture:@"menusel_select"]];
        
        [self CreateObject2DDigit : &Num_Big : 0 : 0 : 28 : 51 : 35 : 0];
        Num_Big.Texture[0] = [self Load_Texture:@"menusel_0"];
        Num_Big.Texture[1] = [self Load_Texture:@"menusel_1"];
        Num_Big.Texture[2] = [self Load_Texture:@"menusel_2"];
        Num_Big.Texture[3] = [self Load_Texture:@"menusel_3"];
        Num_Big.Texture[4] = [self Load_Texture:@"menusel_4"];
        Num_Big.Texture[5] = [self Load_Texture:@"menusel_5"];
        Num_Big.Texture[6] = [self Load_Texture:@"menusel_6"];
        Num_Big.Texture[7] = [self Load_Texture:@"menusel_7"];
        Num_Big.Texture[8] = [self Load_Texture:@"menusel_8"];
        Num_Big.Texture[9] = [self Load_Texture:@"menusel_9"];
        
        [self CreateObject2DDigit : &Num_Small : 0 : 0 : 14 : 26 : 25 : 0];
        Num_Small.Texture[0] = [self Load_Texture:@"menusel_0m"];
        Num_Small.Texture[1] = [self Load_Texture:@"menusel_1m"];
        Num_Small.Texture[2] = [self Load_Texture:@"menusel_2m"];
        Num_Small.Texture[3] = [self Load_Texture:@"menusel_3m"];
        Num_Small.Texture[4] = [self Load_Texture:@"menusel_4m"];
        Num_Small.Texture[5] = [self Load_Texture:@"menusel_5m"];
        Num_Small.Texture[6] = [self Load_Texture:@"menusel_6m"];
        Num_Small.Texture[7] = [self Load_Texture:@"menusel_7m"];
        Num_Small.Texture[8] = [self Load_Texture:@"menusel_8m"];
        Num_Small.Texture[9] = [self Load_Texture:@"menusel_9m"];
        
        //Настройка камеры
        Game_Data->HUDMatrix = GLKMatrix4MakeTranslation(0, 0, 0);
        Game_Data->HUDMatrix = GLKMatrix4Scale(Game_Data->HUDMatrix, 0.5f, 0.5f, 0.0f);
        
        [self Check_Data];
        [self Reset];
    }
    return self;
}

-(void)Reset
{
    for (i = 0; i < Game_Data->World_Num[Game_Data->Set_World]; i++)
    {
        if (i == 0)
        {
            Game_Data->Level_Data[i].Position[0] = Background.Position[0] + 418;
            Game_Data->Level_Data[i].Position[1] = 346;
        }
        else
        {
            Game_Data->Level_Data[i].Position[0] = Game_Data->Level_Data[i-1].Position[0] + 400;
            Game_Data->Level_Data[i].Position[1] = 346;
        }
        Game_Data->Level_Data[i].Select = false;
    }
    
    //Игровые переменные
    Position = Game_Data->Menu_Sel_Pos;
    Position_tmp = 0;
    Position_End = -418 - ((Game_Data->World_Num[Game_Data->Set_World] - 2) * 400);
    Select = false;
    
    //Системные переменные
    Touch_Point = false;
    Touch_Point_M = false;
    i_sel = 0;
    quest_en = false;
    
//    Game_Data->Status_Next_Load = false;
}

-(void)Update
{
    if (!quest_en)
    {
        Select = false;
        for (i_sel = 0; i_sel < Game_Data->World_Num[Game_Data->Set_World]; i_sel++)
        {
            if (Game_Data->Level_Data[i_sel].Select)
            {
                Select = true;
                break;
            }
        }
    }
}

-(void)Draw
{
    glDisable(GL_DEPTH_TEST);

    if (quest_en)
    {
        Game_Data->effect.constantColor = GLKVector4Make(0.5f, 0.5f, 0.5f, 1.0f);
    }
    [self DrawObject2D: &Background];
    if (Select)
    {
        [self DrawObject2D: &Obj_Start];
        [self DrawObject2D: &Obj_Reset];
    }
    [self DrawObject2D: &Obj_World];
    
    for (i_sel = 0; i_sel < Game_Data->World_Num[Game_Data->Set_World]; i_sel++)
    {
        Obj_Button.Position[0] = Game_Data->Level_Data[i_sel].Position[0] + Position;
        Obj_Button.Position[1] = Game_Data->Level_Data[i_sel].Position[1];
        [self DrawObject2D: &Obj_Button];
        
        Num_Big.Position[0] = Obj_Button.Position[0] + 30;
        Num_Big.Position[1] = Obj_Button.Position[1] + 44;
        [self DrawObject2DDigit: &Num_Big : 2 : (i_sel+1)];
        
        Num_Small.Position[0] = Obj_Button.Position[0] + 178;
        Num_Small.Position[1] = Obj_Button.Position[1] + 27;
        [self DrawObject2DDigit: &Num_Small : 3 : Game_Data->Level_Data[i_sel].Score[0]];
        
        Num_Small.Position[0] = Obj_Button.Position[0] + 178;
        Num_Small.Position[1] = Obj_Button.Position[1] + 85;
        [self DrawObject2DDigit: &Num_Small : 3 : Game_Data->Level_Data[i_sel].Score[1]];
        
        if (!Game_Data->Level_Data[i_sel].Enable)
        {
            Obj_Lock.Position[0] = Obj_Button.Position[0];
            Obj_Lock.Position[1] = Obj_Button.Position[1];
            [self DrawObject2D: &Obj_Lock];
        }
        else if (Game_Data->Level_Data[i_sel].Select)
        {
            Obj_Select.Position[0] = Obj_Button.Position[0] - 20;
            Obj_Select.Position[1] = Obj_Button.Position[1] - 20;
            [self DrawObject2D: &Obj_Select];
        }
    }
    if (quest_en)
    {
        Game_Data->effect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
        [self DrawObject2D: &Quest];
    }
    
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
 
    if (location.y > 320 && location.y < 500)
    {
        Position_tmp = location.x;
        Touch_Point_M = true;
    }
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
        
        if (quest_en)
        {
            if ([self Location_Touched: location.x : location.y : Quest.Position[0] + 50 : Quest.Position[1] + 106 : 314 : 76])
            {
                if (Select)
                {
                    for (i_sel = 0; i_sel < Game_Data->World_Num[Game_Data->Set_World]; i_sel++)
                    {
                        if (Game_Data->Level_Data[i_sel].Select)
                        {
                            Game_Data->Level_Data[i_sel].Score[0] = 0;
                            Game_Data->Level_Data[i_sel].Score[1] = 0;
                            [self Save_Data : 1];
                            [self Check_Data];
                            break;
                        }
                    }
                }
                quest_en = false;
            }
            else if ([self Location_Touched: location.x : location.y : Quest.Position[0] + 50 : Quest.Position[1] + 211 : 314 : 76])
            {
                quest_en = false;
            }
        }
        else
        {
            tmpb = true;
            if ([self Location_Touched: location.x : location.y : 0 : 548 : 270 : 100])
            {
                Game_Data->Status_Next_tmp = Stat_MenuMain;
                tmpb = false;
            }
            else if ([self Location_Touched: location.x : location.y :Obj_Start.Position[0] : Obj_Start.Position[1] : 220 : 100])
            {
                if (Select)
                {
                    for (i_sel = 0; i_sel < Game_Data->World_Num[Game_Data->Set_World]; i_sel++)
                    {
                        if (Game_Data->Level_Data[i_sel].Select)
                        {
                            Game_Data->Level = i_sel;
                            tmpi = 0;
                            if (i_sel == 0)
                            {
                                for (i_sel = 0; i_sel < Game_Data->World_Num[Game_Data->Set_World]; i_sel++)
                                {
                                    if (Game_Data->Level_Data[i_sel].Score[0] != 0 || Game_Data->Level_Data[i_sel].Score[1] != 0)
                                    {
                                        tmpi = 1;
                                        break;
                                    }
                                }
                            }
                            else
                            {
                                tmpi = 1;
                            }
                            if (tmpi == 0)
                                Game_Data->Status_Next_tmp = Stat_NewGame;
                            else
                                Game_Data->Status_Next_tmp = Stat_Start;
                            break;
                        }
                    }
                    tmpb = false;
                }
            }
            else if ([self Location_Touched: location.x : location.y :Obj_Reset.Position[0] : Obj_Reset.Position[1] : 220 : 100])
            {
                if (Select)
                {
                    quest_en = true;
                    tmpb = false;
                }
            }
            
            if (tmpb)
            {
                for (i_sel = 0; i_sel < Game_Data->World_Num[Game_Data->Set_World]; i_sel++)
                {
                    if (Game_Data->Level_Data[i_sel].Enable)
                    {
                        if (tmpb && [self Location_Touched: location.x : location.y : (Game_Data->Level_Data[i_sel].Position[0] + Position) : Game_Data->Level_Data[i_sel].Position[1] : Obj_Button.Vertex[2] : Obj_Button.Vertex[5]])
                        {
                            if (Game_Data->Level_Data[i_sel].Select)
                                Game_Data->Level_Data[i_sel].Select = false;
                            else
                                Game_Data->Level_Data[i_sel].Select = true;
                            tmpb = false;
                        }
                        else
                        {
                            Game_Data->Level_Data[i_sel].Select = false;
                        }
                    }
                }
            }
        }
    }
    Touch_Point_M = false;
}

-(void)Touch_Move: (NSSet *)touches
{
    Touch_Point = false;
    if (Touch_Point_M && !quest_en)
    {
        for (touch in touches)
        {
            location = [touch locationInView:Game_Data->view];
            location.x *= 2;
            location.y *= 2;
            break;
        }
        
        Position += location.x - Position_tmp;
        if (Position < Position_End)
            Position = Position_End;
        else if (Position > 0)
            Position = 0;
        
        Position_tmp = location.x;
    }
}

-(void)dealloc
{
    Game_Data->Menu_Sel_Pos = Position;
    //Объекты
    glDeleteTextures(1, &Background.Texture);
    glDeleteTextures(1, &Obj_World.Texture);
    glDeleteTextures(1, &Obj_Start.Texture);
    glDeleteTextures(1, &Obj_Reset.Texture);
    glDeleteTextures(1, &Obj_Button.Texture);
    glDeleteTextures(1, &Obj_Lock.Texture);
    glDeleteTextures(1, &Obj_Select.Texture);
    glDeleteTextures(1, &Num_Big.Texture[0]);
    glDeleteTextures(1, &Num_Big.Texture[1]);
    glDeleteTextures(1, &Num_Big.Texture[2]);
    glDeleteTextures(1, &Num_Big.Texture[3]);
    glDeleteTextures(1, &Num_Big.Texture[4]);
    glDeleteTextures(1, &Num_Big.Texture[5]);
    glDeleteTextures(1, &Num_Big.Texture[6]);
    glDeleteTextures(1, &Num_Big.Texture[7]);
    glDeleteTextures(1, &Num_Big.Texture[8]);
    glDeleteTextures(1, &Num_Big.Texture[9]);
    glDeleteTextures(1, &Num_Small.Texture[0]);
    glDeleteTextures(1, &Num_Small.Texture[1]);
    glDeleteTextures(1, &Num_Small.Texture[2]);
    glDeleteTextures(1, &Num_Small.Texture[3]);
    glDeleteTextures(1, &Num_Small.Texture[4]);
    glDeleteTextures(1, &Num_Small.Texture[5]);
    glDeleteTextures(1, &Num_Small.Texture[6]);
    glDeleteTextures(1, &Num_Small.Texture[7]);
    glDeleteTextures(1, &Num_Small.Texture[8]);
    glDeleteTextures(1, &Num_Small.Texture[9]);
	[super dealloc];
}
@end
