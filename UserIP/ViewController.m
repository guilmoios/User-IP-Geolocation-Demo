//
//  ViewController.m
//  UserIP
//
//  Created by Guilherme Mogames on 2/17/13.
//  Copyright (c) 2013 Mogames. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Method 1 - External IP With Geolocation
    
    // Defines the webservice URL
    NSURL *URL = [NSURL URLWithString:@"http://ip-api.com/json"];
    
    // Start Connection
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:URL];
    
    // Define the JSON header
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    // Set the Request
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"" parameters:nil];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSString *myIP = [JSON valueForKey:@"query"];
        NSLog(@"IP: %@", myIP);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        
        // Failed
        NSLog(@"error: %@", error.description);
        
    }];
    
    // Run the Request
    [operation start];
    
    
    // *******************************
    
    
    // Method 2 - External IP Without Geolocation
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *theURL = [[NSURL alloc] initWithString:@"http://ip-api.com/line/?fields=query"];
        NSString* myIP = [[NSString alloc] initWithData:[NSData dataWithContentsOfURL:theURL] encoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Manipulate the ip on the main queue
            NSLog(@"IP: %@",myIP);
        });
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
