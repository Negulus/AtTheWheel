//
//  play.h
//  At the Wheel
//
//  Created by Negulus on 4/12/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#ifndef At_the_Wheel_play_h
#define At_the_Wheel_play_h

#include "game.h"
#include "level.h"
#include "play_hud.h"
#include "menugame.h"

@interface GamePlay : Game
{
@public
    //Данные уровня
    GameLevel *Game_Level;
    
    //Данные интерфейса игры
    GamePlayHUD *Game_Play_HUD;
    
    //Внутриигровое меню
    MenuGame *Menu_Game;

    //Дорога
    struct Road_Surface Surface[36];
    GLuint Road_Texture[10];
    
    //Текстуры стен
    GLuint Wall_Texture_1[6];
    GLuint Wall_Texture_2[16];
    
    //Выводимые данные
    struct SectorDraw Sector_Draw[6];
    struct ObjectDraw Object_Draw[16];
    struct CoinDraw Coin_Draw[16];
    struct BonusDraw Bonus_Draw[8];
    
    //Постоянные объекты
    struct ObjectCar Object_Car;
    struct Object Object_Circle;
    struct Object Object_Wall1;
    struct Object Object_Wall2;
    struct Object Object_Coin;
    struct Object Object_Root;
    struct Object Object_Room;
    struct Object Object_Room2;
    struct Object Object_Table;
    struct Object Object_Sky;
    struct Object Object_Bonus[5];
    struct Object Object_Root_m;
    struct Object Object_Wheel_m;
    struct Object Object_Speed_m;
    
    //Матрицы постоянных объектов
    GLKMatrix4 Object_Root_Matrix;
    GLKMatrix4 Object_Speed_Matrix;
    GLKMatrix4 Object_Wheel_Matrix;
    GLKMatrix4 Sector_6_Matrix;
    GLKMatrix4 Sector_7_Matrix;
    
    //Текстуры постоянных объектов
    GLuint Texture_Room;
    GLuint Texture_Root;
    GLuint Texture_Bonus;
    
    //Углы поворота управления
    float Object_Speed_Angle;
    float Object_Wheel_Angle;
    
    //Стрелки приборной панели
    struct Object Object_Arrow_1;
    struct Object Object_Arrow_2;
    struct Object Object_Arrow_3;
    GLKMatrix4 Object_Arrow_Matrix[4];
    float Object_Arrow_Angle[4];
    
    //Переменные для камеры
    float Camera_Pos[7];
    float Camera_Pos_1[7];
    float Camera_Pos_2[7];
    float Camera_Speed[7];
    bool Camera_1;
    float Camera_1_Time;
    bool Camera_2;
    float Camera_2_Time;
    
    //Игровые переменные
    bool Game_Start;
    bool Game_Win;
    bool Screen_Crack;
    int Coin_Bonus;
    float Game_Time;
    float Game_Win_Time;    
    float Car_Lose_Pos[4];
    float Car_Lose_Speed[6];
    float Speed;
    float Speed_gas;
    float Speed_road;
    float Speed_obj;
    float Obj_Time;
    
    //Переменные для тачпада
    struct TouchMove Touch_Gas;
    struct TouchMove Touch_Wheel;

    //Переменные для управления рулём
    float Wheel_Origin[2];
    bool Wheel_Hold;
    bool Turn_Left;
    bool Turn_Right;
    
    //Переменные для неуязвимости
    bool Car_Bounce;
    float Car_Bounce_Time;
    bool Car_IDDQD;
    float Car_IDDQD_Time;
    bool Car_IDDQD_Blink;
    float Car_IDDQD_Blink_Time;
    bool Car_Blink;
    float Car_Blink_Time;
}

-(id)init : (struct GameData*)data;
-(void)dealloc;
-(void)Reset;
-(void)Draw;
-(void)Update;
-(void)Touch_Start: (NSSet *)touches;
-(void)Touch_End: (NSSet *)touches;
-(void)Touch_Move: (NSSet *)touches;
@end

#endif
