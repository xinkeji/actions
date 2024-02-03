#import <UIKit/UIKit.h>

@interface YTCollectionViewCell : UICollectionViewCell
@end

@interface YTSettingsCell : YTCollectionViewCell
@end

@interface YTSettingsSectionItem : NSObject
@property BOOL hasSwitch;
@property BOOL switchVisible;
@property BOOL on;
@property BOOL (^switchBlock)(YTSettingsCell *, BOOL);
@property int settingItemId;
- (instancetype)initWithTitle:(NSString *)title titleDescription:(NSString *)titleDescription;
@end

%hook YTRightNavigationButtons
%property (retain, nonatomic) YTQTMButton *uYouButton;
- (NSMutableArray *)buttons {
    NSMutableArray *retVal = %orig.mutableCopy;
    [self.uYouButton removeFromSuperview];
    [self addSubview:self.uYouButton];
    if (!self.uYouButton) {
        self.uYouButton = [%c(YTQTMButton) iconButton];
        [self.uYouButton enableNewTouchFeedback];
        self.uYouButton.frame = CGRectMake(0, 0, 40, 40);
        
        [self.uYouButton addTarget:self action:@selector(downloadingVC) forControlEvents:UIControlEventTouchUpInside];
        [retVal insertObject:self.uYouButton atIndex:0];
    }
    return retVal;
}
- (NSMutableArray *)visibleButtons {
    NSMutableArray *retVal = %orig.mutableCopy;
    [self setLeadingPadding:+10];
    if (self.uYouButton) {
        [self.uYouButton removeFromSuperview];
        [self addSubview:self.uYouButton];
        [retVal insertObject:self.uYouButton atIndex:0];
    }
    return retVal;
}
%new;
- (void)downloadingVC {
    DownloadedVC *allDownloadedVC = [[DownloadedVC alloc] initWithRootViewController:[[AllDownloadedVC alloc] init]];
    [allDownloadedVC setModalPresentationStyle:UIModalPresentationFullScreen];

    [self._viewControllerForAncestor presentViewController:allDownloadedVC animated:YES completion:nil];
}
%end
