#import <Foundation/Foundation.h>

typedef void (^LHHandler) ();
@interface NSObject (LXD_KVO)
- (void)LHaddObserver: (NSString *)key withBlock: (LHHandler)observedHandler;
- (void)LHremoveObserver: (NSString *)key;
@end