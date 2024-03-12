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

%hook YTAccountScopedAdsInnerTubeContextDecorator

- (void)decorateContext:(id)context {}

%end

%hook YTIElementRenderer

- (NSData *)elementData {
    if (self.hasCompatibilityOptions && self.compatibilityOptions.hasAdLoggingData) return nil;
    return %orig;
}

%end

//PlayableInBackground
%hook YTIPlayabilityStatus

- (BOOL)isPlayableInBackground { return IS_ENABLED(@"backgroundPlayback") ? YES : NO; }

%end

%hook MLVideo

- (BOOL)playableInBackground { return IS_ENABLED(@"backgroundPlayback") ? YES : NO; }

%end

//YTNoPaidPromo
%hook YTMainAppVideoPlayerOverlayViewController

- (void)setPaidContentWithPlayerData:(id)data {}

- (void)playerOverlayProvider:(YTPlayerOverlayProvider *)provider didInsertPlayerOverlay:(YTPlayerOverlay *)overlay {
    if ([[overlay overlayIdentifier] isEqualToString:@"player_overlay_paid_content"]) return;
    %orig;
}
%end

%hook YTInlineMutedPlaybackPlayerOverlayViewController

- (void)setPaidContentWithPlayerData:(id)data {}

%end

// Hide Upgrade Dialog by @arichorn
%hook YTGlobalConfig
- (BOOL)shouldBlockUpgradeDialog { return YES;}
- (BOOL)shouldForceUpgrade { return NO;}
- (BOOL)shouldShowUpgrade { return NO;}
- (BOOL)shouldShowUpgradeDialog { return NO;}
%end
