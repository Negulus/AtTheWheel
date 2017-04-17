//
//  menu.m
//  At the Wheel
//
//  Created by Администратор on 4/15/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#import "menuset.h"

@implementation MenuSet
-(id)init : (struct GameData*)data
{
    self = [super init : data];
    if (self)
    {
        
        //Объекты
        [self CreateObject2D: &Background : Game_Data->Game_Center - 568 : 0 : 1136 : 640 : [self Load_Texture:@"menuset_bg"]];
        [self CreateObject2D: &Obj_Text_Dif : Background.Position[0]+150 : Background.Position[1]+350 : 252 : 51 : [self Load_Texture:@"menuset_dif_text"]];
        [self CreateObject2D: &Obj_Text_Con : Background.Position[0]+150 : Background.Position[1]+505 : 265 : 51 : [self Load_Texture:@"menuset_con_text"]];
        [self CreateObject2D: &Obj_Check : 0 : 0 : 75 : 71 : [self Load_Texture:@"menuset_check"]];
        [self CreateObject2D: &Obj_Dif_0 : Background.Position[0]+540 : Background.Position[1]+330 : 175 : 94 : [self Load_Texture:@"menuset_dif_0"]];
        [self CreateObject2D: &Obj_Dif_1 : Background.Position[0]+808 : Background.Position[1]+330 : 176 : 94 : [self Load_Texture:@"menuset_dif_1"]];
        [self CreateObject2D: &Obj_Con_0 : Background.Position[0]+520 : Background.Position[1]+475 : 195 : 98 : [self Load_Texture:@"menuset_con_0"]];
        [self CreateObject2D: &Obj_Con_1 : Background.Position[0]+775 : Background.Position[1]+455 : 209 : 137 : [self Load_Texture:@"menuset_con_1"]];
        [self CreateObject2D: &Obj_Color[0] : Background.Position[0]+344 : Background.Position[1]+230 : 64 : 64 : [self Load_Texture:@"menuset_car_r"]];
        [self CreateObject2D: &Obj_Color[1] : Obj_Color[0].Position[0] + 128 : Obj_Color[0].Position[1] : 64 : 64 : [self Load_Texture:@"menuset_car_g"]];
        [self CreateObject2D: &Obj_Color[2] : Obj_Color[1].Position[0] + 128 : Obj_Color[0].Position[1] : 64 : 64 : [self Load_Texture:@"menuset_car_y"]];
        [self CreateObject2D: &Obj_Color[3] : Obj_Color[2].Position[0] + 128 : Obj_Color[0].Position[1] : 64 : 64 : [self Load_Texture:@"menuset_car_b"]];
        
        //Переменные для машины
        [self Load_Object: &Obj_Car : @"object_car_6.txt"];
        Texture_Car[0] = [self Load_Texture:@"car_0"];
        Texture_Car[1] = [self Load_Texture:@"car_1"];
        Texture_Car[2] = [self Load_Texture:@"car_2"];
        Texture_Car[3] = [self Load_Texture:@"car_3"];

        //Настройка камеры 3D
        Game_Data->CameraMatrix = GLKMatrix4MakeTranslation(0, 0, -50);
        Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(30), 1.0f, 0.0f, 0.0f);
        Game_Data->CameraMatrix = GLKMatrix4Translate(Game_Data->CameraMatrix, 0, 11, 0);
        Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(CamRotY), 0.0f, -1.0f, 0.0f);
        
        //Настройка камеры 2D
        Game_Data->HUDMatrix = GLKMatrix4MakeTranslation(0, 0, 0);
//        Game_Data->HUDMatrix = GLKMatrix4Rotate(Game_Data->HUDMatrix, GLKMathDegreesToRadians(90), 0.0f, 0.0f, 1.0f);
        Game_Data->HUDMatrix = GLKMatrix4Scale(Game_Data->HUDMatrix, 0.5f, 0.5f, 0.0f);
        
        [self Reset];
    }
    return self;
}

