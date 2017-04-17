//
//  play.m
//  At the Wheel
//
//  Created by Администратор on 4/12/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#import "play.h"
#include "roads.h"

@implementation GamePlay
-(id)init : (struct GameData*)data
{
    self = [super init : data];
    if (self)
    {
        //Дорога
        //Инициализация данных дороги, 36 разных поверхностей
        Surface[0].Vertex = RoadLine_1;
        [self RoadInit : &Surface[0] : 240];
        Surface[1].Vertex = RoadLine_2;
        [self RoadInit : &Surface[1] : 240];
        Surface[2].Vertex = RoadLine_3;
        [self RoadInit : &Surface[2] : 240];
        Surface[3].Vertex = RoadLine_4;
        [self RoadInit : &Surface[3] : 240];
        Surface[4].Vertex = RoadLine_5;
        [self RoadInit : &Surface[4] : 240];
        Surface[5].Vertex = RoadLine_6;
        [self RoadInit : &Surface[5] : 240];
        
        Surface[6].Vertex = RoadTurn_1_2;
        [self RoadInit : &Surface[6] : 240];
        Surface[7].Vertex = RoadTurn_2_3;
        [self RoadInit : &Surface[7] : 240];
        Surface[8].Vertex = RoadTurn_3_4;
        [self RoadInit : &Surface[8] : 240];
        Surface[9].Vertex = RoadTurn_4_5;
        [self RoadInit : &Surface[9] : 240];
        Surface[10].Vertex = RoadTurn_5_6;
        [self RoadInit : &Surface[10] : 240];
        Surface[11].Vertex = RoadTurn_2_1;
        [self RoadInit : &Surface[11] : 240];
        Surface[12].Vertex = RoadTurn_3_2;
        [self RoadInit : &Surface[12] : 240];
        Surface[13].Vertex = RoadTurn_4_3;
        [self RoadInit : &Surface[13] : 240];
        Surface[14].Vertex = RoadTurn_5_4;
        [self RoadInit : &Surface[14] : 240];
        Surface[15].Vertex = RoadTurn_6_5;
        [self RoadInit : &Surface[15] : 240];
        
        Surface[16].Vertex = RoadExp_1_2;
        [self RoadInit : &Surface[16] : 240];
        Surface[17].Vertex = RoadExp_2_3;
        [self RoadInit : &Surface[17] : 240];
        Surface[18].Vertex = RoadExp_3_4;
        [self RoadInit : &Surface[18] : 240];
        Surface[19].Vertex = RoadExp_4_5;
        [self RoadInit : &Surface[19] : 240];
        Surface[20].Vertex = RoadExp_5_6;
        [self RoadInit : &Surface[20] : 240];
        Surface[21].Vertex = RoadExp_2_1;
        [self RoadInit : &Surface[21] : 240];
        Surface[22].Vertex = RoadExp_3_2;
        [self RoadInit : &Surface[22] : 240];
        Surface[23].Vertex = RoadExp_4_3;
        [self RoadInit : &Surface[23] : 240];
        Surface[24].Vertex = RoadExp_5_4;
        [self RoadInit : &Surface[24] : 240];
        Surface[25].Vertex = RoadExp_6_5;
        [self RoadInit : &Surface[25] : 240];
        
        Surface[26].Vertex = RoadInflow_1_2;
        [self RoadInit : &Surface[26] : 240];
        Surface[27].Vertex = RoadInflow_2_3;
        [self RoadInit : &Surface[27] : 240];
        Surface[28].Vertex = RoadInflow_3_4;
        [self RoadInit : &Surface[28] : 240];
        Surface[29].Vertex = RoadInflow_4_5;
        [self RoadInit : &Surface[29] : 240];
        Surface[30].Vertex = RoadInflow_5_6;
        [self RoadInit : &Surface[30] : 240];
        Surface[31].Vertex = RoadInflow_2_1;
        [self RoadInit : &Surface[31] : 240];
        Surface[32].Vertex = RoadInflow_3_2;
        [self RoadInit : &Surface[32] : 240];
        Surface[33].Vertex = RoadInflow_4_3;
        [self RoadInit : &Surface[33] : 240];
        Surface[34].Vertex = RoadInflow_5_4;
        [self RoadInit : &Surface[34] : 240];
        Surface[35].Vertex = RoadInflow_6_5;
        [self RoadInit : &Surface[35] : 240];
        
        //Инициализация текстур дороги, 7 изображений
        Road_Texture[0] = [self Load_Texture:@"road_1"];
        Road_Texture[1] = [self Load_Texture:@"road_2"];
        Road_Texture[2] = [self Load_Texture:@"road_3"];
        Road_Texture[3] = [self Load_Texture:@"road_4"];
        Road_Texture[4] = [self Load_Texture:@"road_5"];
        Road_Texture[5] = [self Load_Texture:@"road_6"];
        Road_Texture[6] = [self Load_Texture:@"road_7"];
        Road_Texture[7] = [self Load_Texture:@"road_8"];
        Road_Texture[8] = [self Load_Texture:@"road_9"];
        Road_Texture[9] = [self Load_Texture:@"road_10"];
        
        //Текстуры стен
        Wall_Texture_1[0] = [self Load_Texture:@"wall1_01"];
        Wall_Texture_1[1] = [self Load_Texture:@"wall1_02"];
        Wall_Texture_1[2] = [self Load_Texture:@"wall1_03"];
        Wall_Texture_1[3] = [self Load_Texture:@"wall1_04"];
        Wall_Texture_1[4] = [self Load_Texture:@"wall1_05"];
        Wall_Texture_1[5] = [self Load_Texture:@"wall1_06"];
        Wall_Texture_2[0] = [self Load_Texture:@"wall2_01"];
        Wall_Texture_2[1] = [self Load_Texture:@"wall2_02"];
        Wall_Texture_2[2] = [self Load_Texture:@"wall2_03"];
        Wall_Texture_2[3] = [self Load_Texture:@"wall2_04"];
        Wall_Texture_2[4] = [self Load_Texture:@"wall2_05"];
        Wall_Texture_2[5] = [self Load_Texture:@"wall2_06"];
        Wall_Texture_2[6] = [self Load_Texture:@"wall2_07"];
        Wall_Texture_2[7] = [self Load_Texture:@"wall2_08"];
        Wall_Texture_2[8] = [self Load_Texture:@"wall2_09"];
        Wall_Texture_2[9] = [self Load_Texture:@"wall2_10"];
        Wall_Texture_2[10] = [self Load_Texture:@"wall2_11"];
        Wall_Texture_2[11] = [self Load_Texture:@"wall2_12"];
        Wall_Texture_2[12] = [self Load_Texture:@"wall2_13"];
        Wall_Texture_2[13] = [self Load_Texture:@"wall2_14"];
        Wall_Texture_2[14] = [self Load_Texture:@"wall2_15"];
        Wall_Texture_2[15] = [self Load_Texture:@"wall2_16"];
        
        //Загрузка машины
        [self Load_Object: &Object_Car.Obj : @"car.txt"];
        [self Load_Object: &Object_Car.Tire : @"tire.txt"];
        switch (Game_Data->Set_Color) {
            case 1:
                Object_Car.Obj.Texture = [self Load_Texture:@"car_1"];
                break;
            case 2:
                Object_Car.Obj.Texture = [self Load_Texture:@"car_2"];
                break;
            case 3:
                Object_Car.Obj.Texture = [self Load_Texture:@"car_3"];
                break;
            default:
                Object_Car.Obj.Texture = [self Load_Texture:@"car_0"];
                break;
        }
        
        //Постоянные объекты        
        [self Load_Object: &Object_Circle : @"circle.txt"];
        [self Load_Object: &Object_Wall1 : @"wall1.txt"];
        [self Load_Object: &Object_Wall2 : @"wall2.txt"];
        [self Load_Object: &Object_Coin : @"coin.txt"];
        [self Load_Object: &Object_Root : @"root.txt"];
        [self Load_Object: &Object_Room : @"room.txt"];
        [self Load_Object: &Object_Room2 : @"room2.txt"];
        [self Load_Object: &Object_Table : @"table.txt"];
        [self Load_Object: &Object_Sky : @"sky.txt"];
        [self Load_Object: &Object_Bonus[0] : @"bonus_0.txt"]; //Неуязвимость
        [self Load_Object: &Object_Bonus[1] : @"bonus_1.txt"]; //Двойные очки
        [self Load_Object: &Object_Bonus[2] : @"bonus_2.txt"]; //Ускорение
        [self Load_Object: &Object_Bonus[3] : @"bonus_3.txt"]; //Жизнь
        [self Load_Object: &Object_Bonus[4] : @"bonus_4.txt"]; //Смерть
        [self Load_Object: &Object_Root_m : @"root-mini.txt"];
        [self Load_Object: &Object_Wheel_m : @"wheel-mini.txt"];
        [self Load_Object: &Object_Speed_m : @"speed-mini.txt"];
        
        //Текстуры постоянных объектов
        Texture_Room = [self Load_Texture:@"room"];
        Texture_Root = [self Load_Texture:@"root"];
        Texture_Bonus = [self Load_Texture:@"bonus"];
        
        //Стрелки приборной панели
        [self Load_Object: &Object_Arrow_1 : @"arrow-mini-1.txt"];
        [self Load_Object: &Object_Arrow_2 : @"arrow-mini-2.txt"];
        [self Load_Object: &Object_Arrow_3 : @"arrow-mini-3.txt"];
        
        //Данные уровня
        Game_Level = [[GameLevel alloc] init : Game_Data];
        
        //Данные интерфейса игры
        Game_Play_HUD = [[GamePlayHUD alloc] init : Game_Data];
        
        //Внутриигровое меню
        Menu_Game = [[MenuGame alloc] init : Game_Data];
        
        [self Reset];
    }
    return self;
}

