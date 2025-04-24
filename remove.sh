#!/bin/bash

# 获取当前用户名
USER_NAME=$(whoami)

# 获取用户的家目录
USER_HOME="/Users/$USER_NAME"

# 设置目录和文件路径
SH_SCRIPT="launch_v2rayn_b4_motrix.sh"
TARGET_SCRIPT_DIR="$USER_HOME/Scripts"  # 脚本文件存放的目录
PLIST_FILE="launch_v2rayn_b4_motrix.plist"
LAUNCHAGENTS_DIR="$USER_HOME/Library/LaunchAgents"
PLIST_DEST="$LAUNCHAGENTS_DIR/$PLIST_FILE"

# 检查 plist 文件是否存在
if [ -f "$PLIST_DEST" ]; then
    echo "卸载启动项：$PLIST_DEST"

    # 卸载并停止启动项
    sudo launchctl bootout gui/"$(id -u)" "$PLIST_DEST"
    
    # 删除 plist 文件
    rm "$PLIST_DEST"
    echo "启动项已卸载并删除。"
else
    echo "错误：没有找到 plist 文件，启动项未配置。"
fi

# 检查脚本文件是否存在
if [ -f "$TARGET_SCRIPT_DIR/$SH_SCRIPT" ]; then
    echo "删除脚本文件：$TARGET_SCRIPT_DIR/$SH_SCRIPT"
    rm "$TARGET_SCRIPT_DIR/$SH_SCRIPT"
    echo "脚本文件已删除。"
else
    echo "错误：没有找到脚本文件，脚本未配置。"
fi

# 检查 Scripts 目录是否为空，如果为空则删除该目录
if [ "$(ls -A $TARGET_SCRIPT_DIR)" ]; then
    echo "Scripts 目录不为空，保留该目录。"
else
    echo "删除空的 Scripts 目录：$TARGET_SCRIPT_DIR"
    rmdir "$TARGET_SCRIPT_DIR"
fi

echo "完成移除！"
