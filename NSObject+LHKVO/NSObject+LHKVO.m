#import "NSObject+LHKVO.h"
#import <objc/runtime.h>
@interface NSObject (LHKVO)
    @property (nonatomic) NSMutableDictionary *keyMumdict;
@end
@implementation NSObject (LHKVO)
@dynamic   keyMumdict;
-(NSMutableDictionary*)keyMumdict{
    NSMutableDictionary *mudict = objc_getAssociatedObject(self, _cmd);
    if (!mudict) {
        objc_setAssociatedObject(self, _cmd, [NSMutableDictionary new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

-(void)LHaddObserver: (NSString *)key withBlock: (LHHandler)observedHandler{
    [self.keyMumdict setObject:observedHandler forKey:key];
    [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    LHHandler hander = [self.keyMumdict objectForKey:keyPath];
    if(hander){
        hander();
    }
}

- (void)LHremoveObserver: (NSString *)key{
    [self.keyMumdict removeObjectForKey:key];
    [self removeObserver:self forKeyPath:key];
}
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *selStringsArray = @[@"dealloc"];
        
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *mySelString = [@"sd_" stringByAppendingString:selString];
            
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
            method_exchangeImplementations(originalMethod, myMethod);
        }];
    });
}
-(void)sd_dealloc{
    NSArray*keys = [self.keyMumdict allKeys];
    for (NSString*key in keys) {
        [self LHremoveObserver:key];
        NSLog(@"dealloc_key:%@",key);
    }
    
}
@end
