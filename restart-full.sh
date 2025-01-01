#!/bin/bash

echo "Starting full restart process..."

# 切换到项目目录
cd /root/zvx/ieltstalk

# 重新构建项目
echo "Rebuilding project..."
npm run build
if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

# 查找并终止现有的 Node.js 进程
echo "Stopping existing Node.js process..."
OLD_PID=$(lsof -t -i:3000)
if [ ! -z "$OLD_PID" ]; then
    echo "Killing process $OLD_PID"
    kill -9 $OLD_PID
fi

# 重启 Nginx
echo "Restarting Nginx..."
systemctl restart nginx
if [ $? -ne 0 ]; then
    echo "Failed to restart Nginx!"
    exit 1
fi

# 等待端口释放
echo "Waiting for port to be available..."
sleep 2

# 启动新的服务器进程
echo "Starting new server..."
node server.js &

# 等待服务器启动
echo "Waiting for server to start..."
sleep 2

# 检查服务器是否成功启动
if lsof -i:3000 > /dev/null; then
    echo "Server successfully restarted!"
    echo "Nginx successfully restarted!"
    echo "You can now access the application at https://x.matrixorv.us.kg"
else
    echo "Server failed to start!"
    exit 1
fi
