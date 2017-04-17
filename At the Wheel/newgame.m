//
//  newgame.m
//  At the Wheel
//
//  Created by Администратор on 7/2/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#import "roads_2.h"
#import "newgame.h"

@implementation NewGame
-(id)init : (struct GameData*)data
{
    self = [super init : data];
    if (self)
    {
        //Дорога
        //Инициализация данных дороги, 36 разных поверхностей
        Surface[0].Vertex = RoadLine_1_2;
        [self RoadInit : &Surface[0] : 240];
        Surface[1].Vertex = RoadLine_2_2;
        [self RoadInit : &Surface[1] : 240];
        Surface[2].Vertex = RoadLine_3_2;
        [self RoadInit : &Surface[2] : 240];
        Surface[3].Vertex = RoadLine_4_2;
        [self RoadInit : &Surface[3] : 240];
        Surface[4].Vertex = RoadLine_5_2;
        [self RoadInit : &Surface[4] : 240];
        Surface[5].Vertex = RoadLine_6_2;
        [self RoadInit : &Surface[5] : 240];
        
        //Инициализация текстур дороги, 7 изображений
        Road_Texture[0] = [self Load_Texture:@"road_1"];
        Road_Texture[1] = [self Load_Texture:@"road_5"];
        Road_Texture[2] = [self Load_Texture:@"road_8"];
        
        //Текстуры стен
        Wall_Texture_1[0] = [self Load_Texture:@"wall1_01"];
        Wall_Texture_1[1] = [self Load_Texture:@"wall1_02"];
        Wall_Texture_1[2] = [self Load_Texture:@"wall1_03"];
        Wall_Texture_1[3] = [self Load_Texture:@"wall1_04"];
        Wall_Texture_1[4] = [self Load_Texture:@"wall1_05"];
        Wall_Texture_1[5] = [self Load_Texture:@"wall1_06"];
        Wall_Texture_1[6] = Wall_Texture_1[2];
        Wall_Texture_1[7] = Wall_Texture_1[4];
        Wall_Texture_2[0] = [self Load_Texture:@"wall2_01"];
        Wall_Texture_2[1] = [self Load_Texture:@"wall2_02"];
        Wall_Texture_2[2] = [self Load_Texture:@"wall2_03"];
        Wall_Texture_2[3] = [self Load_Texture:@"wall2_04"];
        Wall_Texture_2[4] = [self Load_Texture:@"wall2_05"];
        Wall_Texture_2[5] = [self Load_Texture:@"wall2_06"];
        Wall_Texture_2[6] = [self Load_Texture:@"wall2_07"];
        Wall_Texture_2[7] = [self Load_Texture:@"wall2_08"];
        
        //Загрузка машины
        [self Load_Object: &Object_Car : @"object_car_6.txt"];
        
        //Постоянные объекты
        [self CreateObject2D: &Loading : -88 : 0 : 1136 : 640 : [self Load_Texture:@"menu_loading"]];
        [self Load_Object: &Object_Circle : @"circle.txt"];
        [self Load_Object: &Object_Wall1 : @"wall1.txt"];
        [self Load_Object: &Object_Wall2 : @"wall2.txt"];
        [self Load_Object: &Object_Root : @"root.txt"];
        [self Load_Object: &Object_Room : @"room.txt"];
        [self Load_Object: &Object_Room2 : @"room2.txt"];
        [self Load_Object: &Object_Table : @"table.txt"];
        [self Load_Object: &Object_Sky : @"sky.txt"];
        [self Load_Object: &Object_Present_1 : @"present_1.txt"];
        [self Load_Object: &Object_Present_2 : @"present_2.txt"];
        [self Load_Object: &Object_Present_3 : @"present_3.txt"];
        [self Load_Object: &Object_Present_4 : @"present_4.txt"];
        
        //Текстуры постоянных объектов
        Texture_Room = [self Load_Texture:@"room"];
        Texture_Root = [self Load_Texture:@"root"];
        Texture_Present = [self Load_Texture:@"present"];
        
        switch (Game_Data->Set_Color) {
            case 1:
                Texture_Car = [self Load_Texture:@"car_1"];
                break;
            case 2:
                Texture_Car = [self Load_Texture:@"car_2"];
                break;
            case 3:
                Texture_Car = [self Load_Texture:@"car_3"];
                break;
            default:
                Texture_Car = [self Load_Texture:@"car_0"];
                break;
        }
            
        
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
    //Матрицы постоянных объектов
    Object_Root_Matrix = Game_Data->CameraMatrix;
    Object_Car_Matrix = GLKMatrix4MakeTranslation(35, 1, 0);
    Object_Car_Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Car_Matrix);
    
    present_1 = true;
    present_2 = true;
    present_3 = true;
    present_4 = false;
    root_road = false;
    fade = 0;
    
    Sector_Draw.Type[0] = 1;
    Sector_Draw.Type[1] = 1;
    Sector_Draw.Type[2] = 1;
    Sector_Draw.Type[3] = 1;
    Sector_Draw.Type[4] = 1;
    Sector_Draw.Type[5] = 1;
    Sector_Draw.Surf[0] = 1;
    Sector_Draw.Surf[1] = 2;
    Sector_Draw.Surf[2] = 3;
    Sector_Draw.Surf[3] = 4;
    Sector_Draw.Surf[4] = 5;
    Sector_Draw.Surf[5] = 6;
    Sector_Draw.Enable[0] = true;
    Sector_Draw.Enable[1] = true;
    Sector_Draw.Enable[2] = true;
    Sector_Draw.Enable[3] = true;
    Sector_Draw.Enable[4] = true;
    Sector_Draw.Enable[5] = true;
    Sector_Draw.Surface[0] = &Surface[0];
    Sector_Draw.Surface[1] = &Surface[1];
    Sector_Draw.Surface[2] = &Surface[2];
    Sector_Draw.Surface[3] = &Surface[3];
    Sector_Draw.Surface[4] = &Surface[4];
    Sector_Draw.Surface[5] = &Surface[5];
    Sector_Draw.Texture[0] = Road_Texture[0];
    Sector_Draw.Texture[1] = Road_Texture[2];
    Sector_Draw.Texture[2] = Road_Texture[1];
    Sector_Draw.Texture[3] = Road_Texture[0];
    Sector_Draw.Texture[4] = Road_Texture[2];
    Sector_Draw.Texture[5] = Road_Texture[1];
    Sector_Draw.Texture_Wall[0] = 0;
    Sector_Draw.Texture_Wall[1] = 0;
    
    //Переменные для камеры
    Cam_Pos[0].pos_x = 0;
    Cam_Pos[0].pos_y = -40;
    Cam_Pos[0].pos_z = -700;
    Cam_Pos[0].rot_x = 15;
    Cam_Pos[0].rot_y = 0;
    Cam_Pos[0].rot_z = 0;
    
    Cam_Pos[1].pos_x = 0;
    Cam_Pos[1].pos_y = -40;
    Cam_Pos[1].pos_z = -700;
    Cam_Pos[1].rot_x = 15;
    Cam_Pos[1].rot_y = 40;
    Cam_Pos[1].rot_z = 0;
    
    Cam_Pos[2].pos_x = 0;
    Cam_Pos[2].pos_y = 0;
    Cam_Pos[2].pos_z = -500;
    Cam_Pos[2].rot_x = 60;
    Cam_Pos[2].rot_y = 0;
    Cam_Pos[2].rot_z = 0;
    
    Cam_Pos[3].pos_x = 0;
    Cam_Pos[3].pos_y = -40;
    Cam_Pos[3].pos_z = -500;
    Cam_Pos[3].rot_x = 15;
    Cam_Pos[3].rot_y = 0;
    Cam_Pos[3].rot_z = 0;
  
    //Настройки камеры 3D
    Game_Data->CameraMatrix = GLKMatrix4MakeTranslation(0, 0, Cam_Pos[0].pos_z);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(Cam_Pos[0].rot_z), 0.0f, 0.0f, 1.0f);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(Cam_Pos[0].rot_x), 1.0f, 0.0f, 0.0f);
    Game_Data->CameraMatrix = GLKMatrix4Translate(Game_Data->CameraMatrix, Cam_Pos[0].pos_x, Cam_Pos[0].pos_y, 0);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(Cam_Pos[0].rot_y), 0.0f, 1.0f, 0.0f);
    
    //Настройки камеры 2D
    Game_Data->HUDMatrix = GLKMatrix4MakeTranslation(0, 0, 0);
    //        Game_Data->HUDMatrix = GLKMatrix4Rotate(Game_Data->HUDMatrix, GLKMathDegreesToRadians(90), 0.0f, 0.0f, 1.0f);
    Game_Data->HUDMatrix = GLKMatrix4Scale(Game_Data->HUDMatrix, 0.5f, 0.5f, 0.0f);
    
    Timer_tmp = 0;
    Status = 0;
    
