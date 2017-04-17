//
//  play_hud.h
//  At the Wheel
//
//  Created by Negulus on 4/12/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#ifndef At_the_Wheel_play_hud_h
#define At_the_Wheel_play_hud_h

#include "game.h"

@interface GamePlayHUD : Game
{
@public
    //Постоянные объекты
    struct Object2D Hud_BG;
    struct Object2D Life_0;
    struct Object2D Life_1;
    struct Object2D Life_2;
    struct Object2D Life_3;
    struct Object2D Bonus_Fast;
    struct Object2D Bonus_IDDQD;
    struct Object2D Bonus_x2;
    struct Object2D Bonus_x4;
    struct Object2D Bonus_Time;
    struct Object2D Car_Mini;
    struct Object2D Screen_Broken;
    struct Object2D Score;
    struct Object2DDigit Score_Digit;
    struct Object2D BonusScreen;
    GLuint BonusScreen_Tex[5];
    
    //Системные переменные
    bool Life_Up;
    bool Life_Blink;
    bool Life_Blink_En;
    int Life_tmp;
    float Life_Blink_Time;
    float Life_Blink_Time_2;
    bool Broken;
    int Score_tmp;
    float Score_Time;
    float Bonus_Screen_Time[5];
}

-(id)init : (struct GameData*)data;
-(void)dealloc;
-(void)Reset;
-(void)Update;
-(void)Draw;
@end

#endif
