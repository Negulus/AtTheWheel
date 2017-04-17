//
//  ViewController.h
//  At the Wheel
//
//  Created by Negulus on 4/12/13.
//  Copyright (c) 2013 Negulus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

#import "game.h"
#import "level.h"
#import "play.h"
#import "menumain.h"
#import "menuset.h"
#import "menuselect.h"
#import "menuthank.h"
#import "menuhelp.h"
#import "newgame.h"
#import "AppDelegate.h"

@interface ViewController : GLKViewController
{
    AppDelegate *appDelegate;
    
    //Структура основных данных
    struct GameData Game_Data;
    
    //Игровые классы
    Game *Game_Root;
    GamePlay *Game_Play;
    MenuMain *Menu_Main;
    MenuSet *Menu_Set;
    MenuSelect *Menu_Select;
    MenuThank *Menu_Thank;
    MenuHelp *Menu_Help;
    NewGame *New_Game;
    
    //Системные переменные
    int i;
    int tmpi;
    float tmpf;
    bool Game_Start;
}

-(void)GameInit;
@end