-(void)RoadInit : (struct Road_Surface*)obj : (int)count;
{
    glGenVertexArraysOES(1, &obj->Array);
    glBindVertexArrayOES(obj->Array);
    glGenBuffers(1, &obj->Buffer);
    glBindBuffer(GL_ARRAY_BUFFER, obj->Buffer);
    glBufferData(GL_ARRAY_BUFFER, (sizeof(GLfloat) * count), obj->Vertex, GL_DYNAMIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(12));
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(24));
}

-(void)Reset
{
    //Загрузка машины
    Object_Car.Position[0] = Game_Level->Car_Position;
    Object_Car.Position[1] = 0;
    Object_Car.Matrix = Game_Data->CameraMatrix;
    Object_Car.Tire_Matrix[0] = Game_Data->CameraMatrix;
    Object_Car.Tire_Matrix[1] = Game_Data->CameraMatrix;
    Object_Car.Tire_Matrix[2] = Game_Data->CameraMatrix;
    Object_Car.Tire_Matrix[3] = Game_Data->CameraMatrix;
    Object_Car.Tire_Angle = 0;
    
    //Матрицы постоянных объектов
    Object_Root_Matrix = Game_Data->CameraMatrix;
    Object_Speed_Matrix = Game_Data->CameraMatrix;
    Object_Wheel_Matrix = Game_Data->CameraMatrix;
    Sector_6_Matrix = Game_Data->CameraMatrix;
    Sector_7_Matrix = Game_Data->CameraMatrix;
    
    //Углы поворота управления
    Object_Speed_Angle = 45;
    Object_Wheel_Angle = 0;
    
    //Стрелки приборной панели
    Object_Arrow_Matrix[0] = Game_Data->CameraMatrix;
    Object_Arrow_Matrix[1] = Game_Data->CameraMatrix;
    Object_Arrow_Matrix[2] = Game_Data->CameraMatrix;
    Object_Arrow_Matrix[3] = Game_Data->CameraMatrix;
    Object_Arrow_Angle[0] = 0;
    Object_Arrow_Angle[1] = 0;
    Object_Arrow_Angle[2] = 0;
    Object_Arrow_Angle[3] = 0;
    
    //Переменные для камеры
    Camera_Pos[0] = 30;
    Camera_Pos[1] = 0;
    Camera_Pos[2] = 0;//-90;
    Camera_Pos[3] = 0;
    Camera_Pos[4] = -300;//130
    Camera_Pos[5] = -180;//140
    Camera_Pos[6] = -700;//229
    Camera_Pos_1[0] = 10;
    Camera_Pos_1[1] = 0;
    Camera_Pos_1[2] = 0;//-90;
    Camera_Pos_1[3] = -57;
    Camera_Pos_1[4] = 10;
    Camera_Pos_1[5] = -140;
    Camera_Pos_1[6] = 95;
    Camera_Pos_2[0] = 21;
    Camera_Pos_2[1] = 0;
    Camera_Pos_2[2] = 0;//-90;
    Camera_Pos_2[3] = -57;
    Camera_Pos_2[4] = 4;
    Camera_Pos_2[5] = -140;
    Camera_Pos_2[6] = 45;
    for (i = 0; i < 7; i++)
    {
        Camera_Speed[i] = (Camera_Pos_1[i] - Camera_Pos[i]) * 0.5f;
        if (Camera_Speed[i] < 0)
            Camera_Speed[i] *= -1;
    }
    Camera_1 = false;
    Camera_1_Time = 0.4f;
    Camera_2 = false;
    Camera_2_Time = 0.15f;
    
    //Игровые переменные
    Game_Start = false;
    Game_Win = false;
    Screen_Crack = false;
    Coin_Bonus = 0;
    Game_Time = 0;
    Game_Win_Time = 0;
    Speed = 0;
    Speed_gas = 0;
    Speed_road = 0;
    Speed_obj = 1.0f;
    Obj_Time = 0;
    Car_Lose_Pos[0] = 0;
    Car_Lose_Pos[1] = 0;
    Car_Lose_Pos[2] = 0;
    Car_Lose_Pos[3] = 0;
    Car_Lose_Speed[0] = 0;
    Car_Lose_Speed[1] = 0;
    Car_Lose_Speed[2] = 0;
    Car_Lose_Speed[3] = 0;
    Car_Lose_Speed[4] = 0;
    Car_Lose_Speed[5] = 0;
    
    //Переменные для тачпада
    Touch_Gas.tmp = 0;
    Touch_Gas.touch_id = -1;
    Touch_Wheel.tmp = 0;
    Touch_Wheel.touch_id = -1;
    
    //Переменные для управления рулём
    Wheel_Origin[0] = 415 * 2;
    Wheel_Origin[1] = 284 * 2;
    Wheel_Hold = false;
    Turn_Left = false;
    Turn_Right = false;
    
    //Переменные для неуязвимости
    Car_Bounce = false;
    Car_Bounce_Time = 0;
    Car_IDDQD = false;
    Car_IDDQD_Time = 0;
    Car_IDDQD_Blink = false;
    Car_IDDQD_Blink_Time = 0;
    Car_Blink = false;
    Car_Blink_Time = 0;
    
    //Данные уровня
    [Game_Level Reset];
    
    //Данные интерфейса игры
    [Game_Play_HUD Reset];
    
    //Внутриигровое меню
    [Menu_Game Reset];
    
    //Выводимые данные
    for (i = 0; i < 6; i++)
    {
        if (Game_Level->Sectors[Game_Level->Point].Surface[i] > 0)
        {
            Sector_Draw[0].Surface[i] = &Surface[Game_Level->Sectors[Game_Level->Point].Surface[i] - 1];
            Sector_Draw[0].Texture[i] = Road_Texture[Game_Level->Sectors[Game_Level->Point].Texture[i] - 1];
            Sector_Draw[0].Type[i] = Game_Level->Sectors[Game_Level->Point].Type[i];
            Sector_Draw[0].Surf[i] = Game_Level->Sectors[Game_Level->Point].Surface[i];
            Sector_Draw[0].Enable[i] = true;
        }
        else
        {
            Sector_Draw[0].Enable[i] = false;
        }
    }
    Sector_Draw[0].Texture_Wall[0] = (int)(((double)rand() / (double)RAND_MAX) * 5.0f);
    Sector_Draw[0].Texture_Wall[1] = (int)(((double)rand() / (double)RAND_MAX) * 15.0f);
    
    for (i = 1; i < 3; i++)
    {
        Sector_Draw[i] = Sector_Draw[0];
        Sector_Draw[i].Texture_Wall[0] = (int)(((double)rand() / (double)RAND_MAX) * 5.0f);
        Sector_Draw[i].Texture_Wall[1] = (int)(((double)rand() / (double)RAND_MAX) * 15.0f);
    }
    
    for (j = 3; j < 6; j++)
    {
        if (Game_Level->Point >= Game_Level->Sector_Count)
            break;
        for (i = 0; i < 6; i++)
        {
            if (Game_Level->Sectors[Game_Level->Point].Surface[i] > 0)
            {
                Sector_Draw[j].Surface[i] = &Surface[Game_Level->Sectors[Game_Level->Point].Surface[i] - 1];
                Sector_Draw[j].Texture[i] = Road_Texture[Game_Level->Sectors[Game_Level->Point].Texture[i] - 1];
                Sector_Draw[j].Type[i] = Game_Level->Sectors[Game_Level->Point].Type[i];
                Sector_Draw[j].Surf[i] = Game_Level->Sectors[Game_Level->Point].Surface[i];
                Sector_Draw[j].Enable[i] = true;
            }
            else
            {
                Sector_Draw[j].Enable[i] = false;
            }
        }
        Sector_Draw[j].Texture_Wall[0] = (int)(((double)rand() / (double)RAND_MAX) * 5.0f);
        Sector_Draw[j].Texture_Wall[1] = (int)(((double)rand() / (double)RAND_MAX) * 15.0f);
        Game_Level->Point += 1;
    }
    Game_Level->Point -= 1;
    
    for (i = 0; i < 16; i++)
    {
        Object_Draw[i].Enable = false;
        Object_Draw[i].Obj = 0;
        Object_Draw[i].Position[0] = 0;
        Object_Draw[i].Position[1] = 0;
        Object_Draw[i].Matrix = Game_Data->CameraMatrix;
        
        Coin_Draw[i].Enable = false;
        Coin_Draw[i].Obj = 0;
        Coin_Draw[i].Coin = 0;
        Coin_Draw[i].Position[0] = 0;
        Coin_Draw[i].Position[1] = 0;
        Coin_Draw[i].Position[2] = 0;
        Coin_Draw[i].Matrix = Game_Data->CameraMatrix;
        if (i < 8)
        {
            Bonus_Draw[i].Enable = false;
            Bonus_Draw[i].Obj = 0;
            Bonus_Draw[i].Bonus = 0;
            Bonus_Draw[i].Position[0] = 0;
            Bonus_Draw[i].Position[1] = 0;
            Bonus_Draw[i].Matrix = Game_Data->CameraMatrix;
        }
    }
    
    //Внешние переменные
    Game_Data->Score = 0;
    Game_Data->Life = 3;
    Game_Data->Bonus_Fast = false;
    Game_Data->Bonus_IDDQD = false;
    Game_Data->Bonus_x2 = false;
    Game_Data->Bonus_Fast_Time = 0;
    Game_Data->Bonus_IDDQD_Time = 0;
    Game_Data->Bonus_x2_Time = 0;
    
    //Настройки камеры 3D
    Game_Data->CameraMatrix = GLKMatrix4MakeTranslation(0, 0, Camera_Pos[5]);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(Camera_Pos[2]), 0.0f, 0.0f, 1.0f);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(Camera_Pos[0]), 1.0f, 0.0f, 0.0f);
    Game_Data->CameraMatrix = GLKMatrix4Translate(Game_Data->CameraMatrix, Camera_Pos[3], Camera_Pos[4], Camera_Pos[6]);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(Camera_Pos[1]), 0.0f, 1.0f, 0.0f);
    
    //Настройки камеры 2D
    Game_Data->HUDMatrix = GLKMatrix4MakeTranslation(0, 0, 0);
    //        Game_Data->HUDMatrix = GLKMatrix4Rotate(Game_Data->HUDMatrix, GLKMathDegreesToRadians(90), 0.0f, 0.0f, 1.0f);
    Game_Data->HUDMatrix = GLKMatrix4Scale(Game_Data->HUDMatrix, 0.5f, 0.5f, 0.0f);
    
    Game_Data->effect.light0.diffuseColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    Game_Data->effect.light0.specularColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    Game_Data->effect.light0.ambientColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    
    Game_Data->effect.light1.diffuseColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    Game_Data->effect.light1.specularColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    Game_Data->effect.light1.ambientColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
}

