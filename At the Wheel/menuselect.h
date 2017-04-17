//
//  menuselect.h
//  At the Wheel
//
//  Created by Администратор on 5/11/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#ifndef At_the_Wheel_menuselect_h
#define At_the_Wheel_menuselect_h

#include "game.h"

@interface MenuSelect : Game
{
@public
    //Объекты
    struct Object2D Background;
    struct Object2D Quest;
    struct Object2D Obj_World;
    struct Object2D Obj_Start;
    struct Object2D Obj_Reset;
    struct Object2D Obj_Button;
    struct Object2D Obj_Lock;
    struct Object2D Obj_Select;
    struct Object2DDigit Num_Big;
    struct Object2DDigit Num_Small;
    
    //Игровые переменные
    int Position;
    int Position_tmp;
    int Position_End;
    bool Select;
    
    //Системные переменные
    bool Touch_Point;
    bool Touch_Point_M;
    int i_sel;
    bool quest_en;
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
