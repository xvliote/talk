#!/bin/bash
set -e


# 删除旧目录并创建新目录
rm -rf /root/zvx/ieltstalk
mkdir -p /root/zvx/ieltstalk

# 解压备份文件并保留权限
cd /root/zvx
echo "开始解压备份文件..."
tar -xzpf /root/zvx/back/ieltstalk_backup_30.tar.gz -C /root/zvx/ieltstalk --strip-components=1

# 确保文件权限和所有权正确
chown -R root:root /root/zvx/ieltstalk
chmod -R 755 /root/zvx/ieltstalk

# 复制部署脚本
cp /root/zvx/redeploy.sh /root/zvx/ieltstalk/
cp /root/zvx/reserve.sh /root/zvx/ieltstalk/
chmod +x /root/zvx/ieltstalk/redeploy.sh
chmod +x /root/zvx/ieltstalk/reserve.sh



# 进入目录并安装依赖
cd /root/zvx/ieltstalk
echo "开始安装依赖..."
pnpm install

# 运行部署脚本
echo "开始构建项目..."
pnpm build

if [ $? -eq 0 ]; then
    echo "构建成功，开始复制文件..."
    sudo cp -r /root/zvx/ieltstalk/dist/. /var/www/ieltstalk/
    
    if [ $? -eq 0 ]; then
        echo "文件复制成功，重启 nginx..."
        sudo systemctl restart nginx
        
        if [ $? -eq 0 ]; then
            echo "部署完成！"
            exit 0
        else
            echo "错误：nginx 重启失败"
            exit 1
        fi
    else
        echo "错误：文件复制失败"
        exit 1
    fi
else
    echo "错误：项目构建失败"
    exit 1
fi
