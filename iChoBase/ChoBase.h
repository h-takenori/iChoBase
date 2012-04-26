//
//  ChoBase.h
//  jp.AncouApp.iChoBase
//
//  Created by Takenori Hirao on 2012/03/20.
//  Copyright 2012 AncouApp All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChoBaseAccesser.h"
#include "ChoBaseEntity.h"

@interface ChoBase : NSObject{
    ChoBaseAccesser* _accesser;
}

//Get ChoBase singleton instance;
+ (ChoBase*) cb;

-(bool)hasKey:(NSString*)key;

//get by key as nsstring
-(NSString*)s:(NSString*)key;
-(int)i:(NSString*)key;
-(CGPoint)cgPoint:(NSString*)key;
-(NSMutableArray*) array:(NSString*)key separator:(NSString*)separator;
-(NSMutableArray*) scanS:(NSString*)key;
-(NSMutableArray*) scanRecord:(NSString*)key;

//set value with value
-(bool)setS:(NSString*)val key_s:(NSString*)key;
-(bool)setI:(int)val key_s:(NSString*)key;
-(bool)setCgPoint:(CGPoint)val key_s:(NSString*)key;

//delete
-(bool)del:(NSString*)val;

@end

//chobaseSingletonInstance
ChoBase* g_chobaseInstance;