#import <Foundation/Foundation.h>

@interface DeviceManager : NSObject

+ (instancetype)sharedManager;

- (void)spoofDeviceInfo;
- (void)resetDeviceInfo;
- (void)randomizeDeviceInfo;

// 设备信息属性
@property (nonatomic, strong) NSString *spoofedUDID;
@property (nonatomic, strong) NSString *spoofedSerialNumber;
@property (nonatomic, strong) NSString *spoofedModel;
@property (nonatomic, strong) NSString *spoofedProductName;
@property (nonatomic, strong) NSString *spoofedBoardId;
@property (nonatomic, strong) NSString *spoofedHardwareModel;

@end