-(void)Reset
{
    //Переменные для машины
    CamRotY = 0;
    
    //Временное хранение настроек
    Dif_tmp = Game_Data->Set_Dif;
    Color_tmp = Game_Data->Set_Color;
    Con_tmp = Game_Data->Set_Con;
    
    //Системные переменные
    Touch_Point = false;
    
//    Game_Data->Status_Next_Load = false;
}

-(void)Update
{
    CamRotY += 45 * Game_Data->timeSinceLastUpdate;
    if (CamRotY >= 360)
        CamRotY = CamRotY - 360;
    
    Game_Data->CameraMatrix = GLKMatrix4MakeTranslation(0, 0, -50);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(30), 1.0f, 0.0f, 0.0f);
    Game_Data->CameraMatrix = GLKMatrix4Translate(Game_Data->CameraMatrix, 0, 11, 0);
    Game_Data->CameraMatrix = GLKMatrix4Rotate(Game_Data->CameraMatrix, GLKMathDegreesToRadians(CamRotY), 0.0f, -1.0f, 0.0f);
}

-(void)Draw
{
    glDisable(GL_DEPTH_TEST);
    [self DrawObject2D: &Background];
    [self DrawObject2D: &Obj_Text_Dif];
    [self DrawObject2D: &Obj_Text_Con];
    
    [self DrawObject2D: &Obj_Dif_0];
    [self DrawObject2D: &Obj_Dif_1];
    if (Dif_tmp == 0)
    {
        Obj_Check.Position[0] = Obj_Dif_0.Position[0] + 117;
        Obj_Check.Position[1] = Obj_Dif_0.Position[1] + 3;
    }
    else
    {
        Obj_Check.Position[0] = Obj_Dif_1.Position[0] + 118;
        Obj_Check.Position[1] = Obj_Dif_1.Position[1] + 3;
    }
    [self DrawObject2D: &Obj_Check];
    
    [self DrawObject2D: &Obj_Con_0];
    [self DrawObject2D: &Obj_Con_1];
    if (Con_tmp == 0)
    {
        Obj_Check.Position[0] = Obj_Con_0.Position[0] + 137;
        Obj_Check.Position[1] = Obj_Con_0.Position[1] + 3;
    }
    else
    {
        Obj_Check.Position[0] = Obj_Con_1.Position[0] + 151;
        Obj_Check.Position[1] = Obj_Con_1.Position[1] + 23;
    }
    [self DrawObject2D: &Obj_Check];
    
    [self DrawObject2D: &Obj_Color[0]];
    [self DrawObject2D: &Obj_Color[1]];
    [self DrawObject2D: &Obj_Color[2]];
    [self DrawObject2D: &Obj_Color[3]];
    
    glEnable(GL_DEPTH_TEST);
    
    Game_Data->effect.transform.projectionMatrix = Game_Data->ViewMatrix3D;
    Game_Data->effect.texture2d0.name = Texture_Car[Color_tmp];
    Game_Data->effect.transform.modelviewMatrix = Game_Data->CameraMatrix;
    [Game_Data->effect prepareToDraw];
    glBindVertexArrayOES(Obj_Car.Array);
    glDrawArrays(GL_TRIANGLES, 0, Obj_Car.Vertex_Count);
    Game_Data->effect.transform.projectionMatrix = Game_Data->ViewMatrix2D;
}

-(void)Touch_Start: (NSSet *)touches
{
    Touch_Point = true;
}

