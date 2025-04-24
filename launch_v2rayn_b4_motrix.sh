#!/bin/sh

# 应用名称
APP_A="v2rayN"
APP_B="Motrix"

# 设置最大等待时间为 30 秒
MAX_WAIT_TIME=30
WAITED_TIME=0

# 检查代理是否可用的函数
check_proxy() {
    echo "检测代理状态..."
    if curl -s --proxy http://127.0.0.1:10808 https://www.google.com > /dev/null; then
        echo "代理可用。"
        return 0
    else
        echo "代理不可用，等待代理可用..."
        return 1
    fi
}

# 如果 App A 没运行，则启动它一次
if ! pgrep -x "$APP_A" > /dev/null; then
    echo "未检测到 $APP_A ，尝试启动..."
    open -a "$APP_A"
fi

# 等待 App A 启动完成
echo "等待 $APP_A 启动中..."

while ! pgrep -x "$APP_A" > /dev/null; do
    sleep 1
done

echo "$APP_A 已启动，检测代理状态..."

# 等待代理可用
until check_proxy; do
    sleep 1
    WAITED_TIME=$((WAITED_TIME + 1))
    if [ $WAITED_TIME -ge $MAX_WAIT_TIME ]; then
        echo "代理未可用，超时退出。"
        exit 1
    fi
done

echo "代理可用，启动 $APP_B..."

# 启动 App B
open -a "$APP_B"
