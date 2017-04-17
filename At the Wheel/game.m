//
//  At the Wheel
//
//  Created by Negulus on 4/12/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#import <GLKit/GLKit.h>

#import "game.h"

@implementation Game

NSString *Texture_Path_tmp;
GLKTextureInfo *Texture_Info_tmp;

-(id)init : (struct GameData*)data
{
    self = [super init];
    if (self)
    {
        Game_Data = data;
        i = 0;
        tmpb = false;
        
        Vertex_Tex_Full[0] = 0.0f;
        Vertex_Tex_Full[1] = 1.0f;
        Vertex_Tex_Full[2] = 1.0f;
        Vertex_Tex_Full[3] = 1.0f;
        Vertex_Tex_Full[4] = 0.0f;
        Vertex_Tex_Full[5] = 0.0f;
        Vertex_Tex_Full[6] = 1.0f;
        Vertex_Tex_Full[7] = 0.0f;
        
        [self NewColor : Vertex_Col_Full : 1.0f : 1.0f : 1.0f : 1.0f];
        [self NewColor : Vertex_Col_tmp : 1.0f : 1.0f : 1.0f : 1.0f];
    }
    return self;
}

-(void)NewColor : (float*) color : (float) red : (float) green : (float) blue : (float) alpha
{
    color[0] = red;
    color[1] = green;
    color[2] = blue;
    color[3] = alpha;
    color[4] = red;
    color[5] = green;
    color[6] = blue;
    color[7] = alpha;
    color[8] = red;
    color[9] = green;
    color[10] = blue;
    color[11] = alpha;
    color[12] = red;
    color[13] = green;
    color[14] = blue;
    color[15] = alpha;
}

-(bool)Location_Touched : (float)x : (float)y : (float)p_x : (float)p_y : (int)wdth : (int)hght
{
    if ((x > p_x) && (x < (p_x + wdth)))
    {
        if ((y > p_y) && (y < (p_y + hght)))
        {
            return true;
        }
    }
    return false;
}

-(void)CreateObject2D : (struct Object2D*)obj : (float)x : (float)y : (float)wdth : (float)hght : (GLuint)text
{
    obj->Texture = text;
    obj->Vertex[0] = 0.0f;
    obj->Vertex[1] = 0.0f;
    obj->Vertex[2] = wdth;
    obj->Vertex[3] = 0.0f;
    obj->Vertex[4] = 0.0f;
    obj->Vertex[5] = hght;
    obj->Vertex[6] = wdth;
    obj->Vertex[7] = hght;
    obj->Position[0] = x;
    obj->Position[1] = y;
}

-(void)CreateObject2DDigit : (struct Object2DDigit*)obj : (float)x : (float)y : (float)wdth : (float)hght : (float) r_x : (float) r_y
{
    obj->Vertex[0] = 0.0f;
    obj->Vertex[1] = 0.0f;
    obj->Vertex[2] = wdth;
    obj->Vertex[3] = 0.0f;
    obj->Vertex[4] = 0.0f;
    obj->Vertex[5] = hght;
    obj->Vertex[6] = wdth;
    obj->Vertex[7] = hght;
    obj->Position[0] = x;
    obj->Position[1] = y;
    obj->Relative[0] = r_x;
    obj->Relative[1] = r_y;
}

-(void)BindBuffer2D : (float*)buf_pos : (float*)buf_tex : (float*)buf_col
{
    glBindVertexArrayOES(Game_Data->Array_2D);
    glBindBuffer(GL_ARRAY_BUFFER, Game_Data->BufferPos_2D);
    glBufferData(GL_ARRAY_BUFFER, 8 * sizeof(float), buf_pos, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 8, 0);
    
    glBindBuffer(GL_ARRAY_BUFFER, Game_Data->BufferTex_2D);
    glBufferData(GL_ARRAY_BUFFER, 8 * sizeof(float), buf_tex, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 8, 0);
    
//    glBindBuffer(GL_ARRAY_BUFFER, Game_Data->BufferCol_2D);
//    glBufferData(GL_ARRAY_BUFFER, 16 * sizeof(float), buf_col, GL_STATIC_DRAW);
//    glEnableVertexAttribArray(GLKVertexAttribColor);
//    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, 16, 0);
}

-(void)DrawObject2D : (struct Object2D*)obj
{
    [self BindBuffer2D : obj->Vertex : Vertex_Tex_Full : Vertex_Col_Full];
    
    Game_Data->effect.texture2d0.name = obj->Texture;
    Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Translate(Game_Data->HUDMatrix, obj->Position[0], obj->Position[1], 0);
    [Game_Data->effect prepareToDraw];
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}

