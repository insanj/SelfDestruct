#import "SelfDestruct.h"

@implementation SelfDestruct

/*static NSString *destruct_pullFrontAppIdentifier() {
	char frontAppIdentifier[256];
	memset(frontAppIdentifier, sizeof(frontAppIdentifier), 0);
	SBFrontmostApplicationDisplayIdentifier(SBSSpringBoardServerPort(), frontAppIdentifier);
	return [NSString stringWithCString:frontAppIdentifier encoding:NSASCIIStringEncoding];
}*/

static NSString *destruct_copyFrontAppIdentifier() {
	return SBSCopyFrontmostApplicationDisplayIdentifier();
}

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
	NSLog(@"[SelfDestruct / DEBUG] Received activator event...");
	NSString *front = destruct_copyFrontAppIdentifier();
	NSLog(@"[SelfDestruct / DEBUG] Detected frontmost: %@", front);

	if (!front) {
		NSLog(@"[SelfDestruct / DEBUG] Cannot kill off an invalid process...");
	}

	else {
		NSString *name = [[NSBundle bundleWithIdentifier:front] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
		NSLog(@"[SelfDestruct] %@, have a nice day!", name);
		system([[NSString stringWithFormat:@"killall -9 %@", name] UTF8String]);
	}

	[event setHandled:YES];
}

+ (void)load {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"libactivator.SelfDestruct"];
	[pool release];
}

@end
