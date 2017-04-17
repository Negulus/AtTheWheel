//
//  menuset.h
//  At the Wheel
//
//  Created by Администратор on 4/29/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#ifndef At_the_Wheel_menuset_h
#define At_the_Wheel_menuset_h

#include "game.h"

@interface MenuSet : Game
{
@public
    //Объекты
    struct Object2D Background;
    struct Object2D Obj_Text_Dif;
    struct Object2D Obj_Text_Con;
    struct Object2D Obj_Check;
    struct Object2D Obj_Dif_0;
    struct Object2D Obj_Dif_1;
    struct Object2D Obj_Con_0;
    struct Object2D Obj_Con_1;
    struct Object2D Obj_Color[4];
    
    //Переменные для машины
    struct Object Obj_Car;
    GLuint Texture_Car[4];
    float CamRotY;
    
    //Временное хранение настроек
    int Dif_tmp;
    int Con_tmp;
    int Color_tmp;
    
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
