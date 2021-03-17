#import <WebKit/WebKit.h>

#import "PlatformAccessor.h"


@interface PlatformAccessor()

- (NSString*)_getLang;

@end


@implementation PlatformAccessor

- (void)getLang:(CDVInvokedUrlCommand*)command
{
  //NSString* arg0 = [command.arguments objectAtIndex:0];
    
    NSString* result = [self _getLang];
  
    CDVPluginResult * pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getUid:(CDVInvokedUrlCommand*)command
{
    NSString* result = [[UIDevice currentDevice] identifierForVendor].UUIDString;

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getPlatformData:(CDVInvokedUrlCommand*)command
{
  //NSString* arg0 = [command.arguments objectAtIndex:0];

    NSDictionary *result = @{
        @"lang"        : [self _getLang],
        @"platformName"    : @"ios",
		@"platformSuffix"    : @"io",
        @"platformCode"    : @"9"
    };
  
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)minimize:(CDVInvokedUrlCommand*)command
{
    //NSString* arg0 = [command.arguments objectAtIndex:0];
    
    // Apple does not implement this feature
}

- (void)initWebView:(CDVInvokedUrlCommand*)command
{
  //NSString* arg0 = [command.arguments objectAtIndex:0];

    NSString* result = @"OK";
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
  /* Try cookies
    NSLog(@"----> Cookies start");
    
    NSMutableDictionary* cookieProperties = [NSMutableDictionary dictionary];
        [cookieProperties setObject:@"access" forKey:NSHTTPCookieName];
        [cookieProperties setObject:@"1" forKey:NSHTTPCookieValue];
        [cookieProperties setObject:@"t0.waysofhistory.com" forKey:NSHTTPCookieOriginURL];
        [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
        [cookieProperties setObject:@"true" forKey:NSHTTPCookieSecure];
    
    NSHTTPCookie* cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie: cookie];
    
    NSLog(@"----> cookie for set: %@", cookie);
    
    if ([self.webView isKindOfClass:[WKWebView class]]) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
        
        WKWebView* wkWebView = (WKWebView*) self.webView;
        
        if (@available(iOS 11.0, *)) {
            [wkWebView.configuration.preferences setValue:@"TRUE" forKey:@"allowFileAccessFromFileURLs"];
            [wkWebView.configuration setValue:@"TRUE" forKey:@"allowUniversalAccessFromFileURLs"];
            
            [wkWebView.configuration.websiteDataStore.httpCookieStore setCookie:cookie completionHandler:^{NSLog(@"Cookie set in WKWebView");}];
            
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            
            [wkWebView.configuration.websiteDataStore.httpCookieStore getAllCookies:^(NSArray<NSHTTPCookie *> * arr){
                
                NSEnumerator *enumerator = [arr objectEnumerator];
                id anObject;
                
                NSLog(@"----> !!!cookie enumerator!!!");
                
                while (anObject = [enumerator nextObject]) {
                    NSLog(@"----> !!!cookie!!! %@", anObject);
                    
//                    [wkWebView.configuration.websiteDataStore.httpCookieStore deleteCookie:anObject completionHandler:^{NSLog(@"Cookie removed from WKWebView");}];
                }
            }];
        } else {
            result = @"WKWebView requires iOS 11+ in order to set the cookie";
        }
    } else {
    NSLog(@"----> is not WKWebView");
   }
   
   pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
   
   [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
 */
}

- (NSString*)_getLang
{
    return [[[NSLocale preferredLanguages] firstObject] substringToIndex:2];
}

@end
