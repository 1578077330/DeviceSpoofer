# DeviceSpoofer - iOS一键新机插件

一个iOS越狱插件，用于修改设备信息实现一键新机功能。

## 功能特性

- 修改设备UDID
- 修改序列号
- 修改设备型号
- 支持随机生成设备信息
- 一键重置功能

## 编译要求

- iOS 13.0+
- Theos 越狱开发环境
- arm64/arm64e 架构设备

## 编译安装

```bash
# 克隆项目
git clone https://github.com/1578077330/DeviceSpoofer.git
cd DeviceSpoofer

# 编译
make package

# 安装
make install
