//
//  play_hud.m
//  At the Wheel
//
//  Created by Negulus on 4/12/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#include "play_hud.h"

@implementation GamePlayHUD
-(id)init : (struct GameData*)data
{
    self = [super init : data];
    if (self)
    {
        //Постоянные объекты
        [self CreateObject2D: &Hud_BG : 0 : 0 : 591 : 95 : [self Load_Texture:@"hud_bg"]];
        [self CreateObject2D: &Life_0 : Game_Data->Game_Width - 160 : 10 : 100 : 170 : [self Load_Texture:@"hud_life_0"]];
        [self CreateObject2D: &Life_1 : Life_0.Position[0] : Life_0.Position[1] : 100 : 170 : [self Load_Texture:@"hud_life_1"]];
        [self CreateObject2D: &Life_2 : Life_0.Position[0] : Life_0.Position[1] : 100 : 170 : [self Load_Texture:@"hud_life_2"]];
        [self CreateObject2D: &Life_3 : Life_0.Position[0] : Life_0.Position[1] : 100 : 170 : [self Load_Texture:@"hud_life_3"]];
        [self CreateObject2D: &Bonus_Fast : Hud_BG.Position[0]+496 : Hud_BG.Position[1]+12 : 56 : 56 : [self Load_Texture:@"hud_fast"]];
        [self CreateObject2D: &Bonus_IDDQD : Hud_BG.Position[0]+420 : Hud_BG.Position[1]+12 : 56 : 56 : [self Load_Texture:@"hud_iddqd"]];
        [self CreateObject2D: &Bonus_x2 : Hud_BG.Position[0]+345 : Hud_BG.Position[1]+12 : 56 : 56 : [self Load_Texture:@"hud_x2"]];
        [self CreateObject2D: &Bonus_x4 : Hud_BG.Position[0]+345 : Hud_BG.Position[1]+12 : 56 : 56 : [self Load_Texture:@"hud_x4"]];
        [self CreateObject2D: &Car_Mini : Hud_BG.Position[0]+108 : Hud_BG.Position[1]+73 : 28 : 14 : [self Load_Texture:@"hud_car"]];
        [self CreateObject2D: &Screen_Broken : Game_Data->Game_Center - 445 : 24 : 890 : 593 : [self Load_Texture:@"brokenscreen"]];
        
        [self CreateObject2D: &BonusScreen : Game_Data->Game_Center - 275 : 45 : 550 : 550 : [self Load_Texture:@"hud_bonus_0"]];
        BonusScreen_Tex[0] = BonusScreen.Texture;
        BonusScreen_Tex[1] = [self Load_Texture:@"hud_bonus_1"];
        BonusScreen_Tex[2] = [self Load_Texture:@"hud_bonus_2"];
        BonusScreen_Tex[3] = [self Load_Texture:@"hud_bonus_3"];
        BonusScreen_Tex[4] = [self Load_Texture:@"hud_bonus_4"];
        
        [self CreateObject2D: &Bonus_Time : 100 : 100 : 26 : 36 : [self Load_Texture:@"hud_bonus_time"]];
        Bonus_Time.Vertex[1] = -36.0f;
        Bonus_Time.Vertex[3] = -36.0f;
        Bonus_Time.Vertex[5] = 0.0f;
        Bonus_Time.Vertex[7] = 0.0f;
        
        if (Game_Data->Set_Dif == 0)
            [self CreateObject2D: &Score : Hud_BG.Position[1]+124 : Hud_BG.Position[1]+20 : 24 : 42 : [self Load_Texture:@"hud_dif_0"]];
        else
            [self CreateObject2D: &Score : Hud_BG.Position[1]+124 : Hud_BG.Position[1]+20 : 24 : 42 : [self Load_Texture:@"hud_dif_1"]];
        
        [self CreateObject2DDigit : &Score_Digit : Score.Position[0]+45+13 : Score.Position[1]+8+13 : 19 : 35 : 36 : 0];
        Score_Digit.Texture[0] = [self Load_Texture:@"hud_score_0"];
        Score_Digit.Texture[1] = [self Load_Texture:@"hud_score_1"];
        Score_Digit.Texture[2] = [self Load_Texture:@"hud_score_2"];
        Score_Digit.Texture[3] = [self Load_Texture:@"hud_score_3"];
        Score_Digit.Texture[4] = [self Load_Texture:@"hud_score_4"];
        Score_Digit.Texture[5] = [self Load_Texture:@"hud_score_5"];
        Score_Digit.Texture[6] = [self Load_Texture:@"hud_score_6"];
        Score_Digit.Texture[7] = [self Load_Texture:@"hud_score_7"];
        Score_Digit.Texture[8] = [self Load_Texture:@"hud_score_8"];
        Score_Digit.Texture[9] = [self Load_Texture:@"hud_score_9"];
        Score_Digit.Vertex[0] = -13.0f;
        Score_Digit.Vertex[1] = -13.0f;
        Score_Digit.Vertex[2] = 13.0f;
        Score_Digit.Vertex[3] = -13.0f;
        Score_Digit.Vertex[4] = -13.0f;
        Score_Digit.Vertex[5] = 13.0f;
        Score_Digit.Vertex[6] = 13.0f;
        Score_Digit.Vertex[7] = 13.0f;
    }
    return self;
}