-(void)DrawObject2DDigit : (struct Object2DDigit*)obj : (int) count : (int)num
{
    [self BindBuffer2D : obj->Vertex : Vertex_Tex_Full : Vertex_Col_Full];
    
    Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Translate(Game_Data->HUDMatrix, obj->Position[0], obj->Position[1], 0);
    
    i = num % 100;
    j = i % 10;
    
    if (count >= 3)
    {
        Game_Data->effect.texture2d0.name = obj->Texture[((num - i) / 100)];
        [Game_Data->effect prepareToDraw];
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Translate(Game_Data->effect.transform.modelviewMatrix, obj->Relative[0], obj->Relative[1], 0);
    }
    
    if (count >= 2)
    {
        Game_Data->effect.texture2d0.name = obj->Texture[((i-j) / 10)];
        [Game_Data->effect prepareToDraw];
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
        Game_Data->effect.transform.modelviewMatrix = GLKMatrix4Translate(Game_Data->effect.transform.modelviewMatrix, obj->Relative[0], obj->Relative[1], 0);
    }
    
    if (count >= 1)
    {
        Game_Data->effect.texture2d0.name = obj->Texture[j];
        [Game_Data->effect prepareToDraw];
        glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    }
}

-(void)Load_Object : (struct Object*)obj : (NSString*)name
{
    path = [[NSBundle mainBundle] bundlePath];
    xmlPath = [path stringByAppendingPathComponent:name];
    fileString = [NSString stringWithContentsOfFile:xmlPath encoding:NSUTF8StringEncoding error:nil];
    lines = [fileString componentsSeparatedByString:@"\n"];
    
    obj->Vertex_Count = 0;
    
    tmps = [lines[0] stringByReplacingOccurrencesOfString:@"\r" withString:@""];

    if (!([tmps isEqualToString: @"none"]))
    {
        obj->Texture = [self Load_Texture:tmps];
    }
    else
    {
        obj->Texture = 0;
    }
    
    obj->Vertex_Count = [lines[1] intValue];
    obj->Vertex = malloc(sizeof(*obj->Vertex) * obj->Vertex_Count * 8);
    
    i = 2;
    j = 0;
    tmpui = 0;
    tmpb = true;
    while (tmpb)
    {
        if (i < lines.count)
        {
            if (j >= obj->Vertex_Count)
            {
                tmpb = false;
            }
            else if ([lines[i] isEqualToString: @"Box"])
            {
                tmpb = false;
            }
            else
            {
                str = [lines[i] componentsSeparatedByString:@" "];
                obj->Vertex[tmpui] = [str[0] floatValue];
                tmpui++;
                obj->Vertex[tmpui] = [str[1] floatValue];
                tmpui++;
                obj->Vertex[tmpui] = [str[2] floatValue];
                tmpui++;
                obj->Vertex[tmpui] = [str[3] floatValue];
                tmpui++;
                obj->Vertex[tmpui] = [str[4] floatValue];
                tmpui++;
                obj->Vertex[tmpui] = [str[5] floatValue];
                tmpui++;
                obj->Vertex[tmpui] = [str[6] floatValue];
                tmpui++;
                obj->Vertex[tmpui] = [str[7] floatValue];
                tmpui++;
                j++;
            }
        }
        else
            tmpb = false;
        i++;
    }
    
    j = 0;
    tmpui = 0;
    tmpb = true;
    while (tmpb)
    {
        if (i < lines.count)
        {
            if (j == 0)
            {
                obj->Box_Count = [lines[i] intValue];
                obj->Box = malloc(sizeof(*obj->Box) * obj->Box_Count * 2);
                j++;
            }
            else if (j > obj->Box_Count)
            {
                tmpb = false;
            }
            else if ([lines[i] isEqualToString: @"End"])
            {
                tmpb = false;
            }
            else
            {
                str = [lines[i] componentsSeparatedByString:@" "];
                obj->Box[tmpui] = [str[0] floatValue];
                tmpui++;
                obj->Box[tmpui] = [str[1] floatValue];
                tmpui++;
                j++;
            }
        }
        else
            tmpb = false;
        i++;
    }
    
    glGenVertexArraysOES(1, &obj->Array);
    glBindVertexArrayOES(obj->Array);
    glGenBuffers(1, &obj->Buffer);
    glBindBuffer(GL_ARRAY_BUFFER, obj->Buffer);
    glBufferData(GL_ARRAY_BUFFER, (sizeof(GLfloat) * obj->Vertex_Count * 8), obj->Vertex, GL_DYNAMIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(12));
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(24));
    glBindVertexArrayOES(0);
    
//    path;
//    xmlPath
//    fileString
//    lines
//    str;
//    tmps;
}

