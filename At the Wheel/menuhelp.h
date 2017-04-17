//
//  menuhelp.h
//  At the Wheel
//
//  Created by Администратор on 6/23/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#ifndef At_the_Wheel_menuhelp_h
#define At_the_Wheel_menuhelp_h

#include "game.h"

@interface MenuHelp : Game
{
@public
    //Объекты
    struct Object2D Background;
    struct Object2D Text;
    
    //Игровые переменные
    float Position;
    float Position_tmp;
    
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