-(void)Reset
{   
    //Системные переменные
    Life_Up = false;
    Life_Blink = false;
    Life_Blink_En = false;
    Life_tmp = 3;
    Life_Blink_Time = 0;
    Life_Blink_Time_2 = 0;
    Broken = false;
    Score_tmp = 0;
    Score_Time = 0;
    Bonus_Screen_Time[0] = 0;
    Bonus_Screen_Time[1] = 0;
    Bonus_Screen_Time[2] = 0;
    Bonus_Screen_Time[3] = 0;
    Bonus_Screen_Time[4] = 0;
}

-(void)Update
{
    Car_Mini.Position[0] = Hud_BG.Position[0] + 108 + (Game_Data->Level_Passed * 431.0f);
    
    if (Life_tmp != Game_Data->Life)
    {
        if (Life_tmp < Game_Data->Life)
            Life_Up = true;
        Life_tmp = Game_Data->Life;
        Life_Blink_En = true;
        Life_Blink_Time = 0.9f;
        Life_Blink_Time_2 = 0.7f;
    }
        
    if (Life_Blink_En)
    {
        if ([self Timer : &Life_Blink_Time])
        {
            Life_Blink = false;
            Life_Blink_En = false;
            Life_Up = false;
        }
        else
        {
            if (Life_Blink_Time < Life_Blink_Time_2)
            {
                Life_Blink_Time_2 -= 0.2f;
                if (Life_Blink)
                    Life_Blink = false;
                else
                    Life_Blink = true;
            }
        }
    }
    
    if (Game_Data->Score != Score_tmp)
    {
        Score_Time = 0.5f;
        Score_tmp = Game_Data->Score;
    }
    
    for (i = 0; i < 5; i++)
        [self Timer: &Bonus_Screen_Time[i]];
    
    [self Timer: &Score_Time];
}