-(void)Update
{
    //Обновление игрового меню
    if (Game_Data->Status_Curent != Stat_Play)
    {
        [Menu_Game Update];
        if (Game_Data->Status_Curent == Stat_Win)
            [Game_Play_HUD Update];
        return;
    }
    
    if (Game_Start)
        Game_Time += Game_Data->timeSinceLastUpdate;
    
    //Перемещение камеры
    if (!Camera_1)
    {
        if ([self Timer: &Camera_1_Time])
        {
            for (i = 0; i < 7; i++)
            {
                [self Change_Smooth : &Camera_Pos[i] : Camera_Pos_1[i] : Camera_Speed[i]];
            }
            if (Camera_Pos[0] == Camera_Pos_1[0])
            {
                Camera_1 = true;
                for (i = 0; i < 7; i++)
                {
                    Camera_Speed[i] = (Camera_Pos_2[i] - Camera_Pos[i]) * 1.0f;
                    if (Camera_Speed[i] < 0)
                        Camera_Speed[i] *= -1;
                }
            }
        }
    }
    else if (!Camera_2)
    {
        if ([self Timer: &Camera_2_Time])
        {
            for (i = 0; i < 7; i++)
            {
                [self Change_Smooth : &Camera_Pos[i] : Camera_Pos_2[i] : Camera_Speed[i]];
            }
            if (Camera_Pos[0] == Camera_Pos_2[0])
            {
                Camera_2 = true;
            }
        }
    }
    
    //Обновление матрицы камеры
    Game_Data->CameraMatrix = GLKMatrix4MakeTranslation(0, 0, Camera_Pos[5]);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(Camera_Pos[2]), 0.0f, 0.0f, 1.0f);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(Camera_Pos[0]), 1.0f, 0.0f, 0.0f);
    Game_Data->CameraMatrix = GLKMatrix4Translate(Game_Data->CameraMatrix, Camera_Pos[3], Camera_Pos[4], Camera_Pos[6]);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(Camera_Pos[1]), 0.0f, 1.0f, 0.0f);
    
    //Обновление результата столкновения
    if ([self Timer:&Obj_Time])
        Speed_obj = 1.0f;
    
    if (Game_Win)
        [self Change_Smooth : &Speed : 0 : 2.0f];
    else
    {
        if (Game_Data->Bonus_Fast)
            tmpf = Speed_gas * Speed_road * Speed_obj * 1.5f;
        else
            tmpf = Speed_gas * Speed_road * Speed_obj;
        
        if (tmpf < Speed)
        {
            [self Change_Smooth : &Speed : tmpf : 1.5f];
        }
        else
        {
            [self Change_Smooth : &Speed : tmpf : 0.5f];
        }
    }
    
    if (Game_Data->Set_Con == 0)
    {
        Game_Data->Accel[1] = 0;
    }
    
    if (Game_Data->Set_Dif == 0)
    {
        if ((Game_Data->Accel[1] > 0.2f) && !Wheel_Hold)
        {
            Turn_Left = true;
            [self Change_Smooth: &Object_Wheel_Angle : (Game_Data->Accel[1] * 90) : 360 * Speed];
        }
        else if ((Game_Data->Accel[1] < -0.2f) && !Wheel_Hold)
        {
            Turn_Right = true;
            [self Change_Smooth: &Object_Wheel_Angle : (Game_Data->Accel[1] * 90) : 360 * Speed];
        }
        else
        {
            if (!Wheel_Hold)
                [self Change_Smooth: &Object_Wheel_Angle : 0 : 360 * Speed];
        }
    }
    else
    {
        if (!Wheel_Hold)
        {
            [self Change_Smooth: &Object_Wheel_Angle : (Game_Data->Accel[1] * 90) : 360 * Speed];
        }
    }
    
    if (!Screen_Crack)
    {
        //Поворот машины
        Object_Car.Turn_Angle = Speed * Object_Wheel_Angle * 0.5f;
        
        //Перемещение машины
        Object_Car.Position[0] -= Object_Car.Turn_Angle * 0.05;
        if (Object_Car.Position[0] < 30)
            Object_Car.Position[0] = 30;
        else if (Object_Car.Position[0] > 90)
            Object_Car.Position[0] = 90;
    }
    
    //Центровка машины в простом режиме
    if (Game_Data->Set_Dif == 0 && !Wheel_Hold && !Screen_Crack)
    {
        if (Object_Car.Position[0] == 35 || Object_Car.Position[0] == 45 || Object_Car.Position[0] == 55 || Object_Car.Position[0] == 65 || Object_Car.Position[0] == 75 || Object_Car.Position[0] == 85)
        {
            Turn_Left = false;
            Turn_Right = false;
        }
        else if (Turn_Left)
        {
            if (Object_Car.Position[0] < 45)
            {
                [self Change_Smooth: &Object_Car.Position[0] : 35 : 20 * Speed];
            }
            else if (Object_Car.Position[0] < 55)
            {
                [self Change_Smooth: &Object_Car.Position[0] : 45 : 20 * Speed];
            }
            else if (Object_Car.Position[0] < 65)
            {
                [self Change_Smooth: &Object_Car.Position[0] : 55 : 20 * Speed];
            }
            else if (Object_Car.Position[0] < 75)
            {
                [self Change_Smooth: &Object_Car.Position[0] : 65 : 20 * Speed];
            }
            else if (Object_Car.Position[0] < 85)
            {
                [self Change_Smooth: &Object_Car.Position[0] : 75 : 20 * Speed];
            }
            else
            {
                [self Change_Smooth: &Object_Car.Position[0] : 85 : 20 * Speed];
            }
        }
        else if (Turn_Right)
        {
            if (Object_Car.Position[0] > 75)
            {
                [self Change_Smooth: &Object_Car.Position[0] : 85 : 20 * Speed];
            }
            else if (Object_Car.Position[0] > 65)
            {
                [self Change_Smooth: &Object_Car.Position[0] : 75 : 20 * Speed];
            }
            else if (Object_Car.Position[0] > 55)
            {
                [self Change_Smooth: &Object_Car.Position[0] : 65 : 20 * Speed];
            }
            else if (Object_Car.Position[0] > 45)
            {
                [self Change_Smooth: &Object_Car.Position[0] : 55 : 20 * Speed];
            }
            else if (Object_Car.Position[0] > 35)
            {
                [self Change_Smooth: &Object_Car.Position[0] : 45 : 20 * Speed];
            }
            else
            {
                [self Change_Smooth: &Object_Car.Position[0] : 35 : 20 * Speed];
            }
        }
    }
    
    //Вибрация
    if (Object_Car.Shake_Stat > 0 && Game_Start && !Car_Bounce)
    {
        if (Object_Car.Shake_Stat == 1)
        {
            Object_Car.Shake += Game_Data->timeSinceLastUpdate * 20 * Speed;
            if (Object_Car.Shake >= Object_Car.Shake_Max)
            {
                Object_Car.Shake_Stat = 2;
                Object_Car.Shake = Object_Car.Shake_Max;
            }
        }
        else
        {
            Object_Car.Shake -= Game_Data->timeSinceLastUpdate * 20 * Speed;
            if (Object_Car.Shake <= 0)
            {
                Object_Car.Shake_Stat = 1;
                Object_Car.Shake = 0;
            }
        }
    }
    else
    {
        [self Change_Smooth : &Object_Car.Shake : 0 : 1.0f];
    }
    
    //Поворот дороги
    if (Game_Start)
    {
        tmpf = Game_Data->timeSinceLastUpdate * 80 * Speed;
        Game_Level->Angle += tmpf;
        Game_Level->Angle_Full += tmpf;
        
        Object_Car.Tire_Angle += tmpf * 10.0f;
        
        if (Car_Bounce)
        {
            if (!Screen_Crack)
            {
                Object_Car.Position[1] += tmpf;
            }
        }
    }
    
    //Пройденый путь
    
    if (!Game_Win)
    {
        Game_Data->Level_Passed = ((float)Game_Level->Point - 2) / (float)(Game_Level->Sector_Count + 1);
        if (Game_Data->Level_Passed > 1)
            Game_Data->Level_Passed = 1;
    }
    
    [self Update_Sector];
    [self Update_Car];
    [self Update_Root];
    if (!Game_Win)
    {
        [self Update_Object];
        [self Update_Coin];
        [self Update_Bonus];
    }
    else if ([self Timer: &Game_Win_Time])
    {
        Game_Data->Score_Calc = ((Game_Level->Sector_Count * SECTOR_TIME) - Game_Time) * COINS_SECOND;
        if (Game_Data->Score_Calc < 0)
            Game_Data->Score_Calc = 0;
        Game_Data->Status_Next = Stat_Win;
    }
    
    [Game_Play_HUD Update];
}

