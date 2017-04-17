//
//  At the Wheel
//
//  Created by Negulus on 4/12/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#import "level.h"

@implementation GameLevel
-(id)init : (struct GameData*)data
{
    self = [super init : data];
    if (self)
    {
        //Данные уровня
        Sector_Count = 0;
        Object_Count = 0;
        Object_All_Count = 0;
        Coin_Count = 0;
        Bonus_Count = 0;
        i_level = 0;
        tmpui_level = 0;
        Car_Position = 35;
        
        //Загрузка уровня из файла
        [self Load];
        [self Reset];
    }
    return self;
}

-(void)Reset
{
    self->Angle = 0;
    self->Angle_Full = 0;
    self->Point = 0;
    self->Angle_Full = 45 * (self->Point - 1);
    
    for (tmpui = 0; tmpui < Coin_Count; tmpui++)
    {
        Coins[tmpui].Angle = 0;
        Coins[tmpui].Turn_Speed = 150 + (((double)rand() / (double)RAND_MAX) * 150.0f);
        Coins[tmpui].Touch = false;
        Coins[tmpui].Effect = 0;
    }
    
    for (tmpui = 0; tmpui < Bonus_Count; tmpui++)
    {
        Bonus[tmpui].Angle = 0;
        Bonus[tmpui].Turn_Speed = 150 + (((double)rand() / (double)RAND_MAX) * 150.0f);
        Bonus[tmpui].Touch = false;
    }
}

//Загрузка уровня
-(void)Load
{
    path_l = [[NSBundle mainBundle] bundlePath];
    
    if (Game_Data->Level < Game_Data->World_Num[Game_Data->Set_World])
        xmlPath_l = [path_l stringByAppendingPathComponent:[NSString stringWithFormat: @"level_%d.txt", (Game_Data->Level + 1)]];
    else
        xmlPath_l = [path_l stringByAppendingPathComponent:[NSString stringWithFormat: @"level_1.txt"]];
    
    fileString_l = [NSString stringWithContentsOfFile:xmlPath_l encoding:NSUTF8StringEncoding error:nil];
    lines_l = [fileString_l componentsSeparatedByString:@"\r\n"]; 
    
    str_l = [lines_l[0] componentsSeparatedByString:@" "];
    Sector_Count = [str_l[0] intValue];
    Sectors = malloc(sizeof(*Sectors) * Sector_Count);    
    Object_Count = [str_l[1] intValue];
    Objects = malloc(sizeof(*Objects) * Object_Count);
    Object_All_Count = [str_l[2] intValue];
    Object_All = malloc(sizeof(*Object_All) * Object_All_Count);
    Coin_Count = [str_l[3] intValue];
    Coins = malloc(sizeof(*Coins) * Coin_Count);
    Bonus_Count = [str_l[4] intValue];
    Bonus = malloc(sizeof(*Bonus) * Bonus_Count);
    
    Car_Position = [str_l[5] intValue];
    
    for (i = 0; i < Sector_Count; i++)
    {
        Sectors[i].Surface[0] = 0;
        Sectors[i].Surface[1] = 0;
        Sectors[i].Surface[2] = 0;
        Sectors[i].Surface[3] = 0;
        Sectors[i].Surface[4] = 0;
        Sectors[i].Surface[5] = 0;
        Sectors[i].Type[0] = 0;
        Sectors[i].Type[1] = 0;
        Sectors[i].Type[2] = 0;
        Sectors[i].Type[3] = 0;
        Sectors[i].Type[4] = 0;
        Sectors[i].Type[5] = 0;
        Sectors[i].Texture[0] = 0;
        Sectors[i].Texture[1] = 0;
        Sectors[i].Texture[2] = 0;
        Sectors[i].Texture[3] = 0;
        Sectors[i].Texture[4] = 0;
        Sectors[i].Texture[5] = 0;
    }
    
    tmpui_level = 0;
    str_l = [lines_l[1] componentsSeparatedByString:@" "];
    for (i_level = 0; i_level < Object_All_Count; i_level++)
    {
        if ([str_l[i_level] length] > 0)
        {
            [self Load_Object: &Object_All[tmpui_level] : str_l[i_level]];
            tmpui_level++;
        }
        else
        {
            break;
        }
    }

    i = 3;
    j = 0;
    tmpi = 0;
    tmpui = 0;
    tmpb = true;
    while (tmpb)
    {
        if (i < lines_l.count)
        {
            if (tmpi >= Sector_Count)
            {
                tmpb = false;
            }
            else if ([lines_l[i] isEqualToString: @"Object"])
            {
                tmpb = false;
            }
            else
            {
                str_l = [lines_l[i] componentsSeparatedByString:@" "];
                if ([str_l[0] intValue] != tmpi)
                {
                    tmpi = [str_l[0] intValue];
                    tmpui = 0;
                }
                Sectors[tmpi].Surface[tmpui] = [str_l[1] intValue];
                Sectors[tmpi].Texture[tmpui] = [str_l[2] intValue];
                Sectors[tmpi].Type[tmpui] = [str_l[3] intValue];
                tmpui++;
                j++;
            }
        }
        else
            tmpb = false;
        i++;
    }
    
    tmpui = 0;
    tmpb = true;
    while (tmpb)
    {
        if (i < lines_l.count)
        {
            if (tmpui >= Object_Count)
            {
                tmpb = false;
            }
            else if ([lines_l[i] isEqualToString: @"Coin"])
            {
                tmpb = false;
            }
            else
            {
                str_l = [lines_l[i] componentsSeparatedByString:@" "];
                Objects[tmpui].Num = [str_l[0] intValue];
                Objects[tmpui].Type = [str_l[1] intValue];
                Objects[tmpui].Position[0] = [str_l[2] intValue];
                Objects[tmpui].Position[1] = [str_l[3] intValue];
                Objects[tmpui].Rotation = [str_l[4] intValue];
                Objects[tmpui].Enable = true;
                tmpui++;
            }
        }
        else
            tmpb = false;
        i++;
    }
    
    tmpui = 0;
    tmpb = true;
    while (tmpb)
    {
        if (i < lines_l.count)
        {
            if (tmpui >= Coin_Count)
            {
                tmpb = false;
            }
            else if ([lines_l[i] isEqualToString: @"Bonus"])
            {
                tmpb = false;
            }
            else
            {
                str_l = [lines_l[i] componentsSeparatedByString:@" "];
                Coins[tmpui].Position[0] = [str_l[0] intValue];
                Coins[tmpui].Position[1] = [str_l[1] intValue];
                tmpui++;
            }
        }
        else
            tmpb = false;
        i++;
    }
    
    tmpui = 0;
    tmpb = true;
    while (tmpb)
    {
        if (i < lines_l.count)
        {
            if (tmpui >= Bonus_Count)
            {
                tmpb = false;
            }
            else if ([lines_l[i] isEqualToString: @"End"])
            {
                tmpb = false;
            }
            else
            {
                str_l = [lines_l[i] componentsSeparatedByString:@" "];
                Bonus[tmpui].Type = [str_l[0] intValue];
                Bonus[tmpui].Position[0] = [str_l[1] intValue];
                Bonus[tmpui].Position[1] = [str_l[2] intValue];
                tmpui++;
            }
        }
        else
            tmpb = false;
        i++;
    }
}

-(void)dealloc
{
    /*
    //Данные уровня
    free(Sectors);
    free(Objects);
    free(Coins);
    free(Bonus);
    free(Object_All);

//    NSString *path;
//    NSString *xmlPath;
//    NSString *fileString;
    free(lines);
    free(str);
    */
    [super dealloc];
}
@end
