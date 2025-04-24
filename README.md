# launch-v2rayn-b4-motrix

在 macOS 上同时开启了 `v2rayN` 和 `Motrix` 的开机自启动后， `Motrix` 可能会因为 `v2rayN` 的代理启动较慢出现如下错误：
```
Cannot check for updates: Error: net::ERR_PROXY_CONNECTION_FAILED
at SimpleURLLoaderWrapper.<anonymous> (node:electron/js2c/browser_init:2:49386)
at SimpleURLLoaderWrapper.emit (node:events:513:28)
```

此脚本用来在`v2rayN` 的代理可用后再启动 `Motrix`。

## 如何使用

### 1. 克隆或下载代码

首先，克隆或下载此项目到你的 macOS 上。

```bash
git clone https://github.com/barkure/launch-v2rayn-b4-motrix.git
cd launch-v2rayn-b4-motrix
```

### 2. 配置并运行安装脚本

运行安装脚本 `setup.sh` 来配置脚本文件并设置开机自启动。

```bash
sh setup.sh
```

此脚本将执行以下操作：

- 将 `launch_v2rayn_b4_motrix.sh` 脚本复制到 `~/Scripts/` 目录，并为脚本设置可执行权限。
- 生成并复制 `.plist` 文件到 `~/Library/LaunchAgents/` 目录。
- 使用 `launchctl` 配置开机自启动。

### 3. 验证是否配置成功

1. 打开终端，检查是否已正确配置启动项：

   ```bash
   launchctl list | grep launch_v2rayn_b4_motrix
   ```

2. 重启你的 macOS，确保在开机时自动启动 `v2rayN` 和 `Motrix`。

## 移除

如果你想要移除自动启动项和相关脚本，可以运行 `remove.sh` 脚本：

```bash
sh remove.sh
```

此脚本将：

- 删除 `~/Scripts/launch_v2rayn_b4_motrix.sh` 脚本文件。
- 卸载并停止启动项。
- 删除 `~/Library/LaunchAgents/launch_v2rayn_b4_motrix.plist` 启动项配置。

## 脚本说明

- `launch_v2rayn_b4_motrix.sh`：启动 `v2rayN`，等待代理可用后启动 `Motrix`。
- `launch_v2rayn_b4_motrix.plist.template`：用于创建 `plist` 配置文件的模板。
- `setup.sh`：配置并安装脚本及启动项。
- `remove.sh`：移除所有配置和启动项。

## 其他

本项目可作为 macOS 启动项配置的一个示例，展示了如何通过脚本和 launchd 配置启动项，确保程序按指定顺序和条件自动启动。