-(void)Update_Sector
{
    //Обновление дороги во время движения
    if (Game_Level->Angle >= 45)
    {
        Game_Level->Point += 1;
        tmpi = Game_Level->Point;
        if (Game_Level->Point > (Game_Level->Sector_Count + 3))
        {
            Game_Win = true;
            Game_Win_Time = 2.0f;
        }
        
        if (Game_Level->Point > (Game_Level->Sector_Count - 1))
        {
            tmpi = Game_Level->Sector_Count - 1;
        }
        
        Game_Level->Angle = Game_Level->Angle - 45;
        Sector_Draw[0] = Sector_Draw[1];
        Sector_Draw[1] = Sector_Draw[2];
        Sector_Draw[2] = Sector_Draw[3];
        Sector_Draw[3] = Sector_Draw[4];
        Sector_Draw[4] = Sector_Draw[5];
        for (i = 0; i < 6; i++)
        {
            if (Game_Level->Sectors[tmpi].Surface[i] != 0)
            {
                Sector_Draw[5].Surface[i] = &Surface[Game_Level->Sectors[tmpi].Surface[i] - 1];
                Sector_Draw[5].Texture[i] = Road_Texture[Game_Level->Sectors[tmpi].Texture[i] - 1];
                Sector_Draw[5].Type[i] = Game_Level->Sectors[tmpi].Type[i];
                Sector_Draw[5].Surf[i] = Game_Level->Sectors[tmpi].Surface[i];
                Sector_Draw[5].Enable[i] = true;
            }
            else
            {
                Sector_Draw[5].Enable[i] = false;
                Sector_Draw[5].Type[i] = 0;
                Sector_Draw[5].Surf[i] = 0;
            }
        }
        Sector_Draw[5].Texture_Wall[0] = (int)(((double)rand() / (double)RAND_MAX) * 5.0f);
        Sector_Draw[5].Texture_Wall[1] = (int)(((double)rand() / (double)RAND_MAX) * 15.0f);
    }
    
    //Просчёт матриц секторов
    for (i = 0; i < 6; i++)
    {
        Sector_Draw[i].Matrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, 0.0f);
        Sector_Draw[i].Matrix = GLKMatrix4Rotate(Sector_Draw[i].Matrix, GLKMathDegreesToRadians(Game_Level->Angle - (i * 45) + 45), 0.0f, -1.0f, 0.0f);
        Sector_Draw[i].Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_Draw[i].Matrix);
    }
    
    Sector_6_Matrix = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(Game_Level->Angle - 225), 0.0f, -1.0f, 0.0f);
    Sector_6_Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_6_Matrix);
    Sector_7_Matrix = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(Game_Level->Angle - 270), 0.0f, -1.0f, 0.0f);
    Sector_7_Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_7_Matrix);
}

-(void)Update_Car
{
    //Если неуязвима
    if (Car_IDDQD)
    {
        //Если больше не неуязвима
        if ([self Timer: &Car_IDDQD_Time])
        {
            Car_IDDQD = false;
        }
        else
        {
            //Если рано мигать
            if (!Car_IDDQD_Blink)
            {
                if ([self Timer: &Car_IDDQD_Blink_Time])
                {
                    Car_IDDQD_Blink = true;
                    Car_Blink = false;
                    Car_Blink_Time = 0.15f;
                }
            }
            else
            {
                if ([self Timer: &Car_Blink_Time])
                {
                    Car_Blink_Time = 0.25f;
                    if (Car_Blink)
                        Car_Blink = false;
                    else
                        Car_Blink = true;
                }
            }
        }
    }

    if (!Car_Bounce)
    {       
        Car_Bounce_Time = 2.0f;
        tmpi = [self On_Road: &Sector_Draw[2] : &Object_Car : Game_Level->Angle];
//        NSLog(@"Road type = %d", tmpi);
        switch (tmpi) {
            case 1:
                Speed_road = 1.0f;
                Object_Car.Shake_Stat = 0;
                break;
            case 2:
                Speed_road = 1.0f;
                if (Object_Car.Shake_Stat == 0)
                {
                    Object_Car.Shake_Stat = 1;
                    Object_Car.Shake_Max = 0.5f;
                }
                break;
            case 3:
                Speed_road = 0.7f;
                Object_Car.Shake_Stat = 0;
                break;
            case 4:
                Speed_road = 0.7f;
                if (Object_Car.Shake_Stat == 0)
                {
                    Object_Car.Shake_Stat = 1;
                    Object_Car.Shake_Max = 0.5f;
                }
                break;
            case 5:
                Speed_road = 0.4f;
                Object_Car.Shake_Stat = 0;
                break;
            case 6:
                Speed_road = 0.4f;
                if (Object_Car.Shake_Stat == 0)
                {
                    Object_Car.Shake_Stat = 1;
                    Object_Car.Shake_Max = 0.5f;
                }
                break;
            default:
                Speed_road = 0.3f;
                if (Object_Car.Shake_Stat == 0)
                {
                    Object_Car.Shake_Stat = 1;
                    Object_Car.Shake_Max = 0.5f;
                }
                break;
        }
    }
    else
    {
        if (!Screen_Crack && Game_Data->Life < 0 && Speed >= 0.7f)
        {
            Screen_Crack = true;
            Car_Lose_Speed[0] = (40 - Car_Lose_Pos[0]) * 1.5f;
            if (Car_Lose_Speed[0] < 0) Car_Lose_Speed[0] *= -1;
            Car_Lose_Speed[1] = (70 - Car_Lose_Pos[1]) * 1.5f;
            if (Car_Lose_Speed[1] < 0) Car_Lose_Speed[1] *= -1;
            Car_Lose_Speed[2] = (360 - Car_Lose_Pos[2]) * 1.5f;
            if (Car_Lose_Speed[2] < 0) Car_Lose_Speed[2] *= -1;
            Car_Lose_Speed[3] = (250 - Car_Lose_Pos[3]) * 1.5f;
            if (Car_Lose_Speed[3] < 0) Car_Lose_Speed[3] *= -1;
            Car_Lose_Speed[4] = (57 - Object_Car.Position[0]) * 1.5f;
            if (Car_Lose_Speed[4] < 0) Car_Lose_Speed[4] *= -1;
            Car_Lose_Speed[5] = (90 - Object_Car.Turn_Angle) * 1.5f;
            if (Car_Lose_Speed[5] < 0) Car_Lose_Speed[5] *= -1;
        }
        Speed_road = 0.0f;
        if ([self Timer: &Car_Bounce_Time])
        {
            if (Game_Data->Life >= 0)
            {
                Object_Car.Position[1] = 0;
                Car_Bounce = false;
                Car_IDDQD = true;
                Car_IDDQD_Blink = false;
                Car_Blink = true;
                Car_IDDQD_Time = 3.0f;
                Car_IDDQD_Blink_Time = 1.5f;
            }
            else
            {
                Game_Data->Status_Next = Stat_Lose;
            }
        }
    }
    
    if (Screen_Crack)
    {
        [self Change_Smooth: &Car_Lose_Pos[0] : 40 : Car_Lose_Speed[0]];
        [self Change_Smooth: &Car_Lose_Pos[1] : 70 : Car_Lose_Speed[1]];
        [self Change_Smooth: &Car_Lose_Pos[2] : 360 : Car_Lose_Speed[2]];
        [self Change_Smooth: &Car_Lose_Pos[3] : 250 : Car_Lose_Speed[3]];
        [self Change_Smooth: &Object_Car.Position[0] : 57 : Car_Lose_Speed[4]];
        [self Change_Smooth: &Object_Car.Turn_Angle : 90 : Car_Lose_Speed[5]];
        
        if (Car_Lose_Pos[0] == 40)
            Game_Play_HUD->Broken = true;
        
        
        Object_Car.Matrix = GLKMatrix4MakeTranslation(Object_Car.Position[0], Car_Lose_Pos[0], Car_Lose_Pos[1]);
        Object_Car.Matrix = GLKMatrix4Rotate(Object_Car.Matrix, GLKMathDegreesToRadians(Object_Car.Turn_Angle), 0.0f, 1.0f, 0.0f);
        Object_Car.Matrix = GLKMatrix4Rotate(Object_Car.Matrix, GLKMathDegreesToRadians(Car_Lose_Pos[2]), 1.0f, 0.0f, 0.0f);
        Object_Car.Matrix = GLKMatrix4Rotate(Object_Car.Matrix, GLKMathDegreesToRadians(Car_Lose_Pos[3]), 0.0f, 0.0f, 1.0f);
    }
    else
    {
        Object_Car.Matrix = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(Object_Car.Position[1]), 0.0f, -1.0f, 0.0f);
        Object_Car.Matrix = GLKMatrix4Translate(Object_Car.Matrix, Object_Car.Position[0], Object_Car.Shake, 0);
        Object_Car.Matrix = GLKMatrix4Rotate(Object_Car.Matrix, GLKMathDegreesToRadians(Object_Car.Turn_Angle), 0.0f, 1.0f, 0.0f);
    }
    
    
    //Обновление положения машины и колёс
    Object_Car.Tire_Matrix[0] = Object_Car.Matrix;
    Object_Car.Tire_Matrix[1] = Object_Car.Matrix;
    Object_Car.Tire_Matrix[2] = Object_Car.Matrix;
    Object_Car.Tire_Matrix[3] = Object_Car.Matrix;
    Object_Car.Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Car.Matrix);
    Object_Car.Tire_Matrix[0] = GLKMatrix4Translate(Object_Car.Tire_Matrix[0], -2.42f, 1.1f, 4.9f);
    Object_Car.Tire_Matrix[0] = GLKMatrix4Rotate(Object_Car.Tire_Matrix[0], GLKMathDegreesToRadians(180), 0.0f, 0.0f, 1.0f);
    Object_Car.Tire_Matrix[0] = GLKMatrix4Rotate(Object_Car.Tire_Matrix[0], GLKMathDegreesToRadians(Object_Car.Tire_Angle), 1.0f, 0.0f, 0.0f);
    Object_Car.Tire_Matrix[0] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Car.Tire_Matrix[0]);
    Object_Car.Tire_Matrix[1] = GLKMatrix4Translate(Object_Car.Tire_Matrix[1], -2.42f, 1.1f, -5.06f);
    Object_Car.Tire_Matrix[1] = GLKMatrix4Rotate(Object_Car.Tire_Matrix[1], GLKMathDegreesToRadians(180), 0.0f, 0.0f, 1.0f);
    Object_Car.Tire_Matrix[1] = GLKMatrix4Rotate(Object_Car.Tire_Matrix[1], GLKMathDegreesToRadians(Object_Car.Tire_Angle), 1.0f, 0.0f, 0.0f);
    Object_Car.Tire_Matrix[1] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Car.Tire_Matrix[1]);
    Object_Car.Tire_Matrix[2] = GLKMatrix4Translate(Object_Car.Tire_Matrix[2], 2.42f, 1.1f, 4.9f);
    Object_Car.Tire_Matrix[2] = GLKMatrix4Rotate(Object_Car.Tire_Matrix[2], GLKMathDegreesToRadians(Object_Car.Tire_Angle), -1.0f, 0.0f, 0.0f);
    Object_Car.Tire_Matrix[2] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Car.Tire_Matrix[2]);
    Object_Car.Tire_Matrix[3] = GLKMatrix4Translate(Object_Car.Tire_Matrix[3], 2.42f, 1.1f, -5.06f);
    Object_Car.Tire_Matrix[3] = GLKMatrix4Rotate(Object_Car.Tire_Matrix[3], GLKMathDegreesToRadians(Object_Car.Tire_Angle), -1.0f, 0.0f, 0.0f);
    Object_Car.Tire_Matrix[3] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Car.Tire_Matrix[3]);
}

