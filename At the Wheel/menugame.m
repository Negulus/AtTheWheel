//
//  menugame.h
//  At the Wheel
//
//  Created by Администратор on 5/25/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//
#import "menugame.h"

@implementation MenuGame
-(id)init : (struct GameData*)data
{
    self = [super init : data];
    if (self)
    {
        //Кнопки
        [self CreateObject2D: &Button_Resume : 0 : 0 : 420 : 76 : [self Load_Texture:@"menugame_resume"]];
        [self CreateObject2D: &Button_Next : 0 : 0 : 420 : 76 : [self Load_Texture:@"menugame_next"]];
        [self CreateObject2D: &Button_MainMenu : 0 : 0 : 420 : 76 : [self Load_Texture:@"menugame_main"]];
        [self CreateObject2D: &Button_Restart : 0 : 0 : 420 : 76 : [self Load_Texture:@"menugame_restart"]];
        
        //Текстуры
        [self CreateObject2D: &Background : -333 : -220 : 666 : 440 : [self Load_Texture:@"menugame_bg"]];
        Texture_BG = Background.Texture;
        Texture_Pause = [self Load_Texture:@"menugame_pause"];
        Texture_Win = [self Load_Texture:@"menugame_win"];
        Texture_Lose = [self Load_Texture:@"menugame_lose"];
	}
	return self;
}

-(void)Pause
{
    Button_Resume.Position[0] = Background.Position[0] + 123;
    Button_Resume.Position[1] = Background.Position[1] + 53;
    Button_Restart.Position[0] = Button_Resume.Position[0];
    Button_Restart.Position[1] = Button_Resume.Position[1] + 129;
    Button_MainMenu.Position[0] = Button_Restart.Position[0];
    Button_MainMenu.Position[1] = Button_Restart.Position[1] + 129;
    Background.Texture = Texture_Pause;
    [self Reset];
}

-(void)Win
{
    Button_Next.Position[0] = Background.Position[0] + 123;
    Button_Next.Position[1] = Background.Position[1] + 53;
    Button_Restart.Position[0] = Button_Next.Position[0];
    Button_Restart.Position[1] = Button_Next.Position[1] + 129;
    Button_MainMenu.Position[0] = Button_Restart.Position[0];
    Button_MainMenu.Position[1] = Button_Restart.Position[1] + 129;
    Background.Texture = Texture_Win;
    
    //Проверка следующего уровня
    Next_en = false;
    if ((Game_Data->Level + 1) < Game_Data->World_Num[Game_Data->Set_World])
    {
        if (Game_Data->Level_Data[Game_Data->Level + 1].Enable)
        {
            Next_en = true;
        }
    }
    [self Reset];
}

-(void)Lose
{
    Button_Restart.Position[0] = Background.Position[0] + 123;
    Button_Restart.Position[1] = Background.Position[1] + 117;
    Button_MainMenu.Position[0] = Button_Restart.Position[0];
    Button_MainMenu.Position[1] = Button_Restart.Position[1] + 129;
    Background.Texture = Texture_Lose;
    [self Reset];
}

-(void)Reset
{   
    //Перемещение таблички
    Position[0] = Game_Data->Game_Center;
    Position[1] = 320;
    Scale = 0.01f;
    Rotate = 0;
    Enable = true;
    Enable_1 = false;
    Enable_2 = false;
    Enable_Rot = false;
    
    //Системные переменные
    Time_Turn = 0;
    Touch_En = false;
    Score_tmp = 0;
    
    //Матрица меню
    Menu_Matrix = GLKMatrix4MakeTranslation(0, 0, 0);
    Menu_Matrix = GLKMatrix4Rotate(Menu_Matrix, GLKMathDegreesToRadians(Rotate), 0.0f, 1.0f, 0.0f);
    Menu_Matrix = GLKMatrix4Scale(Menu_Matrix, Scale, Scale, 0.0f);
}

-(void)GetMatrix
{
    Menu_Matrix = GLKMatrix4MakeTranslation(0, 0, 0);
    Menu_Matrix = GLKMatrix4Scale(Menu_Matrix, 0.5f, 0.5f, 0.0f);
    Menu_Matrix = GLKMatrix4Translate(Menu_Matrix, Position[0], Position[1], 0);
    Menu_Matrix = GLKMatrix4Rotate(Menu_Matrix, GLKMathDegreesToRadians(Rotate), 0.0f, 1.0f, 0.0f);
    Menu_Matrix = GLKMatrix4Scale(Menu_Matrix, Scale, Scale, 0.0f);
}

