//
//  ChoBaseAccesser.m
//  jp.AncouApp.iChoBase
//
//  Created by Takenori Hirao on 2012/03/20.
//  Copyright 2012 AncouApp All rights reserved.
//

#import "ChoBaseAccesser.h"

#define QueryFindByID @"select KvsValue from ChoBase where KvsKey = :KvsKey"
#define QueryScanByID @"select KvsValue from ChoBase where KvsKey like :KvsKey order by KvsKey {0}"
#define QueryCountByKey @"select count(KvsValue) from ChoBase where KvsKey like :KvsKey"
#define QuerySelectTableName @"SELECT count(*) FROM SQLITE_MASTER WHERE TYPE ='table' AND NAME = '{0}'"

@implementation ChoBaseAccesser

@synthesize fileName;
@synthesize tableName;
@synthesize nameSpace;
@synthesize db;


- (id)init
{
    self = [super init];
    if (self) {
        [self setFileName:@"chobase.sqlite3"];
        [self setTableName:@"ChoBase"];
        [self setNameSpace:@"ChoBase"];
        
        //create and open db
        NSArray *pathes = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dir = [pathes objectAtIndex:0];
        NSString *path = [dir stringByAppendingPathComponent:fileName];
        
        //check file had exists
        //NSFileManager *fileManager = [NSFileManager defaultManager];
        //bool hasFile =[fileManager fileExistsAtPath:path];
        
        //create connection
        [self setDb:[FMDatabase databaseWithPath:path]];
        if (![db open]) {
            @throw [NSException exceptionWithName:@"DBOpenException" reason:@"couldn't open specified db dile" userInfo:nil];
        }
        
        //create table. if table not exist
        if (![db tableExists:self.tableName]) {
            NSString* sql1 = [NSString stringWithFormat:
                             @"create table %@ ( "
                             "  namespace text not null,"
                             "  cbkey text not null,"
                             "  cbvalue text not null,"
                             "  updated numeric not null)"
                             , self.tableName];
            bool isSuccess = [db executeUpdate:sql1];
            NSLog(@"To create table has Successed %d" , isSuccess);
            
            //create uniqu index
            NSString* sql_index = [NSString stringWithFormat:
                                   @"create unique index uk1 on %@ (namespace , cbkey)" 
                                   , self.tableName];
            bool isSuccessIndex = [db executeUpdate:sql_index];
            NSLog(@"To create index has Successed %d" , isSuccessIndex);
        
        }    
    }
    return self;
}

-(void)selectAll{
    NSLog(@"Do Select ALL!");
    FMResultSet *result = [db executeQuery:@"SELECT * FROM chobase"];
    while ([result next]) {
        NSLog(@"cols >> %@,%@,%@", [result stringForColumnIndex:0],[result stringForColumnIndex:1],[result stringForColumnIndex:2]);
    }
    
}

// keyで取得する
-(bool)isExist:(NSString*)key
{
    NSString *sql = [NSString stringWithFormat:@"SELECT cbvalue FROM %@ WHERE namespace = ? and cbKey = ?" , self.tableName];
    FMResultSet *result = [db executeQuery:sql , self.nameSpace , key];
    bool rtn;
    if ([result next]) {
        rtn = true;
    }else{
        rtn = false;
    }
    [result close];
    return rtn;
}

// keyで取得する
-(NSString *)find:(NSString*)key
{
    NSString *sql = [NSString stringWithFormat:@"SELECT cbvalue FROM %@ WHERE namespace = ? and cbKey = ?" , self.tableName];
    FMResultSet *result = [db executeQuery:sql , self.nameSpace , key];
    NSString* val = nil;
    if ([result next]) {
        val = [result stringForColumnIndex:0];
    }else{
        @throw [NSException exceptionWithName:@"ChoBase_KeyIsNotFoundException" 
                                       reason:[NSString stringWithFormat:@"key is not found : %@",key] 
                                     userInfo:nil];
    }
    [result close];
    return val;
}

-(NSMutableArray *)scan:(NSString*)key
{
    NSString *sql = [NSString stringWithFormat:@"SELECT cbvalue FROM %@ WHERE namespace = ? and cbKey like ?" , self.tableName];
    NSString *key_p =  [NSString stringWithFormat:@"%@%%" , key];
    FMResultSet *result = [db executeQuery:sql , self.nameSpace , key_p];
    NSMutableArray *rtn = [NSMutableArray array];
    while ([result next]) {
        NSString* val = [result stringForColumnIndex:0];
        [rtn addObject:val];
    }
    [result close];
    return rtn;
}

//scan by key. get key and balue
-(NSMutableArray *)scanEntity:(NSString*)key
{
    NSString *sql = [NSString stringWithFormat:@"SELECT cbkey , cbvalue FROM %@ WHERE namespace = ? and cbKey like ?" , self.tableName];
    NSString *key_p =  [NSString stringWithFormat:@"%@%%" , key];
    FMResultSet *result = [db executeQuery:sql , self.nameSpace , key_p];
    NSMutableArray *rtn = [NSMutableArray array];
    while ([result next]) {
        ChoBaseEntity *entity = [ChoBaseEntity new];
        entity.Key = [result stringForColumnIndex:0];
        entity.Val = [result stringForColumnIndex:1];
        [rtn addObject:entity];
    }
    [result close];
    return rtn;
}

#define QueryReplace @"insert or update into ChoBase (KvsKey,KvsValue,updated) values (:KvsKey,:KvsValue,current_timestamp)"
//create or update
-(bool)save:(NSString*)val key:(NSString*)key{
    
    NSString* sql = [NSString stringWithFormat:@"replace into %@ (namespace,cbkey,cbvalue,updated) values (?,?,?,?)" ,
                     self.tableName] ;
    long long int unixtime = (long long int)[[NSDate date] timeIntervalSince1970];
    bool result = [db executeUpdate:sql , self.nameSpace , key , val , [NSNumber numberWithLongLong:unixtime]];
    return result;
}

//delete by key
-(bool)del:(NSString*)key{
    
    NSString* sql = [NSString stringWithFormat:@"delete from %@  where namespace = ? and cbkey = ?" ,
                     self.tableName] ;
    bool result = [db executeUpdate:sql , self.nameSpace , key];
    return result;
}

@end
