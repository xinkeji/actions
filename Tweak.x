#import <Foundation/Foundation.h> 

%hook YTGlobalConfig

- (BOOL)boolForKey:(NSString *)key {
    NSDictionary *keysToChange = @{
        @"shouldBlockUpgradeDialog": @YES,
        @"shouldForceUpgrade": @NO,
        @"shouldShowUpgrade": @NO,   
        @"shouldShowUpgradeDialog": @NO
    };
    NSNumber *changedValue = keysToChange[key];
    if (changedValue) {
        return [changedValue boolValue];
    }
        return %orig(key);
}

%end