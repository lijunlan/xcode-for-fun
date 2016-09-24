//
//  URLRequest.m
//  Will
//
//  Created by SDLL18 on 15/3/11.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import "URLRequest.h"
@interface URLRequest()
{
    NSURLRequest *request;
    NSURLConnection *connection;
    NSMutableData *webData;
    long httpStatusCode;
    void (^completion)(URLRequest* request,NSData* data, BOOL success);
}
@end

@implementation URLRequest

-(id)initWithRequest:(NSURLRequest *)req
{
    self = [super init];
    if(self!=nil)
    {
        request =req;
    }
    return self;
}

-(id)initWithURL:(NSString *)URL withBody:(NSMutableData *)body
{
    self = [super init];
    if(self!=nil)
    {
        NSURL *url = [NSURL URLWithString:URL];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [theRequest setHTTPBody:body];
         NSLog(@"sended data: %@\n",[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
        request = theRequest;
    }
    return self;
}

-(void)startWithCompletion:(void (^)(URLRequest *, NSData *, BOOL))comple
{
    completion = [comple copy];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(connection){
        webData = [[NSMutableData alloc] init];
    }
    else {
        completion(self,nil,NO);
    }
}

#pragma mark delegate

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"received data: %@\n",[[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding]);
    completion(self,webData,httpStatusCode==200);
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*) response;
    httpStatusCode = [httpResponse statusCode];
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
     NSLog(@"received data(error): %@\n",[[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding]);
    completion(self,webData,NO);
}

@end