-(void)Update_Root
{
    if (Camera_1)
    {
        if (Speed > 0.5f)
        {
            tmpf = 1;
        }
        else
        {
            tmpf = 0;
        }
        [self Change_Smooth : &Object_Arrow_Angle[0] : (Speed - (tmpf * 0.5f)) * 80 * 2 : 150.0f];
        Object_Arrow_Angle[1] = Speed * 120;
        [self Change_Smooth : &Object_Arrow_Angle[2] : 90 - Game_Data->Life * 30 : 75.0f];
        [self Change_Smooth : &Object_Arrow_Angle[3] : 90 - (Game_Data->Level_Passed * 90) : 75.0f];
        
        Object_Root_Matrix = GLKMatrix4MakeTranslation(54.0f, 24.0f, 60.0f);
        Object_Root_Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Root_Matrix);
        Object_Wheel_Matrix = GLKMatrix4MakeTranslation(69.5f, 25.0f, 60.0f);
        Object_Wheel_Matrix = GLKMatrix4Rotate(Object_Wheel_Matrix, GLKMathDegreesToRadians(45), 1.0f, 0.0f, 0.0f);
        Object_Wheel_Matrix = GLKMatrix4Rotate(Object_Wheel_Matrix, GLKMathDegreesToRadians(Object_Wheel_Angle), 0.0f, 1.0f, 0.0f);
        Object_Wheel_Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Wheel_Matrix);
        Object_Speed_Matrix = GLKMatrix4MakeTranslation(45.5f, 25.5f, 59.0f);
        Object_Speed_Matrix = GLKMatrix4Rotate(Object_Speed_Matrix, GLKMathDegreesToRadians(Object_Speed_Angle), 1.0f, 0.0f, 0.0f);
        Object_Speed_Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Speed_Matrix);
        
        Object_Arrow_Matrix[0] = GLKMatrix4MakeTranslation(52.45f, 26.2f, 61.2f);
        Object_Arrow_Matrix[0] = GLKMatrix4Rotate(Object_Arrow_Matrix[0], GLKMathDegreesToRadians(45), -1.0f, 0.0f, 0.0f);
        Object_Arrow_Matrix[0] = GLKMatrix4Rotate(Object_Arrow_Matrix[0], GLKMathDegreesToRadians(Object_Arrow_Angle[0]), 0.0f, 0.0f, -1.0f);
        Object_Arrow_Matrix[0] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Arrow_Matrix[0]);
        
        Object_Arrow_Matrix[1] = GLKMatrix4MakeTranslation(56.0f, 26.5f, 61.0f);
        Object_Arrow_Matrix[1] = GLKMatrix4Rotate(Object_Arrow_Matrix[1], GLKMathDegreesToRadians(45), -1.0f, 0.0f, 0.0f);
        Object_Arrow_Matrix[1] = GLKMatrix4Rotate(Object_Arrow_Matrix[1], GLKMathDegreesToRadians(Object_Arrow_Angle[1]), 0.0f, 0.0f, -1.0f);
        Object_Arrow_Matrix[1] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Arrow_Matrix[1]);
        
        Object_Arrow_Matrix[2] = GLKMatrix4MakeTranslation(58.8f, 26.77f, 61.0f);
        Object_Arrow_Matrix[2] = GLKMatrix4Rotate(Object_Arrow_Matrix[2], GLKMathDegreesToRadians(45), -1.0f, 0.0f, 0.0f);
        Object_Arrow_Matrix[2] = GLKMatrix4Rotate(Object_Arrow_Matrix[2], GLKMathDegreesToRadians(180 - Object_Arrow_Angle[2]), 0.0f, 0.0f, -1.0f);
        Object_Arrow_Matrix[2] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Arrow_Matrix[2]);
        
        Object_Arrow_Matrix[3] = GLKMatrix4MakeTranslation(60.26f, 26.22f, 61.3f);
        Object_Arrow_Matrix[3] = GLKMatrix4Rotate(Object_Arrow_Matrix[3], GLKMathDegreesToRadians(45), -1.0f, 0.0f, 0.0f);
        Object_Arrow_Matrix[3] = GLKMatrix4Rotate(Object_Arrow_Matrix[3], GLKMathDegreesToRadians(180 - Object_Arrow_Angle[3]), 0.0f, 0.0f, -1.0f);
        Object_Arrow_Matrix[3] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Arrow_Matrix[3]);
    }
}

-(void)Update_Object
{
    tmpi = 0;
    for (i = 0; i < Game_Level->Object_Count; i++)
    {
        if (tmpi >= 16)
        {
            break;
        }
        if ((Game_Level->Objects[i].Position[1] <= (Game_Level->Angle_Full + 180)) && (Game_Level->Objects[i].Position[1] >= (Game_Level->Angle_Full - 90)) && Game_Level->Objects[i].Enable)
        {
            Object_Draw[tmpi].Obj = &Game_Level->Object_All[Game_Level->Objects[i].Num];
            Object_Draw[tmpi].Position[0] = Game_Level->Objects[i].Position[0];
            Object_Draw[tmpi].Position[1] = Game_Level->Angle_Full - Game_Level->Objects[i].Position[1];
            Object_Draw[tmpi].Rotation = Game_Level->Objects[i].Rotation;
            Object_Draw[tmpi].Enable = true;
            Object_Draw[tmpi].Matrix = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(Object_Draw[tmpi].Position[1]), 0.0f, -1.0f, 0.0f);
            Object_Draw[tmpi].Matrix = GLKMatrix4Translate(Object_Draw[tmpi].Matrix, Object_Draw[tmpi].Position[0], 0.0f, 0.0f);
            if (Object_Draw[tmpi].Rotation != 0)
                Object_Draw[tmpi].Matrix = GLKMatrix4Rotate(Object_Draw[tmpi].Matrix, GLKMathDegreesToRadians(Object_Draw[tmpi].Rotation), 0.0f, 1.0f, 0.0f);
            Object_Draw[tmpi].Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Draw[tmpi].Matrix);
            Object_Draw[tmpi].Object = &Game_Level->Objects[i];
 
            if (!Car_IDDQD && !Car_Bounce && !Game_Data->Bonus_IDDQD)// && 1!=1)
            {
                if ([self Car_Bounce : &Object_Draw[tmpi] : &Object_Car])
                {
                    switch (Object_Draw[tmpi].Object->Type) {
                        case 1:
                            Car_Bounce = true;
                            Game_Data->Life -= 1;
                            Coin_Bonus = 0;
                            break;
                        case 2:
                            Speed_obj = 0;
                            Obj_Time = 1.0f;
                            Coin_Bonus = 0;
                            Object_Draw[tmpi].Object->Enable = false;
                            break;
                        case 3:
                            Speed_obj = 0.5f;
                            Obj_Time = 2.0f;
                            Coin_Bonus = 0;
                            Object_Draw[tmpi].Object->Enable = false;
                            break;
                        default:
                            break;
                    }
                }
            }
            tmpi++;
        }
        else
        {
            Object_Draw[tmpi].Enable = false;
        }
    }
    //Запрет прорисовки несуществующих объектов
    for (i = tmpi; i < 16; i++)
    {
        Object_Draw[i].Enable = false;
    }
}