-(void)Update
{
    if (!Enable)
        return;
    
    if (!Enable_1)
    {
        if (Scale >= 1.0f)
        {
            Scale = 1.0f;
            Enable_1 = true;
            Time_Turn = 1.0f;
            [self GetMatrix];
        }
        else
        {
            [self Change_Smooth: &Scale : 1.0f : 2.0f];
            [self GetMatrix];
        }
    }
    else if (Enable_1 && !Enable_Rot && !Enable_2)
    {
        if (Game_Data->Status_Curent != Stat_Win)
        {
            if ([self Timer: &Time_Turn])
            {
                Enable_Rot = true;
            }
        }
        else
        {
            if (Game_Data->Score != Game_Data->Score_Calc)
            {
                if (Game_Data->Score_Calc > Game_Data->Score)
                {
                    Score_tmp += 50 * Game_Data->timeSinceLastUpdate;
                    if (Score_tmp > 1)
                    {
                        Game_Data->Score += roundf(Score_tmp);
                        Score_tmp -= roundf(Score_tmp);
                    }
                    if (Game_Data->Score > Game_Data->Score_Calc)
                        Game_Data->Score = Game_Data->Score_Calc;
                }
                else
                {
                    Score_tmp += 50 * Game_Data->timeSinceLastUpdate;
                    if (Score_tmp > 1)
                    {
                        Game_Data->Score -= roundf(Score_tmp);
                        Score_tmp -= roundf(Score_tmp);
                    }
                    if (Game_Data->Score < Game_Data->Score_Calc)
                        Game_Data->Score = Game_Data->Score_Calc;
                }
            }
            else
            {
                if ([self Timer: &Time_Turn])
                {
                    Enable_Rot = true;
                }
            }
        }
    }
    else if (Enable_Rot && !Enable_2)
    {
        if (Rotate >= 90)
        {
            Rotate = Rotate - 180;
            Enable_2 = true;
            Background.Texture = Texture_BG;
            [self GetMatrix];
        }
        else
        {
            [self Change_Smooth: &Rotate : 90.0f : 360.0f];
            [self GetMatrix];
        }
    }
    else if (Enable_Rot && Enable_2)
    {
        if (Rotate >= 0)
        {
            Rotate = 0;
            Enable_Rot = false;
            [self GetMatrix];
        }
        else
        {
            [self Change_Smooth: &Rotate : 0.0f : 360.0f];
            [self GetMatrix];
        }
    }
    else if (Enable_2)
    {
    }
 }

-(void)Draw
{
    glDisable(GL_DEPTH_TEST);
    Game_Data->effect.transform.projectionMatrix = Game_Data->ViewMatrix2D;
    if (!Enable_2)
    {
        [self DrawObject2DLocal: &Background];
    }
    else
    {
        switch (Game_Data->Status_Curent)
        {
            case Stat_Pause:
                [self DrawObject2DLocal: &Background];
                [self DrawObject2DLocal: &Button_MainMenu];
                [self DrawObject2DLocal: &Button_Restart];
                [self DrawObject2DLocal: &Button_Resume];
                break;
            case Stat_Lose:
                [self DrawObject2DLocal: &Background];
                [self DrawObject2DLocal: &Button_MainMenu];
                [self DrawObject2DLocal: &Button_Restart];
                break;
            case Stat_Win:
                [self DrawObject2DLocal: &Background];
                if (!Next_en)
                {
                    Game_Data->effect.constantColor = GLKVector4Make(0.5f, 0.5f, 0.5f, 0.5f);
                    [self DrawObject2DLocal: &Button_Next];
                    Game_Data->effect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
                }
                else
                {
                    [self DrawObject2DLocal: &Button_Next];
                }
                [self DrawObject2DLocal: &Button_MainMenu];
                [self DrawObject2DLocal: &Button_Restart];
                break;
        }
    }
    Game_Data->effect.transform.projectionMatrix = Game_Data->ViewMatrix3D;
    glEnable(GL_DEPTH_TEST);
}

