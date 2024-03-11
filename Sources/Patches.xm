#import "Hiepvk.h"

# pragma mark - YouTube patches

// Fix Google Sign in by @PoomSmart and @level3tjg
%hook NSBundle
- (NSDictionary *)infoDictionary {
    NSMutableDictionary *info = %orig.mutableCopy;
    NSString *altBundleIdentifier = info[@"ALTBundleIdentifier"];
    if (altBundleIdentifier) info[@"CFBundleIdentifier"] = altBundleIdentifier;
    return info;
}
%end

// Workaround
%hook YTDataUtils
+ (id)spamSignalsDictionary { return nil; }
+ (id)spamSignalsDictionaryWithoutIDFA { return nil; }
%end

// https://github.com/PoomSmart/YouTube-X
%hook YTAdsInnerTubeContextDecorator
- (void)decorateContext:(id)context {}
%end


// Hide Upgrade Dialog by @arichorn
%hook YTGlobalConfig
- (BOOL)shouldBlockUpgradeDialog { return YES;}
- (BOOL)shouldForceUpgrade { return NO;}
- (BOOL)shouldShowUpgrade { return NO;}
- (BOOL)shouldShowUpgradeDialog { return NO;}
%end
