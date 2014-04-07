#include <UIKit/UIKit.h>
#import <libactivator/libactivator.h>

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end

@interface SBApplication : UIApplication
- (id)displayIdentifier;
@end

@interface SDListener : NSObject <LAListener, UIAlertViewDelegate>
@end
