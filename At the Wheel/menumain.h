//
//  menu.h
//  At the Wheel
//
//  Created by Администратор on 4/15/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#ifndef At_the_Wheel_menu_h
#define At_the_Wheel_menu_h

#include "game.h"

@interface MenuMain : Game
{
@public
    //Постоянные объекты
    struct Object2D Background;
    
    //Кнопки главного меню
    struct Object2D Button[4];
    
    //Игровые переменные
    float Position;
    float Position_tmp;
    float Position_V;
    
    //Системные переменные
    bool Touch_Point;
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
