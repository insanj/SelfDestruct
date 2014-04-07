#include <UIKit/UIKit.h>

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end

@interface SBApplication : UIApplication
- (id)displayIdentifier;
@end

%ctor {
	NSString *identifier = ((SBApplication *)[UIApplication sharedApplication]).displayIdentifier;
	if ([identifier isEqualToString:@"com.apple.springboard"]) {
		NSLog(@"[SelfDestruct] Was going to load into foreground process, but it's SpringBoard...");
	}

	else {
		NSLog(@"[SelfDestruct] Removing previous bomb-dropper to prepare for %@'s...", identifier);
		[[NSDistributedNotificationCenter defaultCenter] removeObserver:nil name:@"SDDropBomb" object:nil];

		[[NSDistributedNotificationCenter defaultCenter] addObserverForName:@"SDDropBomb" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification){
			NSLog(@"[SelfDestruct] Have a nice day!");
			NSString *command = [NSString stringWithFormat:@"killall -9 %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
			system([command UTF8String]);
		}];
	}
}
