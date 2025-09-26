#import <Foundation/Foundation.h>

__attribute__((constructor))
static void entry() {
    NSLog(@"[DeviceSpoofer] 插件初始化");
}