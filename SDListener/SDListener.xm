#import "SDListener.h"

@implementation SDListener

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
	[event setHandled:YES];
	NSLog(@"[SelfDestruct] Posting bomb-dropping notification...");
	[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"SDDropBomb" object:nil];
}

// - (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event
// - (void)activator:(LAActivator *)activator otherListenerDidHandleEvent:(LAEvent *)event
//- (void)activator:(LAActivator *)activator receiveDeactivateEvent:(LAEvent *)event

+ (void)load {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"libactivator.SelfDestruct"];
	[pool release];
}

@end
