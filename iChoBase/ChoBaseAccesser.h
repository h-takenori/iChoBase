//
//  ChoBase.h
//  jp.AncouApp.iChoBase
//
//  Created by Takenori Hirao on 2012/03/20.
//  Copyright 2012 AncouApp All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface ChoBaseAccesser : NSObject{
    NSString *fileName;
    NSString *tableName;
    NSString *nameSpace;
    FMDatabase *db;
}

@property (retain) NSString* fileName;
@property (retain) NSString* tableName;
@property (retain) NSString* nameSpace;
@property (retain) FMDatabase* db;

-(bool)isExist:(NSString*)key;
-(NSString *)find:(NSString*)key;
-(NSArray *)scan:(NSString*)key;
-(bool)save:(NSString*)val key:(NSString*)key;
-(bool)del:(NSString*)key;

@end
