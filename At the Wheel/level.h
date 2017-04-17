//
//  level.h
//  At the Wheel
//
//  Created by Negulus on 4/12/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#ifndef At_the_Wheel_level_h
#define At_the_Wheel_level_h

#include "game.h"

struct LevelSector
{
    int Surface[6];
    int Texture[6];
    int Type[6];
};

@interface GameLevel : Game
{
@public
    //Данные уровня
    struct LevelSector *Sectors;
    struct LevelObject *Objects;
    struct LevelCoin *Coins;
    struct LevelBonus *Bonus;
    struct Object *Object_All;
    int Sector_Count;
    int Object_Count;
    int Object_All_Count;
    int Coin_Count;
    int Bonus_Count;
    float Angle;
    float Angle_Full;
    int Point;
    int Car_Position;
    
    int i_level;
    int tmpui_level;
    
    NSString *path_l;
    NSString *xmlPath_l;
    NSString *fileString_l;
    NSArray *lines_l;
    NSArray *str_l;
}

-(id)init : (struct GameData*)data;
-(void)dealloc;
-(void)Reset;
-(void)Load;
@end

#endif