-(void)Update_Coin
{
    tmpi = 0;
    for (i = 0; i < Game_Level->Coin_Count; i++)
    {
        if (tmpi >= 16)
        {
            break;
        }
        if (!Game_Level->Coins[i].Touch)
        {
            if ((Game_Level->Coins[i].Position[1] <= (Game_Level->Angle_Full + 180)) && (Game_Level->Coins[i].Position[1] >= (Game_Level->Angle_Full - 45)))
            {
                Coin_Draw[tmpi].Obj = &Object_Coin;
                Coin_Draw[tmpi].Coin = &Game_Level->Coins[i];
                Coin_Draw[tmpi].Position[0] = Game_Level->Coins[i].Position[0];
                Coin_Draw[tmpi].Position[1] = Game_Level->Angle_Full - Game_Level->Coins[i].Position[1];
                Coin_Draw[tmpi].Position[2] = 2.0f;
                Coin_Draw[tmpi].Enable = true;
                Coin_Draw[tmpi].Matrix = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(Coin_Draw[tmpi].Position[1]), 0.0f, -1.0f, 0.0f);
                Coin_Draw[tmpi].Matrix = GLKMatrix4Translate(Coin_Draw[tmpi].Matrix, Coin_Draw[tmpi].Position[0], Coin_Draw[tmpi].Position[2], 0.0f);
                Coin_Draw[tmpi].Matrix = GLKMatrix4Rotate(Coin_Draw[tmpi].Matrix, GLKMathDegreesToRadians(Game_Level->Coins[i].Angle), 0.0f, 1.0f, 0.0f);
                Coin_Draw[tmpi].Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Coin_Draw[tmpi].Matrix);
                Game_Level->Coins[i].Angle += Game_Data->timeSinceLastUpdate * Game_Level->Coins[i].Turn_Speed;
                if ([self Coin_Bounce : &Coin_Draw[tmpi] : &Object_Car])
                {
                    if (Game_Data->Bonus_x4)
                    {
                        Game_Data->Score += 4;
                        Coin_Bonus += 4;
                    }
                    else if (Game_Data->Bonus_x2)
                    {
                        Game_Data->Score += 2;
                        Coin_Bonus += 2;
                    }
                    else
                    {
                        Game_Data->Score += 1;
                        Coin_Bonus += 1;
                    }
                    if (Coin_Bonus > 50)
                    {
                        if (Game_Data->Life < 3)
                            Game_Data->Life += 1;
                        Coin_Bonus = 0;
                    }
                    Coin_Draw[tmpi].Coin->Touch = true;
                    Coin_Draw[tmpi].Coin->Effect = 0.25f;
                }
                tmpi++;
            }
            else
            {
                Coin_Draw[tmpi].Enable = false;
            }
        }
        else if (![self Timer: &Game_Level->Coins[i].Effect])
        {
            Coin_Draw[tmpi].Obj = &Object_Coin;
            Coin_Draw[tmpi].Coin = &Game_Level->Coins[i];
            Coin_Draw[tmpi].Enable = true;
            
            Coin_Draw[tmpi].Position[0] = 25.0f - (25.0f - Game_Level->Coins[i].Position[0]) * (Coin_Draw[tmpi].Coin->Effect / 0.25f);
            Coin_Draw[tmpi].Position[1] = Game_Level->Angle_Full - Game_Level->Coins[i].Position[1];
            Coin_Draw[tmpi].Position[2] = 40.0f - (40.0f - 2.0f) * (Coin_Draw[tmpi].Coin->Effect / 0.25f);
            
            Coin_Draw[tmpi].Matrix = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(Coin_Draw[tmpi].Position[1]), 0.0f, -1.0f, 0.0f);
            Coin_Draw[tmpi].Matrix = GLKMatrix4Translate(Coin_Draw[tmpi].Matrix, Coin_Draw[tmpi].Position[0], Coin_Draw[tmpi].Position[2], 0.0f);
            Coin_Draw[tmpi].Matrix = GLKMatrix4Rotate(Coin_Draw[tmpi].Matrix, 1.57f, 0.0f, 1.0f, 0.0f);
            Coin_Draw[tmpi].Matrix = GLKMatrix4Scale(Coin_Draw[tmpi].Matrix, (0.5f - Coin_Draw[tmpi].Coin->Effect) * 4, (0.5f - Coin_Draw[tmpi].Coin->Effect) * 4, (0.5f - Coin_Draw[tmpi].Coin->Effect) * 4);
            Coin_Draw[tmpi].Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Coin_Draw[tmpi].Matrix);
            tmpi++;
        }
        else
        {
            Coin_Draw[tmpi].Enable = false;
        }
    }
    //Запрет прорисовки несуществующих монет
    for (i = tmpi; i < 16; i++)
    {
        Coin_Draw[i].Enable = false;
    }
}

-(void)Update_Bonus
{
    if (Game_Data->Bonus_Fast)
    {
        if ([self Timer : &Game_Data->Bonus_Fast_Time])
        {
            Game_Data->Bonus_Fast = false;
        }
    }
    
    if (Game_Data->Bonus_IDDQD)
    {
        if ([self Timer : &Game_Data->Bonus_IDDQD_Time])
        {
            Game_Data->Bonus_IDDQD = false;
        }
    }
    
    if (Game_Data->Bonus_x2)
    {
        if ([self Timer : &Game_Data->Bonus_x2_Time])
        {
            Game_Data->Bonus_x2 = false;
        }
    }
    
    if (Game_Data->Bonus_x4)
    {
        if ([self Timer : &Game_Data->Bonus_x4_Time])
        {
            Game_Data->Bonus_x4 = false;
        }
    }
    
    
    tmpi = 0;
    for (i = 0; i < Game_Level->Bonus_Count; i++)
    {
        if (tmpi >= 8)
        {
            break;
        }
        if (!Game_Level->Bonus[i].Touch)
        {
            if ((Game_Level->Bonus[i].Position[1] <= (Game_Level->Angle_Full + 180)) && (Game_Level->Bonus[i].Position[1] >= (Game_Level->Angle_Full - 45)))
            {
                Bonus_Draw[tmpi].Obj = &Object_Bonus[Game_Level->Bonus[i].Type];
                Bonus_Draw[tmpi].Bonus = &Game_Level->Bonus[i];
                Bonus_Draw[tmpi].Position[0] = Game_Level->Bonus[i].Position[0];
                Bonus_Draw[tmpi].Position[1] = Game_Level->Angle_Full - Game_Level->Bonus[i].Position[1];
                Bonus_Draw[tmpi].Enable = true;
                Bonus_Draw[tmpi].Matrix = GLKMatrix4MakeRotation(GLKMathDegreesToRadians(Bonus_Draw[tmpi].Position[1]), 0.0f, -1.0f, 0.0f);
                Bonus_Draw[tmpi].Matrix = GLKMatrix4Translate(Bonus_Draw[tmpi].Matrix, Bonus_Draw[tmpi].Position[0], 2.0f, 0.0f);
                Bonus_Draw[tmpi].Matrix = GLKMatrix4Rotate(Bonus_Draw[tmpi].Matrix, GLKMathDegreesToRadians(Game_Level->Bonus[i].Angle), 0.0f, 1.0f, 0.0f);
                Bonus_Draw[tmpi].Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Bonus_Draw[tmpi].Matrix);
                Game_Level->Bonus[i].Angle += Game_Data->timeSinceLastUpdate * Game_Level->Bonus[i].Turn_Speed;
                if ([self Bonus_Bounce: &Bonus_Draw[tmpi] : &Object_Car])
                {
                    switch (Bonus_Draw[tmpi].Bonus->Type)
                    {
                        case 0:
                            Game_Data->Bonus_IDDQD = true;
                            Game_Data->Bonus_IDDQD_Time = BONUS_IDDQD_TIME;
                            Game_Play_HUD->Bonus_Screen_Time[0] = BONUS_SCREEN_TIME;
                            break;
                        case 1:
                            if (Game_Data->Bonus_x2)
                            {
                                Game_Data->Bonus_x4 = true;
                                Game_Data->Bonus_x4_Time = BONUS_X4_TIME;
                                Game_Data->Bonus_x2 = false;
                                Game_Data->Bonus_x2_Time = 0.0f;
                            }
                            else
                            {
                                Game_Data->Bonus_x2 = true;
                                Game_Data->Bonus_x2_Time = BONUS_X2_TIME;
                            }
                            Game_Play_HUD->Bonus_Screen_Time[1] = BONUS_SCREEN_TIME;
                            break;
                        case 2:
                            Game_Data->Bonus_Fast = true;
                            Game_Data->Bonus_Fast_Time = BONUS_FAST_TIME;
                            Game_Play_HUD->Bonus_Screen_Time[2] = BONUS_SCREEN_TIME;
                            break;
                        case 3:
                            if (Game_Data->Life < 3)
                                Game_Data->Life += 1;
                            Game_Play_HUD->Bonus_Screen_Time[3] = BONUS_SCREEN_TIME;
                            break;
                        case 4:
                            if (Game_Data->Life > 0)
                                Game_Data->Life -= 1;
                            Game_Play_HUD->Bonus_Screen_Time[4] = BONUS_SCREEN_TIME;
                            break;
                    }
                    Bonus_Draw[tmpi].Bonus->Touch = true;
                }
                tmpi++;
            }
            else
            {
                Bonus_Draw[tmpi].Enable = false;
            }
        }
        else
        {
            Bonus_Draw[tmpi].Enable = false;
        }
    }
    //Запрет прорисовки несуществующих монет
    for (i = tmpi; i < 8; i++)
    {
        Bonus_Draw[i].Enable = false;
    }
}

