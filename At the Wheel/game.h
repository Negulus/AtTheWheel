//
//  game.h
//  At the Wheel
//
//  Created by Negulus on 4/12/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#ifndef At_the_Wheel_game_h
#define At_the_Wheel_game_h

#import <GLKit/GLKit.h>

#define BUFFER_OFFSET(i) ((char *)NULL + (i))
#define BONUS_X2_TIME       5.0f
#define BONUS_X4_TIME       5.0f
#define BONUS_IDDQD_TIME    5.0f
#define BONUS_FAST_TIME     5.0f
#define SECTOR_TIME         1.4f
#define COINS_SECOND        2.0f
#define BONUS_SCREEN_TIME   1.0f
#define LEVEL_ENABLE_0      50
#define LEVEL_ENABLE_1      50

enum Stats
{
    Stat_Null,
    Stat_MenuMain,
    Stat_MenuSelect,
    Stat_MenuSet,
    Stat_MenuThank,
    Stat_MenuHelp,
    Stat_Start,
    Stat_Play,
    Stat_Win,
    Stat_Lose,
    Stat_Pause,
    Stat_Next,
    Stat_Resume,
    Stat_Restart,
    Stat_NewGame
};

//Структура разных поверхностей дороги
struct Road_Surface
{
    GLfloat *Vertex;
    GLuint Array;
    GLuint Buffer;
};

//Структура секторов
struct SectorDraw
{
    struct Road_Surface *Surface[6];
    int Texture[6];
    int Texture_Wall[2];
    bool Enable[6];
    int Type[6];
    int Surf[6];
    GLKMatrix4 Matrix;
};

struct LevelObject
{
    int Num;
    int Type;
    bool Enable;
    GLfloat Position[2];
    GLfloat Rotation;
};

struct ObjectDraw
{
    struct LevelObject *Object;
    struct Object *Obj;
    float Position[2];
    float Rotation;
    GLKMatrix4 Matrix;
    bool Enable;
};

struct LevelCoin
{
    GLfloat Position[2];
    float Turn_Speed;
    float Angle;
    bool Touch;
    float Effect;
};

struct CoinDraw
{
    struct Object *Obj;
    struct LevelCoin *Coin;
    float Position[3];
    GLKMatrix4 Matrix;
    bool Enable;
};

struct LevelBonus
{
    int Type;
    GLfloat Position[2];
    float Turn_Speed;
    float Angle;
    bool Touch;
};

struct BonusDraw
{
    struct Object *Obj;
    struct LevelBonus *Bonus;
    float Position[2];
    GLKMatrix4 Matrix;
    bool Enable;
};

//Структура объектов
struct Object
{
    GLfloat *Vertex;
    GLfloat *Box;
    GLuint Vertex_Count;
    GLuint Box_Count;
    GLuint Array;
    GLuint Buffer;
    GLuint Texture;
};

struct Object2D
{
    GLuint Texture;
    float Vertex[8];
    float Position[2];
};

struct Object2DDigit
{
    GLuint Texture[10];
    float Vertex[8];
    float Position[2];
    float Relative[2];
};

struct ObjectCar
{
    struct Object Obj;
    float Position[2];
    float Turn_Angle;
    GLKMatrix4 Matrix;
    int Shake_Stat;
    float Shake_Max;
    float Shake;
    
    struct Object Tire;
    float Tire_Angle;
    GLKMatrix4 Tire_Matrix[4];
};

struct LevelData
{
    float Position[2];
    int Score[2];
    bool Used;
    bool Enable;
    bool Select;
};

struct TouchMove {
    int touch_id;
    float tmp;
};

struct TimeSys
{
    double Time_Total;
    double Time_Elapsed;
    double Time_Last;
};

struct GameData
{
    //Переменные графики
    GLKMatrix4 CameraMatrix;
    GLKMatrix4 HUDMatrix;
    GLKMatrix4 ViewMatrix3D;
    GLKMatrix4 ViewMatrix2D;
    GLKMatrix4 ViewMatrixTmp;
    GLKBaseEffect *effect;
    GLuint Array_2D;
    GLuint BufferPos_2D;
    GLuint BufferTex_2D;
    GLuint BufferCol_2D;
    GLKView *view;
    
    //Экран загрузки
    struct Object2D Loading;
    int Status_Next_tmp;
    bool Status_Next_en;
    
    //Данные уровней
    int World_Num[3];
    int Worlds;
    struct LevelData *Level_Data;
    int Score_Calc;
    int Level;
    
    //Данные игры
    int Score;
    int Life;
    float Level_Passed;
    int firm_id;
    bool light;
    
    //Бонусы
    bool Bonus_x2;
    float Bonus_x2_Time;
    bool Bonus_x4;
    float Bonus_x4_Time;
    bool Bonus_Fast;
    float Bonus_Fast_Time;
    bool Bonus_IDDQD;
    float Bonus_IDDQD_Time;
    
    //Настройки
    int Set_Dif;
    int Set_Con;
    int Set_Sound;
    int Set_Color;
    int Set_World;
    
    //Таймеры
    float timeSinceLastUpdate;

    //Статусы
    int Status_Curent;
    int Status_Next;
    
    //Положения в меню
    int Menu_Main_Pos;
    int Menu_Sel_Pos;
    
    float Accel[3];
    int Game_Width;
    int Game_Center;
};

@interface Game : NSObject
{
    //Переменные для графики
    GLuint Texture_Error;
    float Vertex_BG[8];
    float Vertex_Tex_Full[8];
    float Vertex_Col_Full[16];
    float Vertex_Col_tmp[16];
    
    struct GameData *Game_Data;
    
    UITouch *touch;
    CGPoint location;
    
    int i;
    int j;
    int k;
    int tmpi;
    unsigned int tmpui;
    long tmpl;
    bool tmpb;
    float tmpf;
    double tmpd;
    GLKVector2 Vector_tmp;
    
    NSString *path;
    NSString *xmlPath;
    NSString *fileString;
    NSArray *lines;
    NSArray *str;
    NSString *tmps;
}

-(id)init : (struct GameData*)data;
-(void)Load_Object : (struct Object*)obj : (NSString*)name;
-(GLuint)Load_Texture : (NSString*)name;
-(float)Vector_Length : (float)x : (float)y;
-(int)On_Road : (struct SectorDraw*)obj : (struct ObjectCar*)car : (float)angle;
-(BOOL)Car_Bounce : (struct ObjectDraw*)obj : (struct ObjectCar*)car;
-(BOOL)Coin_Bounce : (struct CoinDraw*)obj : (struct ObjectCar*)car;
-(BOOL)Bonus_Bounce : (struct BonusDraw*)obj : (struct ObjectCar*)car;
-(void)CreateObject2D : (struct Object2D*)obj : (float)x : (float)y : (float)wdth : (float)hght : (GLuint)text;
-(void)CreateObject2DDigit : (struct Object2DDigit*)obj : (float)x : (float)y : (float)wdth : (float)hght : (float) r_x : (float) r_y;
-(void)DrawObject2D : (struct Object2D*)obj;
-(void)DrawObject2DDigit : (struct Object2DDigit*)obj : (int) count : (int)num;
-(void)Change_Smooth : (float*)dst : (float)src : (float)spd;
-(bool)Timer : (float*)time;
-(bool)Location_Touched : (float)x : (float)y : (float)p_x : (float)p_y : (int)wdth : (int)hght;
-(void)Check_Data;
-(void)Reset_Data;
-(void)Save_Data : (int)type;
-(bool)Load_Data;
-(void)BindBuffer2D : (float*)buf_pos : (float*)buf_tex : (float*)buf_col;
@end

#endif