//    Game_Data->Status_Next_Load = false;
}

-(void)Update
{
    switch (Status) {
        case 0:
            Cam_Position.pos_x = Cam_Pos[0].pos_x;
            Cam_Position.pos_y = Cam_Pos[0].pos_y;
            Cam_Position.pos_z = Cam_Pos[0].pos_z;
            Cam_Position.rot_x = Cam_Pos[0].rot_x;
            Cam_Position.rot_y = Cam_Pos[0].rot_y;
            Cam_Position.rot_z = Cam_Pos[0].rot_z;
            Timer_tmp = 1.0f;
            Status = 1;
            break;
        case 1:
            if ([self Timer: &Timer_tmp])
            {
                Status = 2;
            }
            break;
        case 2:
            [self Change_Smooth : &fade : 1.0f : 1.0f];
            if (fade == 1.0)
            {
                Timer_tmp = 1.0f;
                Status = 3;
            }
            break;
        case 3:
            if ([self Timer: &Timer_tmp])
            {
                Cam_Speed.pos_x = (Cam_Pos[1].pos_x - Cam_Pos[0].pos_x) * 0.75;
                if (Cam_Speed.pos_x < 0) Cam_Speed.pos_x *= -1;
                Cam_Speed.pos_y = (Cam_Pos[1].pos_y - Cam_Pos[0].pos_y) * 0.75;
                if (Cam_Speed.pos_y < 0) Cam_Speed.pos_y *= -1;
                Cam_Speed.pos_z = (Cam_Pos[1].pos_z - Cam_Pos[0].pos_z) * 0.75;
                if (Cam_Speed.pos_z < 0) Cam_Speed.pos_z *= -1;
                Cam_Speed.rot_x = (Cam_Pos[1].rot_x - Cam_Pos[0].rot_x) * 0.75;
                if (Cam_Speed.rot_x < 0) Cam_Speed.rot_x *= -1;
                Cam_Speed.rot_y = (Cam_Pos[1].rot_y - Cam_Pos[0].rot_y) * 0.75;
                if (Cam_Speed.rot_y < 0) Cam_Speed.rot_y *= -1;
                Cam_Speed.rot_z = (Cam_Pos[1].rot_z - Cam_Pos[0].rot_z) * 0.75;
                if (Cam_Speed.rot_z < 0) Cam_Speed.rot_z *= -1;
                Status = 4;
            }
            break;
        case 4:
            [self Change_Smooth : &Cam_Position.pos_x : Cam_Pos[1].pos_x : Cam_Speed.pos_x];
            [self Change_Smooth : &Cam_Position.pos_y : Cam_Pos[1].pos_y : Cam_Speed.pos_y];
            [self Change_Smooth : &Cam_Position.pos_z : Cam_Pos[1].pos_z : Cam_Speed.pos_z];
            [self Change_Smooth : &Cam_Position.rot_x : Cam_Pos[1].rot_x : Cam_Speed.rot_x];
            [self Change_Smooth : &Cam_Position.rot_y : Cam_Pos[1].rot_y : Cam_Speed.rot_y];
            [self Change_Smooth : &Cam_Position.rot_z : Cam_Pos[1].rot_z : Cam_Speed.rot_z];
            if (Cam_Position.pos_x == Cam_Pos[1].pos_x && Cam_Position.pos_y == Cam_Pos[1].pos_y && Cam_Position.pos_z == Cam_Pos[1].pos_z)
            {
                if (Cam_Position.rot_x == Cam_Pos[1].rot_x && Cam_Position.rot_y == Cam_Pos[1].rot_y && Cam_Position.rot_z == Cam_Pos[1].rot_z)
                {
                    Timer_tmp = 1.0f;
                    Status = 5;
                }
            }
            break;
        case 5:
            if ([self Timer: &Timer_tmp])
            {
                present_3 = false;
                Timer_tmp = 1.0f;
                Status = 6;
            }
            break;
        case 6:
            if ([self Timer: &Timer_tmp])
            {
                present_2 = false;
                present_4 = true;
                root_road = true;
                Timer_tmp = 1.0f;
                Status = 7;
            }
            break;
        case 7:
            if ([self Timer: &Timer_tmp])
            {
                Cam_Speed.pos_x = (Cam_Pos[2].pos_x - Cam_Pos[1].pos_x) * 0.75;
                if (Cam_Speed.pos_x < 0) Cam_Speed.pos_x *= -1;
                Cam_Speed.pos_y = (Cam_Pos[2].pos_y - Cam_Pos[1].pos_y) * 0.75;
                if (Cam_Speed.pos_y < 0) Cam_Speed.pos_y *= -1;
                Cam_Speed.pos_z = (Cam_Pos[2].pos_z - Cam_Pos[1].pos_z) * 0.75;
                if (Cam_Speed.pos_z < 0) Cam_Speed.pos_z *= -1;
                Cam_Speed.rot_x = (Cam_Pos[2].rot_x - Cam_Pos[1].rot_x) * 0.75;
                if (Cam_Speed.rot_x < 0) Cam_Speed.rot_x *= -1;
                Cam_Speed.rot_y = (Cam_Pos[2].rot_y - Cam_Pos[1].rot_y) * 0.75;
                if (Cam_Speed.rot_y < 0) Cam_Speed.rot_y *= -1;
                Cam_Speed.rot_z = (Cam_Pos[2].rot_z - Cam_Pos[1].rot_z) * 0.75;
                if (Cam_Speed.rot_z < 0) Cam_Speed.rot_z *= -1;
                Status = 8;
            }
            break;
        case 8:
            [self Change_Smooth : &Cam_Position.pos_x : Cam_Pos[2].pos_x : Cam_Speed.pos_x];
            [self Change_Smooth : &Cam_Position.pos_y : Cam_Pos[2].pos_y : Cam_Speed.pos_y];
            [self Change_Smooth : &Cam_Position.pos_z : Cam_Pos[2].pos_z : Cam_Speed.pos_z];
            [self Change_Smooth : &Cam_Position.rot_x : Cam_Pos[2].rot_x : Cam_Speed.rot_x];
            [self Change_Smooth : &Cam_Position.rot_y : Cam_Pos[2].rot_y : Cam_Speed.rot_y];
            [self Change_Smooth : &Cam_Position.rot_z : Cam_Pos[2].rot_z : Cam_Speed.rot_z];
            if (Cam_Position.pos_x == Cam_Pos[2].pos_x && Cam_Position.pos_y == Cam_Pos[2].pos_y && Cam_Position.pos_z == Cam_Pos[2].pos_z)
            {
                if (Cam_Position.rot_x == Cam_Pos[2].rot_x && Cam_Position.rot_y == Cam_Pos[2].rot_y && Cam_Position.rot_z == Cam_Pos[2].rot_z)
                {
                    Timer_tmp = 1.0f;
                    Status = 9;
                }
            }
            break;
        case 9:
            if ([self Timer: &Timer_tmp])
            {
                present_1 = false;
                present_4 = false;
                Timer_tmp = 1.0f;
                Status = 10;
            }
            break;
        case 10:
            if ([self Timer: &Timer_tmp])
            {
                Cam_Speed.pos_x = (Cam_Pos[3].pos_x - Cam_Pos[2].pos_x) * 0.75;
                if (Cam_Speed.pos_x < 0) Cam_Speed.pos_x *= -1;
                Cam_Speed.pos_y = (Cam_Pos[3].pos_y - Cam_Pos[2].pos_y) * 0.75;
                if (Cam_Speed.pos_y < 0) Cam_Speed.pos_y *= -1;
                Cam_Speed.pos_z = (Cam_Pos[3].pos_z - Cam_Pos[2].pos_z) * 0.75;
                if (Cam_Speed.pos_z < 0) Cam_Speed.pos_z *= -1;
                Cam_Speed.rot_x = (Cam_Pos[3].rot_x - Cam_Pos[2].rot_x) * 0.75;
                if (Cam_Speed.rot_x < 0) Cam_Speed.rot_x *= -1;
                Cam_Speed.rot_y = (Cam_Pos[3].rot_y - Cam_Pos[2].rot_y) * 0.75;
                if (Cam_Speed.rot_y < 0) Cam_Speed.rot_y *= -1;
                Cam_Speed.rot_z = (Cam_Pos[3].rot_z - Cam_Pos[2].rot_z) * 0.75;
                if (Cam_Speed.rot_z < 0) Cam_Speed.rot_z *= -1;
                Status = 11;
            }
            break;
        case 11:
            [self Change_Smooth : &Cam_Position.pos_x : Cam_Pos[3].pos_x : Cam_Speed.pos_x];
            [self Change_Smooth : &Cam_Position.pos_y : Cam_Pos[3].pos_y : Cam_Speed.pos_y];
            [self Change_Smooth : &Cam_Position.pos_z : Cam_Pos[3].pos_z : Cam_Speed.pos_z];
            [self Change_Smooth : &Cam_Position.rot_x : Cam_Pos[3].rot_x : Cam_Speed.rot_x];
            [self Change_Smooth : &Cam_Position.rot_y : Cam_Pos[3].rot_y : Cam_Speed.rot_y];
            [self Change_Smooth : &Cam_Position.rot_z : Cam_Pos[3].rot_z : Cam_Speed.rot_z];
            if (Cam_Position.pos_x == Cam_Pos[3].pos_x && Cam_Position.pos_y == Cam_Pos[3].pos_y && Cam_Position.pos_z == Cam_Pos[3].pos_z)
            {
                if (Cam_Position.rot_x == Cam_Pos[3].rot_x && Cam_Position.rot_y == Cam_Pos[3].rot_y && Cam_Position.rot_z == Cam_Pos[3].rot_z)
                {
                    Timer_tmp = 1.0f;
                    Status = 12;
                }
            }
            break;
        case 12:
            if ([self Timer: &Timer_tmp])
            {
                Status = 13;
            }
            break;
        case 13:
            [self Change_Smooth : &fade : 0 : 1.0f];
            if (fade == 0)
            {
                Timer_tmp = 0.5f;
                Status = 14;
            }
            break;
        case 14:
            if ([self Timer: &Timer_tmp])
            {
               Game_Data->Status_Next_tmp = Stat_Start;
            }
            break;            
        default:
            break;
    }
    
    Game_Data->CameraMatrix = GLKMatrix4MakeTranslation(0, 0, Cam_Position.pos_z);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(Cam_Position.rot_z), 0.0f, 0.0f, 1.0f);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(Cam_Position.rot_x), 1.0f, 0.0f, 0.0f);
    Game_Data->CameraMatrix = GLKMatrix4Translate(Game_Data->CameraMatrix, Cam_Position.pos_x, Cam_Position.pos_y, 0);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(Cam_Position.rot_y), 0.0f, 1.0f, 0.0f);
    
    Sector_Draw.Matrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, 0.0f);
    Sector_Draw.Matrix = GLKMatrix4Rotate(Sector_Draw.Matrix, GLKMathDegreesToRadians(0), 0.0f, -1.0f, 0.0f);
    Sector_Matrix[0] = GLKMatrix4Rotate(Sector_Draw.Matrix, GLKMathDegreesToRadians(45), 0.0f, -1.0f, 0.0f);
    Sector_Matrix[1] = GLKMatrix4Rotate(Sector_Draw.Matrix, GLKMathDegreesToRadians(90), 0.0f, -1.0f, 0.0f);
    Sector_Matrix[2] = GLKMatrix4Rotate(Sector_Draw.Matrix, GLKMathDegreesToRadians(135), 0.0f, -1.0f, 0.0f);
    Sector_Matrix[3] = GLKMatrix4Rotate(Sector_Draw.Matrix, GLKMathDegreesToRadians(180), 0.0f, -1.0f, 0.0f);
    Sector_Matrix[4] = GLKMatrix4Rotate(Sector_Draw.Matrix, GLKMathDegreesToRadians(225), 0.0f, -1.0f, 0.0f);
    Sector_Matrix[5] = GLKMatrix4Rotate(Sector_Draw.Matrix, GLKMathDegreesToRadians(270), 0.0f, -1.0f, 0.0f);
    Sector_Matrix[6] = GLKMatrix4Rotate(Sector_Draw.Matrix, GLKMathDegreesToRadians(315), 0.0f, -1.0f, 0.0f);
    Sector_Draw.Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_Draw.Matrix);
    Sector_Matrix[0] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_Matrix[0]);
    Sector_Matrix[1] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_Matrix[1]);
    Sector_Matrix[2] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_Matrix[2]);
    Sector_Matrix[3] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_Matrix[3]);
    Sector_Matrix[4] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_Matrix[4]);
    Sector_Matrix[5] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_Matrix[5]);
    Sector_Matrix[6] = GLKMatrix4Multiply(Game_Data->CameraMatrix, Sector_Matrix[6]);
    
    Object_Car_Matrix = GLKMatrix4MakeTranslation(65, 1, 0);
    Object_Car_Matrix = GLKMatrix4Multiply(Game_Data->CameraMatrix, Object_Car_Matrix);
}