-(void)Draw
{
    glDisable(GL_DEPTH_TEST);
    Game_Data->effect.transform.projectionMatrix = Game_Data->ViewMatrix2D;
    [self DrawObject2D: &Hud_BG];
    [self DrawObject2D: &Score];

    [self DrawObject2DDigitLocal: &Score_Digit : 3 : Game_Data->Score];
    
    
    [self DrawObject2D: &Car_Mini];
    
    if (Game_Data->Bonus_x4)
    {
        [self DrawObject2D: &Bonus_x4];
        [self DrawBonusTime: 1];
    }
    else if (Game_Data->Bonus_x2)
    {
        [self DrawObject2D: &Bonus_x2];
        [self DrawBonusTime: 0];
    }
    
    if (Game_Data->Bonus_IDDQD)
    {
        [self DrawObject2D: &Bonus_IDDQD];
        [self DrawBonusTime: 2];
    }
    
    if (Game_Data->Bonus_Fast)
    {
        [self DrawObject2D: &Bonus_Fast];
        [self DrawBonusTime: 3];
    }
    
    if (!Life_Up)
    {
        if (Game_Data->Life == 3 || (Game_Data->Life == 2 && Life_Blink_En && Life_Blink))
        {
            [self DrawObject2D: &Life_3];
        }
        else if (Game_Data->Life == 2 || (Game_Data->Life == 1 && Life_Blink_En && Life_Blink))
        {
            [self DrawObject2D: &Life_2];
        }
        else if (Game_Data->Life == 1 || (Game_Data->Life == 0 && Life_Blink_En && Life_Blink))
        {
            [self DrawObject2D: &Life_1];
        }
        else
        {
            [self DrawObject2D: &Life_0];
        }
    }
    else
    {
        if (Game_Data->Life == 0 || (Game_Data->Life == 1 && Life_Blink_En && Life_Blink))
        {
            [self DrawObject2D: &Life_0];
        }
        else if (Game_Data->Life == 1 || (Game_Data->Life == 2 && Life_Blink_En && Life_Blink))
        {
            [self DrawObject2D: &Life_1];
        }
        else if (Game_Data->Life == 2 || (Game_Data->Life == 3 && Life_Blink_En && Life_Blink))
        {
            [self DrawObject2D: &Life_2];
        }
        else
        {
            [self DrawObject2D: &Life_3];
        }
    }
    
    if (Broken)
        [self DrawObject2D: &Screen_Broken];
    
    for (i = 0; i < 5; i++)
    {
        if (Bonus_Screen_Time[i] > 0)
        {
            if (Bonus_Screen_Time[i] > (BONUS_SCREEN_TIME * 0.5f))
            {
                tmpf = (BONUS_SCREEN_TIME - Bonus_Screen_Time[i]) / (BONUS_SCREEN_TIME * 0.5f);
            }
            else
            {
                tmpf = Bonus_Screen_Time[i] / (BONUS_SCREEN_TIME * 0.5f);
            }
            Game_Data->effect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, tmpf);
            BonusScreen.Texture = BonusScreen_Tex[i];
            [self DrawObject2D: &BonusScreen];
            Game_Data->effect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
        }
    }
    
    Game_Data->effect.transform.projectionMatrix = Game_Data->ViewMatrix3D;
    glEnable(GL_DEPTH_TEST);
}

-(void)DrawObject2DDigitLocal : (struct Object2DDigit*)obj : (int) count : (int)num
{
    [self BindBuffer2D : obj->Vertex : Vertex_Tex_Full : Vertex_Col_Full];
    
    Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Translate(Game_Data->HUDMatrix, obj->Position[0], obj->Position[1], 0);
    if (Score_Time > 0)
    { 
        Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Scale(Game_Data->effect.transform.modelviewMatrix, (1 + (Score_Time * 0.75f)), (1 + (Score_Time * 0.75f)), 0);
    }
    
    i = num % 100;
    j = i % 10;
    
    if (count >= 3)
    {
        Game_Data->effect.texture2d0.name = obj->Texture[((num - i) / 100)];
        [Game_Data->effect prepareToDraw];
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Translate(Game_Data->effect.transform.modelviewMatrix, obj->Relative[0], obj->Relative[1], 0);
    }
    
    if (count >= 2)
    {
        Game_Data->effect.texture2d0.name = obj->Texture[((i-j) / 10)];
        [Game_Data->effect prepareToDraw];
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Translate(Game_Data->effect.transform.modelviewMatrix, obj->Relative[0], obj->Relative[1], 0);
    }
    
    if (count >= 1)
    {
        Game_Data->effect.texture2d0.name = obj->Texture[j];
        [Game_Data->effect prepareToDraw];
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    }
}

