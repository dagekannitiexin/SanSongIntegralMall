//
//  RESTfulEngine.m
//  traderen
//
//  Created by 林林尤达 on 2017/5/19.
//  Copyright © 2017年 林尤达. All rights reserved.
//

#import "RESTfulEngine.h"
#import "JSONKit.h"
#import "Base64.h"
//#import "ModelLocator.h"


@implementation RESTfulEngine

- (id)sendRequesttoSSJF:(NSMutableDictionary *)requestInfo portPath:(NSString *)portPath Method:(NSString *)method onSucceeded:(DictronaryBlock)succeededBlock onError:(ErrorBlock)errorBlock
{
    //检查网络的
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if(reach ==nil || !reach.isReachable){
        [SVProgressHUD showErrorWithStatus:kServiceErrorMessage];
        errorBlock(nil);
        return nil;
    }

    //简单的GET操作请求URL
    RESTfulOperation *op = (RESTfulOperation*) [self operationWithPath:portPath params:requestInfo httpMethod:method];
    op.stringEncoding = NSUTF8StringEncoding;

    [op addHeaders:[Utility getHttpHead]];
    
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@",completedOperation);

        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:[[op responseString] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        //如果无返回数据
        if (!responseDictionary)
        {
            errorBlock(nil);
            return ;
        }
        
        //有返回数据的情况下
        NSString *ret = [responseDictionary valueForKey:@"ReFlag"];
        if(ret){
            [SVProgressHUD dismiss];
            succeededBlock(responseDictionary);
            return;
        }
        
        
    } onError:^(NSError *error) {
        if(error.code == 404){
            [SVProgressHUD showErrorWithStatus: kRequestFailedMessage  ];
        }else{
            [SVProgressHUD showErrorWithStatus: kTimeOutMessage  ];
        }
        
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}


- (id)sendRequesttoWeiBo:(NSMutableDictionary *)requestInfo fileDate:(NSData*)fileData portPath:(NSString *)portPath onSucceeded:(DictronaryBlock) succeededBlock
                 onError:(ErrorBlock) errorBlock{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if(reach ==nil || !reach.isReachable){
        [SVProgressHUD showErrorWithStatus:kServiceErrorMessage];
        return nil;
    }
    
    RESTfulOperation *op = (RESTfulOperation*) [self operationWithPath:portPath params:requestInfo httpMethod:@"POST"];
    op.stringEncoding = NSUTF8StringEncoding;
    
    [op addData:fileData forKey:@"fileUp" mimeType:@"image/png" fileName:@"image.png"];
    NSLog(@"%@",[op description]);
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@",[op responseString]);
        
        NSDictionary *responseDictionary = [[op responseString]  objectFromJSONString];
        NSString *  ret = [responseDictionary valueForKey:@"token_status"];
        if(ret){
            [SVProgressHUD dismiss];
            succeededBlock(responseDictionary);
        }else {
            succeededBlock(responseDictionary);
        }
        
    } onError:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:kServiceErrorMessage];
        
    }];
    
    [self enqueueOperation:op];
    
    return op;
    
}
@end
