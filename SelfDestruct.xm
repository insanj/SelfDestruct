#include <UIKit/UIKit.h>

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end

@interface SBApplication : UIApplication
- (id)displayIdentifier;
@end

%ctor {
	[[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"SDBoom" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification){
		if ([((SBApplication *)[UIApplication sharedApplication]).displayIdentifier isEqualToString:@"com.apple.springboard"]) {
			NSLog(@"[SelfDestruct] Recognized we're in SpringBoard, ignore explosion...");
		}

		else {
			NSLog(@"[SelfDestruct] Have a nice day!");
			NSString *command = [NSString stringWithFormat:@"killall -9 %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
			system([command UTF8String]);
		}
	}];
}
