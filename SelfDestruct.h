#include <UIKit/UIKit.h>
#import <libactivator/libactivator.h>

@interface UIApplication (Private)
- (unsigned int)_frontmostApplicationPort;
@end

@interface SBApplication : UIApplication
@property(readonly, assign, nonatomic) int pid;

- (id)displayIdentifier;
- (id)displayName;
@end

@interface SpringBoard : SBApplication
- (id)_accessibilityFrontMostApplication;
@end

@interface SelfDestruct : NSObject <LAListener, UIAlertViewDelegate>
@end