-(void)Draw
{
        Game_Data->effect.constantColor = GLKVector4Make(fade, fade, fade, 1.0f);
        
        Game_Data->effect.transform.modelviewMatrix = Game_Data->CameraMatrix;
    
    Game_Data->effect.light0.diffuseColor = GLKVector4Make(fade, fade, fade, 1.0f);
    Game_Data->effect.light0.specularColor = GLKVector4Make(fade, fade, fade, 1.0f);
    Game_Data->effect.light0.ambientColor = GLKVector4Make(fade, fade, fade, 1.0f);
    
    Game_Data->effect.light1.diffuseColor = GLKVector4Make(fade, fade, fade, 1.0f);
    Game_Data->effect.light1.specularColor = GLKVector4Make(fade, fade, fade, 1.0f);
    Game_Data->effect.light1.ambientColor = GLKVector4Make(fade, fade, fade, 1.0f);
    
    if (Game_Data->light)
    {
        Game_Data->effect.light0.enabled = GL_TRUE;
        Game_Data->effect.light1.enabled = GL_TRUE;
    }
        if (present_1)
        {
            Game_Data->effect.texture2d0.name = Texture_Present;
            [Game_Data->effect prepareToDraw];
            glBindVertexArrayOES(Object_Present_1.Array);
            glDrawArrays(GL_TRIANGLES, 0, Object_Present_1.Vertex_Count);
        }
        if (present_2)
        {
            Game_Data->effect.texture2d0.name = Texture_Present;
            [Game_Data->effect prepareToDraw];
            glBindVertexArrayOES(Object_Present_2.Array);
            glDrawArrays(GL_TRIANGLES, 0, Object_Present_2.Vertex_Count);
        }
        if (present_3)
        {
            Game_Data->effect.texture2d0.name = Texture_Present;
            [Game_Data->effect prepareToDraw];
            glBindVertexArrayOES(Object_Present_3.Array);
            glDrawArrays(GL_TRIANGLES, 0, Object_Present_3.Vertex_Count);
        }
        if (present_4)
        {
            Game_Data->effect.texture2d0.name = Texture_Present;
            [Game_Data->effect prepareToDraw];
            glBindVertexArrayOES(Object_Present_4.Array);
            glDrawArrays(GL_TRIANGLES, 0, Object_Present_4.Vertex_Count);
        }
        
        Game_Data->effect.texture2d0.name = Object_Sky.Texture;
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Sky.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Sky.Vertex_Count);
        
        Game_Data->effect.texture2d0.name = Texture_Room;
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Room.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Room.Vertex_Count);
    
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Room2.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Room2.Vertex_Count);
    
        Game_Data->effect.texture2d0.name = Object_Table.Texture;
        [Game_Data->effect prepareToDraw];
        glBindVertexArrayOES(Object_Table.Array);
        glDrawArrays(GL_TRIANGLES, 0, Object_Table.Vertex_Count);
        
        if (root_road)
        {
            Game_Data->effect.texture2d0.name = Texture_Root;
            [Game_Data->effect prepareToDraw];
            glBindVertexArrayOES(Object_Root.Array);
            glDrawArrays(GL_TRIANGLES, 0, Object_Root.Vertex_Count);
            
            //Прорисовка дороги
            Game_Data->effect.transform.modelviewMatrix = Sector_Draw.Matrix;
            [self Draw_Sector : &Sector_Draw : 0];
            Game_Data->effect.transform.modelviewMatrix = Sector_Matrix[0];
            [self Draw_Sector : &Sector_Draw : 1];
            Game_Data->effect.transform.modelviewMatrix = Sector_Matrix[1];
            [self Draw_Sector : &Sector_Draw : 2];
            Game_Data->effect.transform.modelviewMatrix = Sector_Matrix[2];
            [self Draw_Sector : &Sector_Draw : 3];
            Game_Data->effect.transform.modelviewMatrix = Sector_Matrix[3];
            [self Draw_Sector : &Sector_Draw : 4];
            Game_Data->effect.transform.modelviewMatrix = Sector_Matrix[4];
            [self Draw_Sector : &Sector_Draw : 5];
            Game_Data->effect.transform.modelviewMatrix = Sector_Matrix[5];
            [self Draw_Sector : &Sector_Draw : 6];
            Game_Data->effect.transform.modelviewMatrix = Sector_Matrix[6];
            [self Draw_Sector : &Sector_Draw : 7];
            
            Game_Data->effect.transform.modelviewMatrix = Object_Car_Matrix;
            Game_Data->effect.texture2d0.name = Texture_Car;
            [Game_Data->effect prepareToDraw];
            glBindVertexArrayOES(Object_Car.Array);
            glDrawArrays(GL_TRIANGLES, 0, Object_Car.Vertex_Count);
        }
    if (Game_Data->light)
    {
        Game_Data->effect.light0.enabled = GL_FALSE;
        Game_Data->effect.light1.enabled = GL_FALSE;
    }
}

