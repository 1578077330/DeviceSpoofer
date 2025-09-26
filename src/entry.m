#import <Foundation/Foundation.h>
#import "DeviceManager.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface DeviceSpooferUI : NSObject
+ (void)showConfirmationDialog;
@end

__attribute__((constructor))
static void entry() {
    NSLog(@"[DeviceSpoofer] dylib已加载到进程: %@", [[NSProcessInfo processInfo] processName]);
    
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    if ([bundleID isEqualToString:@"com.xingin.discover"]) {
        NSLog(@"[DeviceSpoofer] 检测到小红书，初始化手势识别");
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setupGestureRecognizer];
            [[DeviceManager sharedManager] spoofDeviceInfo]; // 自动应用设备伪装
        });
    }
}

// 设置双指长按手势
static void setupGestureRecognizer() {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (!keyWindow) {
        // 如果keyWindow为空，稍后重试
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            setupGestureRecognizer();
        });
        return;
    }
    
    UILongPressGestureRecognizer *twoFingerLongPress = [[UILongPressGestureRecognizer alloc] 
                                                        initWithTarget:self 
                                                        action:@selector(handleTwoFingerLongPress:)];
    twoFingerLongPress.numberOfTouchesRequired = 2; // 需要两个手指
    twoFingerLongPress.minimumPressDuration = 1.5;  // 长按1.5秒
    twoFingerLongPress.allowableMovement = 10;      // 允许轻微移动
    
    [keyWindow addGestureRecognizer:twoFingerLongPress];
    NSLog(@"[DeviceSpoofer] 双指长按手势已添加");
}

// 手势处理函数
static void handleTwoFingerLongPress(UILongPressGestureRecognizer *gesture) {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"[DeviceSpoofer] 检测到双指长按手势");
        [DeviceSpooferUI showConfirmationDialog];
    }
}

@end

// 对话框UI实现
@implementation DeviceSpooferUI

+ (void)showConfirmationDialog {
    // 确保在主线程执行UI操作
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        UIViewController *rootVC = keyWindow.rootViewController;
        
        // 创建警告对话框
        UIAlertController *alert = [UIAlertController 
            alertControllerWithTitle:@"一键新机"
            message:@"确定要执行一键换机操作吗？此操作将修改设备信息。"
            preferredStyle:UIAlertControllerStyleAlert];
        
        // 确定按钮
        UIAlertAction *confirmAction = [UIAlertAction 
            actionWithTitle:@"确定" 
            style:UIAlertActionStyleDestructive 
            handler:^(UIAlertAction *action) {
                NSLog(@"[DeviceSpoofer] 用户确认执行一键新机");
                [self performDeviceSpoofing];
            }];
        
        // 取消按钮
        UIAlertAction *cancelAction = [UIAlertAction 
            actionWithTitle:@"取消" 
            style:UIAlertActionStyleCancel 
            handler:^(UIAlertAction *action) {
                NSLog(@"[DeviceSpoofer] 用户取消操作");
            }];
        
        [alert addAction:confirmAction];
        [alert addAction:cancelAction];
        
        // 显示对话框
        [rootVC presentViewController:alert animated:YES completion:nil];
    });
}

+ (void)performDeviceSpoofing {
    DeviceManager *manager = [DeviceManager sharedManager];
    
    // 生成新的随机设备信息
    [manager randomizeDeviceInfo];
    
    // 显示操作完成提示
    [self showSuccessMessage];
}

+ (void)showSuccessMessage {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        UIViewController *rootVC = keyWindow.rootViewController;
        
        UIAlertController *alert = [UIAlertController 
            alertControllerWithTitle:@"操作完成"
            message:@"设备信息已更新！建议重启小红书应用生效。"
            preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction 
            actionWithTitle:@"确定" 
            style:UIAlertActionStyleDefault 
            handler:nil];
        
        [alert addAction:okAction];
        [rootVC presentViewController:alert animated:YES completion:nil];
    });
}

@end
