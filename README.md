# 多平台ADB_HOST编译
从AOSP上裁剪出可以单独编译并运行在多个平台上(如树莓派)的adb模块。

## 编译环境和多平台类型
* **编译环境**  
    Ubuntu x86_64  
* **多平台包括**  
    x86_64、arm64、arm32
* **ADB版本**   
    v1.0.40
## 交叉编译工具链安装
### arm64 交叉编译工具链安装
```
apt install g++-aarch64-linux-gnu
apt install gcc-aarch64-linux-gnu  
```
### arm32 交叉编译工具链安装
```
apt install gcc-arm-linux-gnueabihf
apt install g++-arm-linux-gnueabihf
```
## 编译
### 生成x86_64平台 (默认编译选项)
```
make
```
### 生成arm64平台
```
make CC=aarch64-linux-gnu-gcc TARGET=arm64
```
### 生成arm32平台
```
make CC=arm-linux-gnueabihf-gcc TARGET=arm32
```
# --说明--
## 代码构成
### ADB
基于Android 9.0 版本代码(branch: origin/pie-release):
```
git clone https://android.googlesource.com/platform/system/adb
```
#### 代码下载
基于Android 9.0 版本代码(branch: origin/pie-release):
```
git clone https://android.googlesource.com/platform/external/boringssl
```
#### 交叉编译工具下载
```
git clone git@github.com:vpetrigo/arm-cmake-toolchains.git
```
#### CMAKE文件(arm-gcc-toolchain.cmake)修改
##### arm32
```
修改
arm-none-eabi-
为
arm-linux-gnueabihf-
```
##### arm64

```
修改
arm-none-eabi-
为
aarch64-linux-gnu-

修改
set(CMAKE_SYSTEM_PROCESSOR ARM)
为
set(CMAKE_SYSTEM_PROCESSOR AARCH64)
```
#### 编译
##### x8 6
```
cd src
mkdir build
cd build
cmake ..
make
```
##### arm32 & arm64
```
cd src
mkdir build
cd build
cmake  -DCMAKE_TOOLCHAIN_FILE=arm-gcc-toolchain.cmake ..
make
``` 
