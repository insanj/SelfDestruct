#import "SelfDestruct.h"

@implementation SelfDestruct

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
	SBApplication *frontMostApp = [(SpringBoard *)[UIApplication sharedApplication] _accessibilityFrontMostApplication];

	if (frontMostApp) {
		NSLog(@"[SelfDestruct] %@, have a nice day!", frontMostApp.displayName);
		system([[NSString stringWithFormat:@"kill %i", frontMostApp.pid] UTF8String]);
	}

	else {
		NSLog(@"[SelfDestruct] Looks like there's no frontmost application, ignoring event...");
	}

	[event setHandled:YES];
}

+ (void)load {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"libactivator.SelfDestruct"];
	[pool release];
}

@end
