//
//  newgame.h
//  At the Wheel
//
//  Created by Администратор on 7/2/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#ifndef At_the_Wheel_newgame_h
#define At_the_Wheel_newgame_h

#include "game.h"

//Структура разных поверхностей дороги
struct Camera_Position
{
    float pos_x;
    float pos_y;
    float pos_z;
    float rot_x;
    float rot_y;
    float rot_z;
};

@interface NewGame : Game
{
@public
    //Дорога
    struct Road_Surface Surface[6];
    GLuint Road_Texture[3];
    
    //Текстуры стен
    GLuint Wall_Texture_1[8];
    GLuint Wall_Texture_2[8];
    
    //Выводимые данные
    struct SectorDraw Sector_Draw;
    
    //Постоянные объекты
    struct Object2D Loading;
    struct Object Object_Car;
    struct Object Object_Circle;
    struct Object Object_Wall1;
    struct Object Object_Wall2;
    struct Object Object_Root;
    struct Object Object_Room;
    struct Object Object_Room2;
    struct Object Object_Table;
    struct Object Object_Sky;
    struct Object Object_Present_1;
    struct Object Object_Present_2;
    struct Object Object_Present_3;
    struct Object Object_Present_4;
    
    //Положения камеры
    struct Camera_Position Cam_Pos[4];
    struct Camera_Position Cam_Position;
    struct Camera_Position Cam_Speed;
    
    //Матрицы постоянных объектов
    GLKMatrix4 Object_Root_Matrix;
    GLKMatrix4 Object_Car_Matrix;
    GLKMatrix4 Sector_Matrix[7];
    
    //Текстуры постоянных объектов
     GLuint Texture_Room;
    GLuint Texture_Root;
    GLuint Texture_Car;
    GLuint Texture_Present;

    //Системные переменные
    float Timer_tmp;
    int Status;
    bool present_1;
    bool present_2;
    bool present_3;
    bool present_4;
    bool root_road;
    float fade;
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
