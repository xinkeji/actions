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
//%hook YTDataUtils
//+ (id)spamSignalsDictionary { return nil; }
//+ (id)spamSignalsDictionaryWithoutIDFA { return //nil; }
//%end

// https://github.com/PoomSmart/YouTube-X
// Disable Ads
%hook YTIPlayerResponse
- (BOOL)isMonetized { return IS_ENABLED(@"noAds_enabled") ? NO : YES; }
%end

%hook YTDataUtils
+ (id)spamSignalsDictionary { return IS_ENABLED(@"noAds_enabled") ? nil : %orig; }
+ (id)spamSignalsDictionaryWithoutIDFA { return IS_ENABLED(@"noAds_enabled") ? nil : %orig; }
%end

%hook YTAdsInnerTubeContextDecorator
- (void)decorateContext:(id)context { if (!IS_ENABLED(@"noAds_enabled")) %orig; }
%end

%hook YTAccountScopedAdsInnerTubeContextDecorator
- (void)decorateContext:(id)context { if (!IS_ENABLED(@"noAds_enabled")) %orig; }
%end

//PlayableInBackground
%hook YTIPlayabilityStatus

- (BOOL)isPlayableInBackground { return IS_ENABLED(@"backgroundPlayback_enabled") ? YES : NO; }

%end

%hook MLVideo

- (BOOL)playableInBackground { return IS_ENABLED(@"backgroundPlayback_enabled") ? YES : NO; }

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
