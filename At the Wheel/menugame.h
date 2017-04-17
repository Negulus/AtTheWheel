//
//  menugame.m
//  At the Wheel
//
//  Created by Администратор on 5/25/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#ifndef At_the_Wheel_menugame_h
#define At_the_Wheel_menugame_h

#import "game.h"

@interface MenuGame : Game
{
    //Матрица меню
    GLKMatrix4 Menu_Matrix;
    
    //Кнопки
    struct Object2D Button_Resume;
    struct Object2D Button_Next;
    struct Object2D Button_MainMenu;
    struct Object2D Button_Restart;
    
    //Текстуры
    struct Object2D Background;
    GLuint Texture_BG;
    GLuint Texture_Pause;
    GLuint Texture_Win;
    GLuint Texture_Lose;
    
    //Перемещение таблички
    float Position[2];
    float Scale;
    float Rotate;
    bool Enable;
    bool Enable_1;
    bool Enable_2;
    bool Enable_Rot;
    
    //Системные переменные
    bool Touch_En;
    float Time_Turn;
    float Score_tmp;
    bool Next_en;
}

-(id)init : (struct GameData*)data;
-(void)dealloc;
-(void)Reset;
-(void)Draw;
-(void)Update;
-(void)Touch_Start: (NSSet *)touches;
-(void)Touch_End: (NSSet *)touches;
-(void)Touch_Move: (NSSet *)touches;
-(void)Pause;
-(void)Win;
-(void)Lose;
-(void)DrawObject2DLocal : (struct Object2D*)obj;
@end


#endif