-(void)Draw
{
    if (Game_Data->light)
    {
        Game_Data->effect.light0.enabled = GL_TRUE;
        Game_Data->effect.light1.enabled = GL_TRUE;
    }
    //Прорисовка комнаты
    [self Draw_Room];
    
    //Прорисовка панели
    [self Draw_Root_Mini];
    
    //Прорисовка дороги
    Game_Data->effect.transform.modelviewMatrix = Sector_Draw[0].Matrix;
    [self Draw_Sector : &Sector_Draw[0]];
    Game_Data->effect.transform.modelviewMatrix = Sector_Draw[1].Matrix;
    [self Draw_Sector : &Sector_Draw[1]];
    Game_Data->effect.transform.modelviewMatrix = Sector_Draw[2].Matrix;
    [self Draw_Sector : &Sector_Draw[2]];
    Game_Data->effect.transform.modelviewMatrix = Sector_Draw[3].Matrix;
    [self Draw_Sector : &Sector_Draw[3]];
    Game_Data->effect.transform.modelviewMatrix = Sector_Draw[4].Matrix;
    [self Draw_Sector : &Sector_Draw[4]];
    Game_Data->effect.transform.modelviewMatrix = Sector_Draw[5].Matrix;
    [self Draw_Sector : &Sector_Draw[5]];
    
    Game_Data->effect.texture2d0.name = Object_Circle.Texture;
    Game_Data->effect.transform.modelviewMatrix = Sector_6_Matrix;
    [Game_Data->effect prepareToDraw];
    glBindVertexArrayOES(Object_Circle.Array);
    glDrawArrays(GL_TRIANGLES, 0, Object_Circle.Vertex_Count);
    Game_Data->effect.transform.modelviewMatrix = Sector_7_Matrix;
    [Game_Data->effect prepareToDraw];
    glBindVertexArrayOES(Object_Circle.Array);
    glDrawArrays(GL_TRIANGLES, 0, Object_Circle.Vertex_Count);
    
    if (!Camera_1)
    {
        Sector_Draw[5].Matrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, 0.0f);
        Sector_Draw[5].Matrix = GLKMatrix4Rotate(Sector_Draw[5].Matrix, GLKMathDegreesToRadians(0 - (6 * 45) + 45), 0.0f, -1.0f, 0.0f);
        Sector_Draw[5].Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_Draw[5].Matrix);
        Game_Data->effect.transform.modelviewMatrix = Sector_Draw[5].Matrix;
        [self Draw_Sector : &Sector_Draw[0]];
        
        Sector_Draw[5].Matrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, 0.0f);
        Sector_Draw[5].Matrix = GLKMatrix4Rotate(Sector_Draw[5].Matrix, GLKMathDegreesToRadians(0 - (7 * 45) + 45), 0.0f, -1.0f, 0.0f);
        Sector_Draw[5].Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_Draw[5].Matrix);
        Game_Data->effect.transform.modelviewMatrix = Sector_Draw[5].Matrix;
        [self Draw_Sector : &Sector_Draw[0]];
    }
    
    //Прорисовка машины
    [self Draw_Car];
    
    //Прорисовка объектов на дороге
    for (i = 0; i < 16; i++)
    {
        if (Object_Draw[i].Enable)
        {
            Game_Data->effect.transform.modelviewMatrix = Object_Draw[i].Matrix;
            Game_Data->effect.texture2d0.name = Object_Draw[i].Obj->Texture;
            [Game_Data->effect prepareToDraw];
            glBindVertexArrayOES(Object_Draw[i].Obj->Array);
            glDrawArrays(GL_TRIANGLES, 0, Object_Draw[i].Obj->Vertex_Count);
        }
    }
    
    //Прорисовка монет на дороге
    for (i = 0; i < 16; i++)
    {
        if (Coin_Draw[i].Enable)
        {
            Game_Data->effect.transform.modelviewMatrix = Coin_Draw[i].Matrix;
            Game_Data->effect.texture2d0.name = Coin_Draw[i].Obj->Texture;
            if (Coin_Draw[i].Coin->Touch)
                Game_Data->effect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, (Coin_Draw[i].Coin->Effect * 4));
            [Game_Data->effect prepareToDraw];
            glBindVertexArrayOES(Coin_Draw[i].Obj->Array);
            glDrawArrays(GL_TRIANGLES, 0, Coin_Draw[i].Obj->Vertex_Count);
            if (Coin_Draw[i].Coin->Touch)
                Game_Data->effect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
        }
    }
    
    //Прорисовка бонусов на дороге
    Game_Data->effect.texture2d0.name = Texture_Bonus;
    for (i = 0; i < 8; i++)
    {
        if (Bonus_Draw[i].Enable)
        {
            Game_Data->effect.transform.modelviewMatrix = Bonus_Draw[i].Matrix;
            [Game_Data->effect prepareToDraw];
            glBindVertexArrayOES(Bonus_Draw[i].Obj->Array);
            glDrawArrays(GL_TRIANGLES, 0, Bonus_Draw[i].Obj->Vertex_Count);
        }
    }

    if (Game_Data->light)
    {
        Game_Data->effect.light0.enabled = GL_FALSE;
        Game_Data->effect.light1.enabled = GL_FALSE;
    }
    //Прорисовка интерфейса
    [Game_Play_HUD Draw];
    
    if (Game_Data->Status_Curent == Stat_Pause || Game_Data->Status_Curent == Stat_Win || Game_Data->Status_Curent == Stat_Lose)
        [Menu_Game Draw];
}

-(void)Draw_Room
{
    Game_Data->effect.transform.modelviewMatrix = Game_Data->CameraMatrix;
    
    Game_Data->effect.texture2d0.name = Object_Sky.Texture;
    [Game_Data->effect prepareToDraw];
    glBindVertexArrayOES(Object_Sky.Array);
    glDrawArrays(GL_TRIANGLES, 0, Object_Sky.Vertex_Count);
    
    Game_Data->effect.texture2d0.name = Texture_Room;
    [Game_Data->effect prepareToDraw];
    glBindVertexArrayOES(Object_Room.Array);
    glDrawArrays(GL_TRIANGLES, 0, Object_Room.Vertex_Count);
    
    if (!Camera_1)
    {
        Game_Data->effect.texture2d0.name = Texture_Room;
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Room2.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Room2.Vertex_Count);
        
        Game_Data->effect.texture2d0.name = Object_Table.Texture;
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Table.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Table.Vertex_Count);
        
        Game_Data->effect.texture2d0.name = Texture_Root;
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Root.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Root.Vertex_Count);
    }
}

-(void)Draw_Root_Mini
{
    if (Camera_1)
    {
        Game_Data->effect.texture2d0.name = Texture_Root;
        
        Game_Data->effect.transform.modelviewMatrix = Object_Root_Matrix;
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Root_m.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Root_m.Vertex_Count);
        
        Game_Data->effect.transform.modelviewMatrix = Object_Wheel_Matrix;
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Wheel_m.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Wheel_m.Vertex_Count);
        
        Game_Data->effect.transform.modelviewMatrix = Object_Speed_Matrix;
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Speed_m.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Speed_m.Vertex_Count);
        
        Game_Data->effect.transform.modelviewMatrix = Object_Arrow_Matrix[0];
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Arrow_2.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Arrow_2.Vertex_Count);
        
        Game_Data->effect.transform.modelviewMatrix = Object_Arrow_Matrix[1];
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Arrow_1.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Arrow_1.Vertex_Count);
        
        Game_Data->effect.transform.modelviewMatrix = Object_Arrow_Matrix[2];
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Arrow_3.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Arrow_3.Vertex_Count);
        
        Game_Data->effect.transform.modelviewMatrix = Object_Arrow_Matrix[3];
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Arrow_3.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Arrow_3.Vertex_Count);
    }
}

-(void)Draw_Car
{
    if ((Car_IDDQD && Car_Blink) || Game_Data->Bonus_IDDQD)
    {
        if (Game_Data->light)
        {
            Game_Data->effect.light0.enabled = GL_FALSE;
            Game_Data->effect.light1.enabled = GL_FALSE;
        }
        Game_Data->effect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 0.3f);
    }
    
    Game_Data->effect.texture2d0.name = Object_Car.Obj.Texture;
    Game_Data->effect.transform.modelviewMatrix = Object_Car.Matrix;
    [Game_Data->effect prepareToDraw];
    
    glBindVertexArrayOES(Object_Car.Obj.Array);
    glDrawArrays(GL_TRIANGLES, 0, Object_Car.Obj.Vertex_Count);
    //Прорисовка шин
    glBindVertexArrayOES(Object_Car.Tire.Array);
    Game_Data->effect.transform.modelviewMatrix = Object_Car.Tire_Matrix[0];
    [Game_Data->effect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, Object_Car.Tire.Vertex_Count);
    Game_Data->effect.transform.modelviewMatrix = Object_Car.Tire_Matrix[1];
    [Game_Data->effect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, Object_Car.Tire.Vertex_Count);
    Game_Data->effect.transform.modelviewMatrix = Object_Car.Tire_Matrix[2];
    [Game_Data->effect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, Object_Car.Tire.Vertex_Count);
    Game_Data->effect.transform.modelviewMatrix = Object_Car.Tire_Matrix[3];
    [Game_Data->effect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, Object_Car.Tire.Vertex_Count);
    
    if (Car_IDDQD || Game_Data->Bonus_IDDQD)
    {
        Game_Data->effect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
        if (Game_Data->light)
        {
            Game_Data->effect.light0.enabled = GL_TRUE;
            Game_Data->effect.light1.enabled = GL_TRUE;
        }
    }
}