-(void)DrawBonusTime : (int) type
{    
    [self BindBuffer2D : Bonus_Time.Vertex : Vertex_Tex_Full : Vertex_Col_Full];
    Game_Data->effect.texture2d0.name = Bonus_Time.Texture;
    
    switch (type) {
        case 0:  
            tmpf = (Game_Data->Bonus_x2_Time / BONUS_X2_TIME) * 8;
            i = 0;
            while (tmpf > i && i < 8)
            {
                Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Translate(Game_Data->HUDMatrix, Hud_BG.Position[0] + 372, Hud_BG.Position[1] + 40, 0);
                Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Rotate(Game_Data->effect.transform.modelviewMatrix, GLKMathDegreesToRadians(45 * i), 0, 0, 1.0f);
                [Game_Data->effect prepareToDraw];
                glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
                i += 1;
            }
            [Game_Data->effect prepareToDraw];
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            break;
        case 1:
            tmpf = (Game_Data->Bonus_x4_Time / BONUS_X4_TIME) * 8;
            i = 0;
            while (tmpf > i && i < 8)
            {
                Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Translate(Game_Data->HUDMatrix, Hud_BG.Position[0] + 372, Hud_BG.Position[1] + 40, 0);
                Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Rotate(Game_Data->effect.transform.modelviewMatrix, GLKMathDegreesToRadians(45 * i), 0, 0, 1.0f);
                [Game_Data->effect prepareToDraw];
                glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
                i += 1;
            }
            [Game_Data->effect prepareToDraw];
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            break;
        case 2:
            tmpf = (Game_Data->Bonus_IDDQD_Time / BONUS_IDDQD_TIME) * 8;
            i = 0;
            while (tmpf > i && i < 8)
            {
                Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Translate(Game_Data->HUDMatrix, Hud_BG.Position[0] + 448, Hud_BG.Position[1] + 40, 0);
                Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Rotate(Game_Data->effect.transform.modelviewMatrix, GLKMathDegreesToRadians(45 * i), 0, 0, 1.0f);
                [Game_Data->effect prepareToDraw];
                glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
                i += 1;
            }
            break;
        case 3:
            tmpf = (Game_Data->Bonus_Fast_Time / BONUS_FAST_TIME) * 8;
            i = 0;
            while (tmpf > i && i < 8)
            {
                Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Translate(Game_Data->HUDMatrix, Hud_BG.Position[0] + 524, Hud_BG.Position[1] + 40, 0);
                Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Rotate(Game_Data->effect.transform.modelviewMatrix, GLKMathDegreesToRadians(45 * i), 0, 0, 1.0f);
                [Game_Data->effect prepareToDraw];
                glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
                i += 1;
            }
            [Game_Data->effect prepareToDraw];
            glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
            break;
        default:
            break;
    }
}

-(void)dealloc
{
    //Постоянные объекты
    glDeleteTextures(1, &Hud_BG.Texture);
    glDeleteTextures(1, &Life_0.Texture);
    glDeleteTextures(1, &Life_1.Texture);
    glDeleteTextures(1, &Life_2.Texture);
    glDeleteTextures(1, &Life_3.Texture);
    glDeleteTextures(1, &Bonus_Fast.Texture);
    glDeleteTextures(1, &Bonus_IDDQD.Texture);
    glDeleteTextures(1, &Bonus_x2.Texture);
    glDeleteTextures(1, &Bonus_x4.Texture);
    glDeleteTextures(1, &Car_Mini.Texture);
    glDeleteTextures(1, &Screen_Broken.Texture);
    glDeleteTextures(1, &Bonus_Time.Texture);
    glDeleteTextures(1, &Score.Texture);
    glDeleteTextures(1, &Score_Digit.Texture[0]);
    glDeleteTextures(1, &Score_Digit.Texture[1]);
    glDeleteTextures(1, &Score_Digit.Texture[2]);
    glDeleteTextures(1, &Score_Digit.Texture[3]);
    glDeleteTextures(1, &Score_Digit.Texture[4]);
    glDeleteTextures(1, &Score_Digit.Texture[5]);
    glDeleteTextures(1, &Score_Digit.Texture[6]);
    glDeleteTextures(1, &Score_Digit.Texture[7]);
    glDeleteTextures(1, &Score_Digit.Texture[8]);
    glDeleteTextures(1, &Score_Digit.Texture[9]);
    glDeleteTextures(1, &BonusScreen_Tex[0]);
    glDeleteTextures(1, &BonusScreen_Tex[1]);
    glDeleteTextures(1, &BonusScreen_Tex[2]);
    glDeleteTextures(1, &BonusScreen_Tex[3]);
    glDeleteTextures(1, &BonusScreen_Tex[4]);
    
    [super dealloc];
}

@end