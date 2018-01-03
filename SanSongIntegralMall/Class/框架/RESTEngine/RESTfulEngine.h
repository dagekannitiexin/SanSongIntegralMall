//
//  RESTfulEngine.h
//  traderen
//
//  Created by 林林尤达 on 2017/5/19.
//  Copyright © 2017年 林尤达. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RESTfulOperation.h"
#import "JSONModel.h"
#import "MKNetworkEngine.h"


typedef void (^VoidBlock)(void);
typedef void (^ModelBlock)(JSONModel* aModelBaseObject);
typedef void (^ArrayBlock)(NSMutableArray* listOfModelBaseObjects);
typedef void (^DictronaryBlock)(NSDictionary* aDictronaryBaseObjects);
typedef void (^ProgressBlock)(double progress);
typedef void (^ErrorBlock)(NSError* engineError);

@interface RESTfulEngine : MKNetworkEngine {
    NSString *_accessToken;
}

@property (nonatomic ,strong) NSString *accessToken;

- (id)sendRequesttoSSJF:(NSMutableDictionary *)requestInfo portPath:(NSString *)portPath  Method:(NSString*)method onSucceeded:(DictronaryBlock) succeededBlock
                onError:(ErrorBlock) errorBlock;

- (id)sendRequesttoWeiBo:(NSMutableDictionary *)requestInfo fileDate:(NSData*)fileData portPath:(NSString *)portPath onSucceeded:(DictronaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock;
@end
