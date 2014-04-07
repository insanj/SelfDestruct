#include <UIKit/UIKit.h>

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end

@interface SBApplication : UIApplication
- (id)displayIdentifier;
@end

%ctor {
	NSString __block *name = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
	if (!name) {
		NSLog(@"[SelfDestruct] Was going to load into foreground process, but it's invalid / SB...");
	}

	else {
		NSLog(@"[SelfDestruct] Loading into foreground process (%@), waiting for load to add bombers...", name);

		[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification){
			NSLog(@"[SelfDestruct] Detected completed launch (%@), preparing for bomb drop...", name);
			[[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"SDDropBomb" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification){
				NSLog(@"[SelfDestruct] %@, have a nice day!", name);
				system([[NSString stringWithFormat:@"killall -9 %@", name] UTF8String]);
			}];
		}];

		[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification){
			NSLog(@"[SelfDestruct] Detected completed resignation (%@), removing previous bombers...", name);
			[[NSDistributedNotificationCenter defaultCenter] removeObserver:nil name:@"SDDropBomb" object:nil];
		}];

	}
}
