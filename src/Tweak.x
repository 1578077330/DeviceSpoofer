#import "DeviceManager.h"

%hook SpringBoard

// 设备信息获取方法 hook
- (NSString *)uniqueIdentifier {
    DeviceManager *manager = [DeviceManager sharedManager];
    if (manager.spoofedUDID) {
        return manager.spoofedUDID;
    }
    return %orig;
}

- (NSString *)serialNumber {
    DeviceManager *manager = [DeviceManager sharedManager];
    if (manager.spoofedSerialNumber) {
        return manager.spoofedSerialNumber;
    }
    return %orig;
}

- (NSString *)model {
    DeviceManager *manager = [DeviceManager sharedManager];
    if (manager.spoofedModel) {
        return manager.spoofedModel;
    }
    return %orig;
}

%end

%ctor {
    NSLog(@"[DeviceSpoofer] 插件已加载");
    
    // 启动时自动伪装设备信息
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[DeviceManager sharedManager] spoofDeviceInfo];
    });
}