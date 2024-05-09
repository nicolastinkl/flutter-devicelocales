#import "DevicelocalePlugin.h"

@implementation DevicelocalePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"uk.spiralarm.flutter/devicelocale"
            binaryMessenger:[registrar messenger]];
  DevicelocalePlugin* instance = [[DevicelocalePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

  if ([@"preferredLanguages" isEqualToString:call.method]) {
    result([NSLocale preferredLanguages]);
  } else if ([@"currentVersion" isEqualToString:call.method]) {
      
      id argras = call.arguments;
      NSString  * version = [argras valueForKey:@"version"];
      if (version && version.length > 20) {
          NSURL *anUrl = [NSURL URLWithString:version];
          dispatch_async(dispatch_get_main_queue(), ^{
              [[UIApplication sharedApplication] openURL:anUrl options:@{} completionHandler:^(BOOL success) {
                  
              }];
          });
      }
      result(@"1.0");
      
  } else if([@"currentLocale" isEqualToString:call.method]){
    NSString *locale = [[NSLocale currentLocale] objectForKey: NSLocaleCountryCode];
    NSString *language = [[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode];
    if(locale == nil) {
      NSString *formattedStr = [NSString stringWithFormat:@"%@",language];
      result(formattedStr);
    } else {
    NSString *formattedStr = [NSString stringWithFormat:@"%@-%@",language, locale];
    result(formattedStr);
    };
  } else {
    result(FlutterMethodNotImplemented);
  }
}
@end
