// LimeChat is copyrighted free software by Satoshi Nakagawa <psychs AT limechat DOT net>.
// You can redistribute it and/or modify it under the terms of the GPL version 2 (see the file GPL.txt).

#import "MainWindow.h"


@implementation MainWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)windowStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)deferCreation
{
	self = [super initWithContentRect:contentRect styleMask:windowStyle backing:bufferingType defer:deferCreation];
	if (self) {
		keyHandler = [KeyEventHandler new];
		swipeHandler = [SwipeEventHandler new];
	}
	return self;
}

- (void)dealloc
{
	[keyHandler release];
	[swipeHandler release];
	[super dealloc];
}

- (void)setKeyHandlerTarget:(id)target
{
	[keyHandler setTarget:target];
}

- (void)registerKeyHandler:(SEL)selector key:(int)code modifiers:(NSUInteger)mods
{
	[keyHandler registerSelector:selector key:code modifiers:mods];
}

- (void)registerKeyHandler:(SEL)selector character:(UniChar)c modifiers:(NSUInteger)mods
{
	[keyHandler registerSelector:selector character:c modifiers:mods];
}

- (void)setSwipeHandlerTarget:(id)target
{
	[swipeHandler setTarget:target];
}

- (void)registerSwipeHandler:(SEL)selector deltaX:(CGFloat)x deltaY:(CGFloat)y
{
	[swipeHandler registerSelector:selector deltaX:x deltaY:y];
}

- (void)swipeWithEvent:(NSEvent *)event
{
	[swipeHandler processSwipeEvent:event];
}

- (void)sendEvent:(NSEvent *)e
{
	if ([e type] == NSKeyDown) {
		if ([keyHandler processKeyEvent:e]) {
			return;
		}
	}
	
	[super sendEvent:e];
}

@end
