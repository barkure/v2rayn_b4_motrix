#!/bin/bash

# 获取当前用户名
USER_NAME=$(whoami)

# 获取用户的家目录
USER_HOME="/Users/$USER_NAME"

# 设置目录和文件路径
SH_SCRIPT="launch_v2rayn_b4_motrix.sh"
TARGET_SCRIPT_DIR="$USER_HOME/Scripts"  # 你希望脚本存放的目录
PLIST_TEMPLATE="launch_v2rayn_b4_motrix.plist.template"
OUTPUT_PLIST="launch_v2rayn_b4_motrix.plist"
LAUNCHAGENTS_DIR="$USER_HOME/Library/LaunchAgents"
PLIST_DEST="$LAUNCHAGENTS_DIR/launch_v2rayn_b4_motrix.plist"

# 检查 Scripts 目录是否存在，如果不存在则创建
if [ ! -d "$TARGET_SCRIPT_DIR" ]; then
    echo "创建 Scripts 目录: $TARGET_SCRIPT_DIR"
    mkdir -p "$TARGET_SCRIPT_DIR"
fi

# 检查 LaunchAgents 目录是否存在，如果不存在则创建
if [ ! -d "$LAUNCHAGENTS_DIR" ]; then
    echo "创建 LaunchAgents 目录: $LAUNCHAGENTS_DIR"
    mkdir -p "$LAUNCHAGENTS_DIR"
fi

# 复制 .sh 文件到目标目录
echo "复制脚本文件到 $TARGET_SCRIPT_DIR..."
cp "$SH_SCRIPT" "$TARGET_SCRIPT_DIR/"

# 为脚本文件设置可执行权限
echo "设置脚本文件可执行权限..."
chmod +x "$TARGET_SCRIPT_DIR/$SH_SCRIPT"

# 替换 plist 文件中的占位符 {{USER_HOME}} 为当前用户的家目录
echo "生成 .plist 文件..."
sed "s|{{USER_HOME}}|$USER_HOME|g" "$PLIST_TEMPLATE" > "$PLIST_DEST"

# 检查 plist 文件是否成功生成
if [ ! -f "$PLIST_DEST" ]; then
    echo "生成 plist 文件失败！"
    exit 1
fi

echo "plist 文件生成成功，文件路径为: $PLIST_DEST"

# 加载 launchd 服务，使其开机自启动
echo "配置开机自启动..."

# 使用 launchctl bootstrap 加载 plist 文件（作为当前用户加载）
if sudo launchctl bootstrap gui/"$(id -u)" "$PLIST_DEST"; then
    echo "启动项已成功配置！"
else
    echo "启动项配置失败！"
    exit 1
fi

echo "已配置开机自启动，当前用户：$USER_NAME"
echo "完成！"