//Загрузка текстуры
-(GLuint)Load_Texture : (NSString*)name
{
    NSDictionary * options = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool:YES], GLKTextureLoaderOriginBottomLeft, nil];
    Texture_Path_tmp = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    Texture_Info_tmp = [GLKTextureLoader textureWithContentsOfFile:Texture_Path_tmp options:options error:nil];
    return Texture_Info_tmp.name;
}

-(float)Vector_Length : (float)x : (float)y
{
    Vector_tmp = GLKVector2Make(x, y);
    return GLKVector2Length(Vector_tmp);
}

-(int)On_Road : (struct SectorDraw*)obj : (struct ObjectCar*)car : (float)angle
{
    //Определение типа дороги под машиной
    tmpi = 7;
    for (i = 0; i < 6; i++)
    {
        //Прямая дорога
        if ((obj->Surf[i] > 0) && (obj->Surf[i] < 7))
        {
            if (car->Position[0] >= (20 + (obj->Surf[i] * 10)) && car->Position[0] <= (30 + (obj->Surf[i] * 10)))
            {
                if (tmpi > obj->Type[i])
                    tmpi = obj->Type[i];
            }
        }
        //Поворот вверх
        else if ((obj->Surf[i] > 6) && (obj->Surf[i] < 12))
        {
            tmpf = angle - car->Position[1];
            tmpf = tmpf / 45.0f;
            if (tmpf <= 0.2f)
            {
                if (car->Position[0] >= (20 + ((obj->Surf[i] - 6) * 10) + (tmpf * 5 * 1)) && car->Position[0] <= (30 + ((obj->Surf[i] - 6) * 10) + (tmpf * 5 * 1)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.4f)
            {
                if (car->Position[0] >= (21 + ((obj->Surf[i] - 6) * 10) + ((tmpf - 0.2f) * 5 * 2)) && car->Position[0] <= (31 + ((obj->Surf[i] - 6) * 10) + ((tmpf - 0.2f) * 5 * 2)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.6f)
            {
                if (car->Position[0] >= (23 + ((obj->Surf[i] - 6) * 10) + ((tmpf - 0.4f) * 5 * 4)) && car->Position[0] <= (33 + ((obj->Surf[i] - 6) * 10) + ((tmpf - 0.4f) * 5 * 4)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.8f)
            {
                if (car->Position[0] >= (27 + ((obj->Surf[i] - 6) * 10) + ((tmpf - 0.6f) * 5 * 2)) && car->Position[0] <= (37 + ((obj->Surf[i] - 6) * 10) + ((tmpf - 0.6f) * 5 * 2)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else
            {
                if (car->Position[0] >= (29 + ((obj->Surf[i] - 6) * 10) + ((tmpf - 0.8f) * 5 * 1)) && car->Position[0] <= (39 + ((obj->Surf[i] - 6) * 10) + ((tmpf - 0.8f) * 5 * 1)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
        }
        //Поворот вниз
        else if ((obj->Surf[i] > 11) && (obj->Surf[i] < 17))
        {
            tmpf = angle - car->Position[1];
            tmpf = tmpf / 45.0f;
            if (tmpf <= 0.2f)
            {
                if (car->Position[0] >= (30 + ((obj->Surf[i] - 11) * 10) - (tmpf * 5 * 1)) && car->Position[0] <= (40 + ((obj->Surf[i] - 11) * 10) - (tmpf * 5 * 1)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.4f)
            {
                if (car->Position[0] >= (29 + ((obj->Surf[i] - 11) * 10) - ((tmpf - 0.2f) * 5 * 2)) && car->Position[0] <= (39 + ((obj->Surf[i] - 11) * 10) - ((tmpf - 0.2f) * 5 * 2)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.6f)
            {
                if (car->Position[0] >= (27 + ((obj->Surf[i] - 11) * 10) - ((tmpf - 0.4f) * 5 * 4)) && car->Position[0] <= (37 + ((obj->Surf[i] - 11) * 10) - ((tmpf - 0.4f) * 5 * 4)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.8f)
            {
                if (car->Position[0] >= (23 + ((obj->Surf[i] - 11) * 10) - ((tmpf - 0.6f) * 5 * 2)) && car->Position[0] <= (33 + ((obj->Surf[i] - 11) * 10) - ((tmpf - 0.6f) * 5 * 2)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else
            {
                if (car->Position[0] >= (21 + ((obj->Surf[i] - 11) * 10) - ((tmpf - 0.8f) * 5 * 1)) && car->Position[0] <= (31 + ((obj->Surf[i] - 11) * 10) - ((tmpf - 0.8f) * 5 * 1)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
        }
        //Расширение дороги вверх
        else if ((obj->Surf[i] > 16) && (obj->Surf[i] < 22))
        {            
            tmpf = angle - car->Position[1];
            tmpf = tmpf / 45.0f;
            if (tmpf <= 0.2f)
            {
                if (car->Position[0] >= (20 + ((obj->Surf[i] - 16) * 10)) && car->Position[0] <= (20 + ((obj->Surf[i] - 16) * 10) + (tmpf * 5 * 1)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.4f)
            {
                if (car->Position[0] >= (20 + ((obj->Surf[i] - 16) * 10)) && car->Position[0] <= (21 + ((obj->Surf[i] - 16) * 10) + ((tmpf - 0.2f) * 5 * 2)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.6f)
            {
                if (car->Position[0] >= (20 + ((obj->Surf[i] - 16) * 10)) && car->Position[0] <= (23 + ((obj->Surf[i] - 16) * 10) + ((tmpf - 0.4f) * 5 * 4)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.8f)
            {
                if (car->Position[0] >= (20 + ((obj->Surf[i] - 16) * 10)) && car->Position[0] <= (27 + ((obj->Surf[i] - 16) * 10) + ((tmpf - 0.6f) * 5 * 2)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else
            {
                if (car->Position[0] >= (20 + ((obj->Surf[i] - 16) * 10)) && car->Position[0] <= (29 + ((obj->Surf[i] - 16) * 10) + ((tmpf - 0.8f) * 5 * 1)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
        }
        //Расширение дороги вниз
        else if ((obj->Surf[i] > 21) && (obj->Surf[i] < 27))
        {
            tmpf = angle - car->Position[1];
            tmpf = tmpf / 45.0f;
            if (tmpf <= 0.2f)
            {
                if (car->Position[0] >= (40 + ((obj->Surf[i] - 21) * 10) - (tmpf * 5 * 1)) && car->Position[0] <= (40 + ((obj->Surf[i] - 21) * 10)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.4f)
            {
                if (car->Position[0] >= (39 + ((obj->Surf[i] - 21) * 10) - ((tmpf - 0.2f) * 5 * 2)) && car->Position[0] <= (40 + ((obj->Surf[i] - 21) * 10)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.6f)
            {
                if (car->Position[0] >= (37 + ((obj->Surf[i] - 21) * 10) - ((tmpf - 0.4f) * 5 * 4)) && car->Position[0] <= (40 + ((obj->Surf[i] - 21) * 10)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.8f)
            {
                if (car->Position[0] >= (33 + ((obj->Surf[i] - 21) * 10) - ((tmpf - 0.6f) * 5 * 2)) && car->Position[0] <= (40 + ((obj->Surf[i] - 21) * 10)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else
            {
                if (car->Position[0] >= (31 + ((obj->Surf[i] - 21) * 10) - ((tmpf - 0.8f) * 5 * 1)) && car->Position[0] <= (40 + ((obj->Surf[i] - 21) * 10)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
        }
        //Сужение дороги вверх
        else if ((obj->Surf[i] > 26) && (obj->Surf[i] < 32))
        {
            tmpf = angle - car->Position[1];
            tmpf = tmpf / 45.0f;
            
            if (tmpf <= 0.2f)
            {
                if (car->Position[0] >= (30 + ((obj->Surf[i] - 26) * 10) + (tmpf * 5 * 1)) && car->Position[0] <= (40 + ((obj->Surf[i] - 26) * 10)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.4f)
            {
                if (car->Position[0] >= (31 + ((obj->Surf[i] - 26) * 10) + ((tmpf - 0.2f) * 5 * 2)) && car->Position[0] <= (40 + ((obj->Surf[i] - 26) * 10)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.6f)
            {
                if (car->Position[0] >= (33 + ((obj->Surf[i] - 26) * 10) + ((tmpf - 0.4f) * 5 * 4)) && car->Position[0] <= (40 + ((obj->Surf[i] - 26) * 10)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.8f)
            {
                if (car->Position[0] >= (37 + ((obj->Surf[i] - 26) * 10) + ((tmpf - 0.6f) * 5 * 2)) && car->Position[0] <= (40 + ((obj->Surf[i] - 26) * 10)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else
            {
                if (car->Position[0] >= (39 + ((obj->Surf[i] - 26) * 10) + ((tmpf - 0.8f) * 5 * 1)) && car->Position[0] <= (40 + ((obj->Surf[i] - 26) * 10)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
        }
        //Сужение дороги вниз
        else if ((obj->Surf[i] > 31) && (obj->Surf[i] < 37))
        {
            tmpf = angle - car->Position[1];
            tmpf = tmpf / 45.0f;
            
            if (tmpf <= 0.2f)
            {
                if (car->Position[0] >= (20 + ((obj->Surf[i] - 31) * 10)) && car->Position[0] <= (30 + ((obj->Surf[i] - 31) * 10) - (tmpf * 5 * 1)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.4f)
            {
                if (car->Position[0] >= (20 + ((obj->Surf[i] - 31) * 10)) && car->Position[0] <= (29 + ((obj->Surf[i] - 31) * 10) - ((tmpf - 0.2f) * 5 * 2)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.6f)
            {
                if (car->Position[0] >= (20 + ((obj->Surf[i] - 31) * 10)) && car->Position[0] <= (27 + ((obj->Surf[i] - 31) * 10) - ((tmpf - 0.4f) * 5 * 4)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else if (tmpf <= 0.8f)
            {
                if (car->Position[0] >= (20 + ((obj->Surf[i] - 31) * 10)) && car->Position[0] <= (23 + ((obj->Surf[i] - 31) * 10) - ((tmpf - 0.6f) * 5 * 2)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
            else
            {
                if (car->Position[0] >= (20 + ((obj->Surf[i] - 31) * 10)) && car->Position[0] <= (21 + ((obj->Surf[i] - 31) * 10) - ((tmpf - 0.8f) * 5 * 1)))
                {
                    if (tmpi > obj->Type[i])
                        tmpi = obj->Type[i];
                }
            }
        }
    }
    if (tmpi > 6)
        tmpi = 0;
    return tmpi;
}

-(BOOL)Car_Bounce : (struct ObjectDraw*)obj : (struct ObjectCar*)car
{
    for (k = 0; k < 8; k++)
    {
        if (car->Obj.Box_Count > 1)
        {
            if (obj->Obj->Box_Count > ((k * 2) + 1))
            {
                tmpf = car->Position[1] - car->Obj.Box[1];
                if ((tmpf > (obj->Position[1] - obj->Obj->Box[(k * 4) + 1]) && tmpf < (obj->Position[1] - obj->Obj->Box[(k * 4) + 3])) || (tmpf > (obj->Position[1] - obj->Obj->Box[(k * 4) + 3]) && tmpf < (obj->Position[1] - obj->Obj->Box[(k * 4) + 1])))
                {
                    tmpf = car->Position[0] + car->Obj.Box[0];
                    if ((tmpf > (obj->Position[0] + obj->Obj->Box[k * 4]) && tmpf < (obj->Position[0] + obj->Obj->Box[(k * 4) + 2])) || (tmpf > (obj->Position[0] + obj->Obj->Box[(k * 4) + 2]) && tmpf < (obj->Position[0] + obj->Obj->Box[k * 4])))
                    {
                        return true;
                    }
                    
                    tmpf = car->Position[0] + car->Obj.Box[2];
                    if ((tmpf > (obj->Position[0] + obj->Obj->Box[k * 4]) && tmpf < (obj->Position[0] + obj->Obj->Box[(k * 4) + 2])) || (tmpf > (obj->Position[0] + obj->Obj->Box[(k * 4) + 2]) && tmpf < (obj->Position[0] + obj->Obj->Box[k * 4])))
                    {
                        return true;
                    }
                }
                tmpf = car->Position[1] - car->Obj.Box[3];
                if ((tmpf > (obj->Position[1] - obj->Obj->Box[(k * 4) + 1]) && tmpf < (obj->Position[1] - obj->Obj->Box[(k * 4) + 3])) || (tmpf > (obj->Position[1] - obj->Obj->Box[(k * 4) + 3]) && tmpf < (obj->Position[1] - obj->Obj->Box[(k * 4) + 1])))
                {
                    tmpf = car->Position[0] + car->Obj.Box[0];
                    if ((tmpf > (obj->Position[0] + obj->Obj->Box[k * 4]) && tmpf < (obj->Position[0] + obj->Obj->Box[(k * 4) + 2])) || (tmpf > (obj->Position[0] + obj->Obj->Box[(k * 4) + 2]) && tmpf < (obj->Position[0] + obj->Obj->Box[k * 4])))
                    {
                        return true;
                    }
                    
                    tmpf = car->Position[0] + car->Obj.Box[2];
                    if ((tmpf > (obj->Position[0] + obj->Obj->Box[k * 4]) && tmpf < (obj->Position[0] + obj->Obj->Box[(k * 4) + 2])) || (tmpf > (obj->Position[0] + obj->Obj->Box[(k * 4) + 2]) && tmpf < (obj->Position[0] + obj->Obj->Box[k * 4])))
                    {
                        return true;
                    }
                }
                
                tmpf = obj->Position[1] - obj->Obj->Box[(k * 4) + 1];
                if ((tmpf > (car->Position[1] - car->Obj.Box[1]) && tmpf < (car->Position[1] - car->Obj.Box[3])) || (tmpf > (car->Position[1] - car->Obj.Box[3]) && tmpf < (car->Position[1] - car->Obj.Box[1])))
                {
                    tmpf = obj->Position[0] + obj->Obj->Box[k * 4];
                    if ((tmpf > (car->Position[0] + car->Obj.Box[0]) && tmpf < (car->Position[0] + car->Obj.Box[2])) || (tmpf > (car->Position[0] + car->Obj.Box[2]) && tmpf < (car->Position[0] + car->Obj.Box[0])))
                    {
                        return true;
                    }
                    
                    tmpf = obj->Position[0] + obj->Obj->Box[(k * 4) + 2];
                    if ((tmpf > (car->Position[0] + car->Obj.Box[0]) && tmpf < (car->Position[0] + car->Obj.Box[2])) || (tmpf > (car->Position[0] + car->Obj.Box[2]) && tmpf < (car->Position[0] + car->Obj.Box[0])))
                    {
                        return true;
                    }
                }
                tmpf = obj->Position[1] - obj->Obj->Box[(k * 4) + 3];
                if ((tmpf > (car->Position[1] - car->Obj.Box[1]) && tmpf < (car->Position[1] - car->Obj.Box[3])) || (tmpf > (car->Position[1] - car->Obj.Box[3]) && tmpf < (car->Position[1] - car->Obj.Box[1])))
                {
                    tmpf = obj->Position[0] + obj->Obj->Box[k * 4];
                    if ((tmpf > (car->Position[0] + car->Obj.Box[0]) && tmpf < (car->Position[0] + car->Obj.Box[2])) || (tmpf > (car->Position[0] + car->Obj.Box[2]) && tmpf < (car->Position[0] + car->Obj.Box[0])))
                    {
                        return true;
                    }
                    
                    tmpf = obj->Position[0] + obj->Obj->Box[(k * 4) + 2];
                    if ((tmpf > (car->Position[0] + car->Obj.Box[0]) && tmpf < (car->Position[0] + car->Obj.Box[2])) || (tmpf > (car->Position[0] + car->Obj.Box[2]) && tmpf < (car->Position[0] + car->Obj.Box[0])))
                    {
                        return true;
                    }
                }

            }
            else
            {
                break;
            }
        }
    }
    return false;
}

-(BOOL)Coin_Bounce : (struct CoinDraw*)obj : (struct ObjectCar*)car
{
    if (car->Obj.Box_Count > 1)
    {
        if (obj->Obj->Box_Count > 1)
        {
            tmpf = obj->Position[1] - obj->Obj->Box[1];
            if ((tmpf > (car->Position[1] - car->Obj.Box[1]) && tmpf < (car->Position[1] - car->Obj.Box[3])) || (tmpf > (car->Position[1] - car->Obj.Box[3]) && tmpf < (car->Position[1] - car->Obj.Box[1])))
            {
                tmpf = obj->Position[0] + obj->Obj->Box[0];
                if ((tmpf > (car->Position[0] + car->Obj.Box[0]) && tmpf < (car->Position[0] + car->Obj.Box[2])) || (tmpf > (car->Position[0] + car->Obj.Box[2]) && tmpf < (car->Position[0] + car->Obj.Box[0])))
                {
                    return true;
                }
                
                tmpf = obj->Position[0] + obj->Obj->Box[2];
                if ((tmpf > (car->Position[0] + car->Obj.Box[0]) && tmpf < (car->Position[0] + car->Obj.Box[2])) || (tmpf > (car->Position[0] + car->Obj.Box[2]) && tmpf < (car->Position[0] + car->Obj.Box[0])))
                {
                    return true;
                }
            }
            tmpf = obj->Position[1] - obj->Obj->Box[3];
            if ((tmpf > (car->Position[1] - car->Obj.Box[1]) && tmpf < (car->Position[1] - car->Obj.Box[3])) || (tmpf > (car->Position[1] - car->Obj.Box[3]) && tmpf < (car->Position[1] - car->Obj.Box[1])))
            {
                tmpf = obj->Position[0] + obj->Obj->Box[0];
                if ((tmpf > (car->Position[0] + car->Obj.Box[0]) && tmpf < (car->Position[0] + car->Obj.Box[2])) || (tmpf > (car->Position[0] + car->Obj.Box[2]) && tmpf < (car->Position[0] + car->Obj.Box[0])))
                {
                    return true;
                }
                
                tmpf = obj->Position[0] + obj->Obj->Box[2];
                if ((tmpf > (car->Position[0] + car->Obj.Box[0]) && tmpf < (car->Position[0] + car->Obj.Box[2])) || (tmpf > (car->Position[0] + car->Obj.Box[2]) && tmpf < (car->Position[0] + car->Obj.Box[0])))
                {
                    return true;
                }
            }
        }
    }
    return false;
}

-(BOOL)Bonus_Bounce : (struct BonusDraw*)obj : (struct ObjectCar*)car
{
    if (car->Obj.Box_Count > 1)
    {
        if (obj->Obj->Box_Count > 1)
        {
            tmpf = obj->Position[1] - obj->Obj->Box[1];
            if ((tmpf > (car->Position[1] - car->Obj.Box[1]) && tmpf < (car->Position[1] - car->Obj.Box[3])) || (tmpf > (car->Position[1] - car->Obj.Box[3]) && tmpf < (car->Position[1] - car->Obj.Box[1])))
            {
                tmpf = obj->Position[0] + obj->Obj->Box[0];
                if ((tmpf > (car->Position[0] + car->Obj.Box[0]) && tmpf < (car->Position[0] + car->Obj.Box[2])) || (tmpf > (car->Position[0] + car->Obj.Box[2]) && tmpf < (car->Position[0] + car->Obj.Box[0])))
                {
                    return true;
                }
                
                tmpf = obj->Position[0] + obj->Obj->Box[2];
                if ((tmpf > (car->Position[0] + car->Obj.Box[0]) && tmpf < (car->Position[0] + car->Obj.Box[2])) || (tmpf > (car->Position[0] + car->Obj.Box[2]) && tmpf < (car->Position[0] + car->Obj.Box[0])))
                {
                    return true;
                }
            }
            tmpf = obj->Position[1] - obj->Obj->Box[3];
            if ((tmpf > (car->Position[1] - car->Obj.Box[1]) && tmpf < (car->Position[1] - car->Obj.Box[3])) || (tmpf > (car->Position[1] - car->Obj.Box[3]) && tmpf < (car->Position[1] - car->Obj.Box[1])))
            {
                tmpf = obj->Position[0] + obj->Obj->Box[0];
                if ((tmpf > (car->Position[0] + car->Obj.Box[0]) && tmpf < (car->Position[0] + car->Obj.Box[2])) || (tmpf > (car->Position[0] + car->Obj.Box[2]) && tmpf < (car->Position[0] + car->Obj.Box[0])))
                {
                    return true;
                }
                
                tmpf = obj->Position[0] + obj->Obj->Box[2];
                if ((tmpf > (car->Position[0] + car->Obj.Box[0]) && tmpf < (car->Position[0] + car->Obj.Box[2])) || (tmpf > (car->Position[0] + car->Obj.Box[2]) && tmpf < (car->Position[0] + car->Obj.Box[0])))
                {
                    return true;
                }
            }
        }
    }
    return false;
}

-(void)Change_Smooth : (float*)dst : (float)src : (float)spd
{
    if (src != *dst)
    {
        if (*dst < src)
        {
            *dst += Game_Data->timeSinceLastUpdate * spd;
            if (*dst > src)
            {
                *dst = src;
            }
        }
        else
        {
            *dst -= Game_Data->timeSinceLastUpdate * spd;
            if (*dst < src)
            {
                *dst = src;
            }
        }
    }
}

-(bool)Timer : (float*)time
{
    if (*time > 0)
    {
        *time -= Game_Data->timeSinceLastUpdate;
        if (*time < 0) *time = 0;
    }
    else
    {
        *time = 0;
        return true;
    }
    return false;
}

-(void)Check_Data
{
    tmpi = 0;
    for (i = 0; i < Game_Data->World_Num[Game_Data->Set_World]; i++)
    {
        tmpb = true;
        if (i == 0)
        {
            Game_Data->Level_Data[i].Enable = true;
            tmpb = false;
        }
        else
        {
            if (Game_Data->Level_Data[i].Score[0] >= LEVEL_ENABLE_0)
            {
                Game_Data->Level_Data[i].Enable = true;
                tmpb = false;
            }
            else if (Game_Data->Level_Data[i].Score[1] >= LEVEL_ENABLE_1)
            {
                Game_Data->Level_Data[i].Enable = true;
                tmpb = false;
            }
            else if (Game_Data->Level_Data[i - 1].Enable && (Game_Data->Level_Data[i - 1].Score[0] >= LEVEL_ENABLE_0) && tmpi == 0)
            {
                Game_Data->Level_Data[i].Enable = true;
                tmpb = false;
            }
            else if (Game_Data->Level_Data[i - 1].Enable && (Game_Data->Level_Data[i - 1].Score[1] >= LEVEL_ENABLE_1) && tmpi == 0)
            {
                Game_Data->Level_Data[i].Enable = true;
                tmpb = false;
            }
        }
        if (tmpb)
        {
            Game_Data->Level_Data[i].Enable = false;
            tmpi = 1;
        }
    }
}

-(void)Reset_Data
{
    Game_Data->Set_World = 0;
    Game_Data->Set_Color = 0;
    Game_Data->Set_Con = 0;
    Game_Data->Set_Dif = 0;
    Game_Data->Set_Sound = 0;
    
    if (Game_Data->Level_Data)
        free(Game_Data->Level_Data);
    
    Game_Data->Level_Data = malloc(sizeof(*Game_Data->Level_Data) * Game_Data->World_Num[Game_Data->Set_World]);
    
    for (i = 0; i < Game_Data->World_Num[Game_Data->Set_World]; i++)
    {
        Game_Data->Level_Data[i].Used = false;
        Game_Data->Level_Data[i].Score[0] = 0;
        Game_Data->Level_Data[i].Score[1] = 0;
    }
}

-(NSString *)saveFilePath : (int) type
{
	NSArray *path_a =	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if (type == 0)
    {
            return [[path_a objectAtIndex:0] stringByAppendingPathComponent:@"ATW_savefile_set.plist"];
    }
    else
    {
        return [[path_a objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"ATW_savefile_%d.plist", (type - 1)]];
    }
}

-(void)Save_Data : (int)type
{
    if (type == 0 || type > 1)
    {
        NSString *tmps_a[10];
        
        //Запись ID сохранения
        tmps_a[0] = [NSString stringWithFormat:@"%d", Game_Data->firm_id];
        
        //Запись активности звука
        tmps_a[1] = [NSString stringWithFormat:@"%d", Game_Data->Set_Sound];
        tmps_a[2] = [NSString stringWithFormat:@"%d", Game_Data->Set_Color];
        tmps_a[3] = [NSString stringWithFormat:@"%d", Game_Data->Set_Con];
        tmps_a[4] = [NSString stringWithFormat:@"%d", Game_Data->Set_Dif];
        tmps_a[5] = [NSString stringWithFormat:@"%d", Game_Data->Set_World];
        
        //Запись резервных переменных
        for (i = 6; i < 10; i++)
            tmps_a[i] = @"0";
        
        NSArray *values = [NSArray arrayWithObjects:tmps_a count:10];
        [values writeToFile:[self saveFilePath : 0] atomically:YES];
    }
    
    if (type > 0)
    {
        NSString *tmps_a[20 * 3];
        
        for (i = 0; i < Game_Data->World_Num[Game_Data->Set_World]; i++)
        {
            tmps_a[i * 3] = [NSString stringWithFormat:@"%d", (int)Game_Data->Level_Data[i].Used];
            tmps_a[(i * 3) + 1] = [NSString stringWithFormat:@"%d", Game_Data->Level_Data[i].Score[0]];
            tmps_a[(i * 3) + 2] = [NSString stringWithFormat:@"%d", Game_Data->Level_Data[i].Score[1]];
        }
        
        //Запись резервных переменных
        for (i = (Game_Data->World_Num[Game_Data->Set_World] * 3); i < (20 * 3); i++)
            tmps_a[i] = @"0";
        
        NSArray *values = [NSArray arrayWithObjects:tmps_a count:(20 * 3)];
        [values writeToFile:[self saveFilePath : (Game_Data->Set_World + 1)] atomically:YES];
    }
}

-(bool)Load_Data
{
    NSString *myPath;
    BOOL fileExists;
    NSArray *values;
    myPath = [self saveFilePath : 0];
    fileExists = [[NSFileManager defaultManager] fileExistsAtPath:myPath];
    
    if (fileExists)
    {
        values = [[NSArray alloc] initWithContentsOfFile:myPath];
        
        //Проверка ID сохранения
        if ([[values objectAtIndex:0] integerValue] != Game_Data->firm_id)
        {
            [values release];
            return false;
        }
        
        Game_Data->Set_Sound = [[values objectAtIndex:1] integerValue];
        Game_Data->Set_Color = [[values objectAtIndex:2] integerValue];
        Game_Data->Set_Con = [[values objectAtIndex:3] integerValue];
        Game_Data->Set_Dif = [[values objectAtIndex:4] integerValue];
        Game_Data->Set_World = [[values objectAtIndex:5] integerValue];
        
        
        [values release];
    }
    
    myPath = [self saveFilePath : (Game_Data->Set_World + 1)];
    fileExists = [[NSFileManager defaultManager] fileExistsAtPath:myPath];
    if (fileExists)
    {
        values = [[NSArray alloc] initWithContentsOfFile:myPath];
        
        for (i = 0; i < Game_Data->World_Num[Game_Data->Set_World]; i++)
        {
            if ([[values objectAtIndex:(i * 3)] integerValue] > 0)
                Game_Data->Level_Data[i].Used = true;
            else
                Game_Data->Level_Data[i].Used = false;
            
            Game_Data->Level_Data[i].Score[0] = [[values objectAtIndex:((i * 3) + 1)] integerValue];
            Game_Data->Level_Data[i].Score[1] = [[values objectAtIndex:((i * 3) + 2)] integerValue];
        }
        
        [values release];
    }
    return false;
}

@end