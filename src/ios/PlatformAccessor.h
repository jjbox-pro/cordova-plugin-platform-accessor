#import <Cordova/CDV.h>

@interface PlatformAccessor : CDVPlugin {
  // Member variables go here.
}

- (void)getLang:(CDVInvokedUrlCommand*)command;
- (void)getUid:(CDVInvokedUrlCommand*)command;
- (void)getPlatformData:(CDVInvokedUrlCommand*)command;
- (void)minimize:(CDVInvokedUrlCommand*)command;
- (void)initWebView:(CDVInvokedUrlCommand*)command;

@end