-(void)Touch_End: (NSSet *)touches
{
     if (Touch_Point)
     {
         for (touch in touches)
         {
             location = [touch locationInView:Game_Data->view];
             location.x *= 2;
             location.y *= 2;
             break;
         }
         
         if ([self Location_Touched: location.x : location.y : 0 : 0 : Background.Position[0] + 350 : Background.Position[1] + 100])
         {
             Game_Data->Status_Next = Stat_MenuMain;
         }
         if ([self Location_Touched: location.x : location.y : Background.Position[0] + 800 : 0 : 1036 : Background.Position[1] + 100])
         {
             Game_Data->Set_Dif = Dif_tmp;
             Game_Data->Set_Con = Con_tmp;
             Game_Data->Set_Color = Color_tmp;
             [self Save_Data : 0];
             Game_Data->Status_Next = Stat_MenuMain;
         }
         else if ([self Location_Touched: location.x : location.y :Obj_Dif_0.Position[0] : Obj_Dif_0.Position[1] : Obj_Dif_0.Vertex[2] : Obj_Dif_0.Vertex[5]])
         {
             Dif_tmp = 0;
         }
         else if ([self Location_Touched: location.x : location.y :Obj_Dif_1.Position[0] : Obj_Dif_1.Position[1] : Obj_Dif_1.Vertex[2] : Obj_Dif_1.Vertex[5]])
         {
             Dif_tmp = 1;
         }
         else if ([self Location_Touched: location.x : location.y :Obj_Con_0.Position[0] : Obj_Con_0.Position[1] : Obj_Con_0.Vertex[2] : Obj_Con_0.Vertex[5]])
         {
             Con_tmp = 0;
         }
         else if ([self Location_Touched: location.x : location.y :Obj_Con_1.Position[0] : Obj_Con_1.Position[1] : Obj_Con_1.Vertex[2] : Obj_Con_1.Vertex[5]])
         {
             Con_tmp = 1;
         }
         else if ([self Location_Touched: location.x : location.y :Obj_Color[0].Position[0] - 20 : Obj_Color[0].Position[1] - 50 : Obj_Color[0].Vertex[2] + 40 : Obj_Color[0].Vertex[5] + 100])
         {
             Color_tmp = 0;
         }
         else if ([self Location_Touched: location.x : location.y :Obj_Color[1].Position[0] - 20 : Obj_Color[1].Position[1] - 50 : Obj_Color[1].Vertex[2] + 40 : Obj_Color[1].Vertex[5] + 100])
         {
             Color_tmp = 1;
         }
         else if ([self Location_Touched: location.x : location.y :Obj_Color[2].Position[0] - 20 : Obj_Color[2].Position[1] - 50 : Obj_Color[2].Vertex[2] + 40 : Obj_Color[2].Vertex[5] + 100])
         {
             Color_tmp = 2;
         }
         else if ([self Location_Touched: location.x : location.y :Obj_Color[3].Position[0] - 20 : Obj_Color[3].Position[1] - 50 : Obj_Color[3].Vertex[2] + 40 : Obj_Color[3].Vertex[5] + 100])
         {
             Color_tmp = 3;
         }
     }
}

-(void)Touch_Move: (NSSet *)touches
{
    Touch_Point = false;
}

-(void)dealloc
{
    //Объекты
    glDeleteTextures(1, &Background.Texture);
    glDeleteTextures(1, &Obj_Text_Dif.Texture);
    glDeleteTextures(1, &Obj_Text_Con.Texture);
    glDeleteTextures(1, &Obj_Check.Texture);
    glDeleteTextures(1, &Obj_Dif_0.Texture);
    glDeleteTextures(1, &Obj_Dif_1.Texture);
    glDeleteTextures(1, &Obj_Con_0.Texture);
    glDeleteTextures(1, &Obj_Con_1.Texture);
    glDeleteTextures(1, &Obj_Color[0].Texture);
    glDeleteTextures(1, &Obj_Color[1].Texture);
    glDeleteTextures(1, &Obj_Color[2].Texture);
    glDeleteTextures(1, &Obj_Color[3].Texture);
    
    //Переменные для машины
    glDeleteTextures(1, &Obj_Car.Texture);
//    struct Object Obj_Car;
    glDeleteTextures(1, &Texture_Car[0]);
    glDeleteTextures(1, &Texture_Car[1]);
    glDeleteTextures(1, &Texture_Car[2]);
    glDeleteTextures(1, &Texture_Car[3]);
    
	[super dealloc];
}
@end
