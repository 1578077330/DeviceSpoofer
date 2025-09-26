// 在randomizeDeviceInfo方法中添加更多随机化选项
- (void)randomizeDeviceInfo {
    NSLog(@"[DeviceSpoofer] 开始生成随机设备信息...");
    
    // 设备型号列表
    NSArray *deviceModels = @[
        @"iPhone14,5", // iPhone 13
        @"iPhone14,2", // iPhone 13 Pro
        @"iPhone15,2", // iPhone 14 Pro
        @"iPhone15,3", // iPhone 14 Pro Max
        @"iPhone16,1"  // iPhone 15 Pro
    ];
    
    // 随机选择设备型号
    self.spoofedModel = deviceModels[arc4random_uniform((uint32_t)deviceModels.count)];
    self.spoofedUDID = [self generateRandomUDID];
    self.spoofedSerialNumber = [self generateRandomSerial];
    self.spoofedProductName = [self.spoofedModel stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    NSLog(@"[DeviceSpoofer] 新设备信息: %@, UDID: %@", self.spoofedModel, self.spoofedUDID);
}