-(void)Draw_Sector : (struct SectorDraw*)obj
{
    Game_Data->effect.texture2d0.name = Object_Circle.Texture;
    [Game_Data->effect prepareToDraw];
    glBindVertexArrayOES(Object_Circle.Array);
    glDrawArrays(GL_TRIANGLES, 0, Object_Circle.Vertex_Count);
    Game_Data->effect.texture2d0.name = Wall_Texture_1[obj->Texture_Wall[0]];
    [Game_Data->effect prepareToDraw];
    glBindVertexArrayOES(Object_Wall1.Array);
    glDrawArrays(GL_TRIANGLES, 0, Object_Wall1.Vertex_Count);
    Game_Data->effect.texture2d0.name = Wall_Texture_2[obj->Texture_Wall[1]];
    [Game_Data->effect prepareToDraw];
    glBindVertexArrayOES(Object_Wall2.Array);
    glDrawArrays(GL_TRIANGLES, 0, Object_Wall2.Vertex_Count);
    for (i = 0; i < 6; i++)
    {
        if (obj->Enable[i])
        {
            Game_Data->effect.texture2d0.name = obj->Texture[i];
            [Game_Data->effect prepareToDraw];
            glBindVertexArrayOES(obj->Surface[i]->Array);
            glDrawArrays(GL_TRIANGLES, 0, 30);
        }
    }
}

-(void)Touch_Start: (NSSet *)touches
{
    if (Game_Data->Status_Curent == Stat_Pause || Game_Data->Status_Curent == Stat_Win || Game_Data->Status_Curent == Stat_Lose)
    {
        [Menu_Game Touch_Start: touches];
    }
    else if (Camera_2)
    {
        for (touch in touches)
        {
            location = [touch locationInView:Game_Data->view];
            location.x *= 2;
            location.y *= 2;
            if (location.x <= 340 && location.y >= 320)
            {
                Touch_Gas.touch_id = (int)touch;
                Touch_Gas.tmp = location.y;
            }
            else if (location.x >= 560 && location.y >= 320)
            {
                Touch_Wheel.touch_id = (int)touch;
                Touch_Wheel.tmp = acosf(((Wheel_Origin[0] - location.x) / [self Vector_Length: (Wheel_Origin[0] - location.x) : (Wheel_Origin[1] - location.y)]));
                if ((Wheel_Origin[1] - location.y) < 0)
                    Touch_Wheel.tmp *= -1;
                Wheel_Hold = true;            
            }
        }
        
        if (!Game_Start)
        {
            Game_Start = true;
            Speed_gas = 0.0f;
        }
    }
}

-(void)Touch_End: (NSSet *)touches
{
    if (Game_Data->Status_Curent == Stat_Pause || Game_Data->Status_Curent == Stat_Win || Game_Data->Status_Curent == Stat_Lose)
    {
        [Menu_Game Touch_End: touches];
    }
    else if (Camera_2)
    {
        for (touch in touches)
        {
            location = [touch locationInView:Game_Data->view];
            location.x *= 2;
            location.y *= 2;
            if ((int)touch == Touch_Gas.touch_id)
            {
                Touch_Gas.touch_id = 0;
            }
            else if ((int)touch == Touch_Wheel.touch_id)
            {
                Touch_Wheel.touch_id = 0;
                Wheel_Hold = false;
            }
        }
        
        if ([self Location_Touched: location.x : location.y : 0 : 0 : 200 : 100])
        {
            Game_Data->Status_Next = Stat_Pause;
        }
    }
}

-(void)Touch_Move: (NSSet *)touches
{
    if (Game_Data->Status_Curent == Stat_Pause || Game_Data->Status_Curent == Stat_Win || Game_Data->Status_Curent == Stat_Lose)
    {
        [Menu_Game Touch_Move: touches];
    }
    else if (Camera_2)
    {
        for (touch in touches)
        {
            location = [touch locationInView:Game_Data->view];
            location.x *= 2;
            location.y *= 2;
            
            if (!Car_Bounce)
            {
                if ((int)touch == Touch_Gas.touch_id)
                {
                    Speed_gas -= (location.y - Touch_Gas.tmp) * 0.005f;
                    if (Speed_gas > 1)
                        Speed_gas = 1;
                    else if (Speed_gas < 0)
                        Speed_gas = 0;
                    
//                    Game_Level->Angle += (location.y - Touch_Gas.tmp) * 0.05;
//                    Game_Level->Angle_Full += (location.y - Touch_Gas.tmp) * 0.05;
                    
                    Touch_Gas.tmp = location.y;
                }
                else if ((int)touch == Touch_Wheel.touch_id)
                {
                    tmpf = acosf(((Wheel_Origin[0] - location.x) / [self Vector_Length: (Wheel_Origin[0] - location.x) : (Wheel_Origin[1] - location.y)]));
                    if (Touch_Wheel.tmp < tmpf)
                    {
                        Turn_Right = true;
                        Turn_Left = false;
                    }
                    else
                    {
                        Turn_Left = true;
                        Turn_Right = false;
                    }
                    
                    if ((Wheel_Origin[1] - location.y) < 0)
                        tmpf *= -1;
                    
                    Object_Wheel_Angle += GLKMathRadiansToDegrees(Touch_Wheel.tmp - tmpf);
                    if (Object_Wheel_Angle > 60)
                        Object_Wheel_Angle = 60;
                    else if (Object_Wheel_Angle < -60)
                        Object_Wheel_Angle = -60;
                    
//                    Object_Car.Position[0] += (Touch_Wheel.tmp - tmpf) * 2.0f;
                    
                    Touch_Wheel.tmp = tmpf;
                }
            }
        }
        
        Object_Speed_Angle = 45 * (1 - Speed_gas);
        
        //    Game_Level->Angle += (location.y - tmp_y) * 0.1f;
        //    Game_Level->Angle_Full += (location.y - tmp_y) * 0.1f;
    }
}

-(void)dealloc
{
    //Инициализация текстур дороги, 7 изображений
    glDeleteTextures(1, &Road_Texture[0]);
    glDeleteTextures(1, &Road_Texture[1]);
    glDeleteTextures(1, &Road_Texture[2]);
    glDeleteTextures(1, &Road_Texture[3]);
    glDeleteTextures(1, &Road_Texture[4]);
    glDeleteTextures(1, &Road_Texture[5]);
    glDeleteTextures(1, &Road_Texture[6]);
    
    //Текстуры стен
    glDeleteTextures(1, &Wall_Texture_1[0]);
    glDeleteTextures(1, &Wall_Texture_1[1]);
    glDeleteTextures(1, &Wall_Texture_1[2]);
    glDeleteTextures(1, &Wall_Texture_1[3]);
    glDeleteTextures(1, &Wall_Texture_1[4]);
    glDeleteTextures(1, &Wall_Texture_1[5]);
    glDeleteTextures(1, &Wall_Texture_2[0]);
    glDeleteTextures(1, &Wall_Texture_2[1]);
    glDeleteTextures(1, &Wall_Texture_2[2]);
    glDeleteTextures(1, &Wall_Texture_2[3]);
    glDeleteTextures(1, &Wall_Texture_2[4]);
    glDeleteTextures(1, &Wall_Texture_2[5]);
    glDeleteTextures(1, &Wall_Texture_2[6]);
    glDeleteTextures(1, &Wall_Texture_2[7]);
    glDeleteTextures(1, &Wall_Texture_2[8]);
    glDeleteTextures(1, &Wall_Texture_2[9]);
    glDeleteTextures(1, &Wall_Texture_2[10]);
    glDeleteTextures(1, &Wall_Texture_2[11]);
    glDeleteTextures(1, &Wall_Texture_2[12]);
    glDeleteTextures(1, &Wall_Texture_2[13]);
    glDeleteTextures(1, &Wall_Texture_2[14]);
    glDeleteTextures(1, &Wall_Texture_2[15]);
    
    //Загрузка машины
    glDeleteTextures(1, &Object_Car.Obj.Texture);
    
    //Постоянные объекты
    glDeleteTextures(1, &Object_Circle.Texture);
    glDeleteTextures(1, &Object_Wall1.Texture);
    glDeleteTextures(1, &Object_Wall2.Texture);
    glDeleteTextures(1, &Object_Coin.Texture);
    glDeleteTextures(1, &Object_Table.Texture);
    glDeleteTextures(1, &Object_Sky.Texture);
    
    //Текстуры постоянных объектов
    glDeleteTextures(1, &Texture_Room);
    glDeleteTextures(1, &Texture_Root);
    glDeleteTextures(1, &Texture_Bonus);
    
    //Данные уровня
    [Game_Level dealloc];
    Game_Level = nil;
    
    //Данные интерфейса игры
    [Game_Play_HUD dealloc];
    Game_Play_HUD = nil;
    
    //Внутриигровое меню
    [Menu_Game dealloc];
    Menu_Game = nil;
    
    [super dealloc];
}
@end