-(void)Draw_Sector : (struct SectorDraw*)obj : (int) num
{
    Game_Data->effect.texture2d0.name = Object_Circle.Texture;
    [Game_Data->effect prepareToDraw];
    glBindVertexArrayOES(Object_Circle.Array);
    glDrawArrays(GL_TRIANGLES, 0, Object_Circle.Vertex_Count);
    Game_Data->effect.texture2d0.name = Wall_Texture_1[num];
    [Game_Data->effect prepareToDraw];
    glBindVertexArrayOES(Object_Wall1.Array);
    glDrawArrays(GL_TRIANGLES, 0, Object_Wall1.Vertex_Count);
    Game_Data->effect.texture2d0.name = Wall_Texture_2[num];
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

}

-(void)Touch_End: (NSSet *)touches
{
    
}

-(void)Touch_Move: (NSSet *)touches
{
}

-(void)dealloc
{
    //Дорога
    glDeleteTextures(1, &Road_Texture[0]);
    glDeleteTextures(1, &Road_Texture[1]);
    glDeleteTextures(1, &Road_Texture[2]);
    
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

    glDeleteTextures(1, &Loading.Texture);
    glDeleteTextures(1, &Object_Car.Texture);
    glDeleteTextures(1, &Object_Circle.Texture);
    glDeleteTextures(1, &Object_Table.Texture);
    glDeleteTextures(1, &Object_Sky.Texture);
    
    //Текстуры постоянных объектов
    glDeleteTextures(1, &Texture_Room);
    glDeleteTextures(1, &Texture_Root);
    glDeleteTextures(1, &Texture_Car);
    glDeleteTextures(1, &Texture_Present);
    
    [super dealloc];
}
@end