-(void)DrawObject2DLocal : (struct Object2D*)obj
{
    [self BindBuffer2D : obj->Vertex : Vertex_Tex_Full : Vertex_Col_Full];
    
    Game_Data->effect.texture2d0.name = obj->Texture;
    Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Translate(Menu_Matrix, obj->Position[0], obj->Position[1], 0);
//    Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Rotate(Game_Data->effect.transform.modelviewMatrix, GLKMathDegreesToRadians(Rotate), 0.0f, 0.0f, 1.0f);
    [Game_Data->effect prepareToDraw];
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}

-(void)Touch_End: (NSSet *)touches
{
    if (!Touch_En)
        return;
    
    Touch_En = false;
    
    for (touch in touches)
    {
        location = [touch locationInView:Game_Data->view];
        location.x *= 2;
        location.y *= 2;
        break;
    }
    
    if (Enable_2 && !Enable_Rot)
    {
        switch (Game_Data->Status_Curent)
        {
            case Stat_Pause:
                if ([self Location_Touched: location.x - Position[0] : location.y - Position[1] : Button_Resume.Position[0] : Button_Resume.Position[1] : Button_Resume.Vertex[2] : Button_Resume.Vertex[5]])
                {
                    Game_Data->Status_Next = Stat_Resume;
                }
                else if ([self Location_Touched: location.x - Position[0] : location.y - Position[1] : Button_MainMenu.Position[0] : Button_MainMenu.Position[1] : Button_MainMenu.Vertex[2] : Button_MainMenu.Vertex[5]])
                {
                    Game_Data->Status_Next = Stat_MenuMain;
                }
                else if ([self Location_Touched: location.x - Position[0] : location.y - Position[1] : Button_Restart.Position[0] : Button_Restart.Position[1] : Button_Restart.Vertex[2] : Button_Restart.Vertex[5]])
                {
                    Game_Data->Status_Next = Stat_Restart;
                }
                break;
            case Stat_Lose:
                if ([self Location_Touched: location.x - Position[0] : location.y - Position[1] : Button_MainMenu.Position[0] : Button_MainMenu.Position[1] : Button_MainMenu.Vertex[2] : Button_MainMenu.Vertex[5]])
                {
                    Game_Data->Status_Next = Stat_MenuMain;
                }
                else if ([self Location_Touched: location.x - Position[0] : location.y - Position[1] : Button_Restart.Position[0] : Button_Restart.Position[1] : Button_Restart.Vertex[2] : Button_Restart.Vertex[5]])
                {
                    Game_Data->Status_Next = Stat_Restart;
                }
                break;
            case Stat_Win:
                if ([self Location_Touched: location.x - Position[0] : location.y - Position[1] : Button_Next.Position[0] : Button_Next.Position[1] : Button_Next.Vertex[2] : Button_Next.Vertex[5]])
                {
                    if (Next_en)
                        Game_Data->Status_Next = Stat_Next;
                }
                else if ([self Location_Touched: location.x - Position[0] : location.y - Position[1] : Button_MainMenu.Position[0] : Button_MainMenu.Position[1] : Button_MainMenu.Vertex[2] : Button_MainMenu.Vertex[5]])
                {
                    Game_Data->Status_Next = Stat_MenuMain;
                }
                else if ([self Location_Touched: location.x - Position[0] : location.y - Position[1] : Button_Restart.Position[0] : Button_Restart.Position[1] : Button_Restart.Vertex[2] : Button_Restart.Vertex[5]])
                {
                    Game_Data->Status_Next = Stat_Restart;
                }
                break;
        }
    }
    else if (Enable_1 && !Enable_Rot)
    {
        Enable_Rot = true;
        if (Game_Data->Status_Curent == Stat_Win)
            Game_Data->Score = Game_Data->Score_Calc;
    }
}

-(void)Touch_Move: (NSSet *)touches
{
}

-(void)Touch_Start: (NSSet *)touches
{
    if (Enable_1 || Enable_2)
    {
        if (!Enable_Rot)
        {
            Touch_En = true;
            return;
        }
    }
    Touch_En = false;
}

-(void)dealloc
{    
    //Кнопки
    glDeleteTextures(1, &Button_Resume.Texture);
    glDeleteTextures(1, &Button_Next.Texture);
    glDeleteTextures(1, &Button_MainMenu.Texture);
    glDeleteTextures(1, &Button_Restart.Texture);
    
    //Текстуры
    glDeleteTextures(1, &Texture_BG);
    glDeleteTextures(1, &Texture_Pause);
    glDeleteTextures(1, &Texture_Win);
    glDeleteTextures(1, &Texture_Lose);
    
	[super dealloc];
}
@end