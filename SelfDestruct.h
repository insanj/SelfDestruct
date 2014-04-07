#include <UIKit/UIKit.h>
#include <substrate.h>
#import <libactivator/libactivator.h>

#import <sys/sysctl.h>
#import <dlfcn.h>
#define UIKITPATH "/System/Library/Frameworks/UIKit.framework/UIKit"
#define SBSERVPATH "/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices"

extern "C" {
	mach_port_t SBSSpringBoardServerPort();
	void SBFrontmostApplicationDisplayIdentifier(mach_port_t port, char *result);
	NSString * SBSCopyFrontmostApplicationDisplayIdentifier();
}

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end

@interface UIApplication (Private)
- (unsigned int)_frontmostApplicationPort;
@end

@interface SBApplication : UIApplication
- (id)displayIdentifier;
@end

@interface SelfDestruct : NSObject <LAListener, UIAlertViewDelegate>
@end
