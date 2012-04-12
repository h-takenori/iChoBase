//
//  ChoBase.m
//  jp.AncouApp.iChoBase
//
//  Created by Takenori Hirao on 2012/03/20.
//  Copyright 2012 AncouApp All rights reserved.
//

#import "ChoBase.h"

@implementation ChoBase


+ (ChoBase*) cb{
    if(g_chobaseInstance == nil)
    {
        g_chobaseInstance = [[ChoBase new] retain];
    }
    return g_chobaseInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _accesser = [[[ChoBaseAccesser new]autorelease]retain];
    }      
    return self;
}

//public methods ========================================================

-(bool)hasKey:(NSString*)key{
    return [_accesser isExist:key];
}

-(NSString*)s:(NSString*)key
{
    return [_accesser find:key];
}

-(int)i:(NSString*)key{
    return [[self s:key]intValue];
}

-(CGPoint)cgPoint:(NSString*)key{
    NSString* val = [self s:key];
    NSArray* splited = [val componentsSeparatedByString:@","];
    CGPoint rtn = CGPointMake([[splited objectAtIndex:0]floatValue], [[splited objectAtIndex:1]floatValue]);
    return rtn;
}


-(NSMutableArray*) array:(NSString*)key separator:(NSString*) separator
{
	NSString *str = [self s:key];
	NSMutableArray *rtn = [NSMutableArray array];
    
    NSRange range;
    while((range = [str rangeOfString:separator]).length > 0)
    {
        NSString *addStr = [str substringWithRange:NSMakeRange(0,range.location)] ;
        [rtn addObject:addStr];
        int splitRange = range.location + range.length;
        str = [str substringWithRange:NSMakeRange(splitRange ,[str length]-splitRange)];
    }
    [rtn addObject:str];
        
	return rtn;
}

-(NSMutableArray*) scanS:(NSString*)key{
    return [_accesser scan:key];
}

//Setter methods ==========================================================
//set value with value
-(bool)setS:(NSString*)val key_s:(NSString*)key
{
    bool result = [_accesser save:val key:key];
    return result;
}

-(bool)setI:(int)val key_s:(NSString*)key{
    NSString* val_s = [NSString stringWithFormat:@"%d",val];
    return [self setS:val_s key_s:key];
}

-(bool)setCgPoint:(CGPoint)val key_s:(NSString*)key
{
    NSString* val_s = [NSString stringWithFormat:@"%f,%f",val.x , val.y];
    return [self setS:val_s key_s:key];
}

//Delete
-(bool)del:(NSString*)key{
    return [_accesser del:key];
}

@end
