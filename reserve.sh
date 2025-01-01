#!/bin/bash

# 获取下一个可用的备份编号
get_next_backup_number() {
    local max_num=0
    for file in /root/zvx/back/ieltstalk_backup_*.tar.gz; do
        if [ -f "$file" ]; then
            num=$(echo "$file" | grep -o '[0-9]\+\.tar\.gz' | grep -o '[0-9]\+')
            if [ "$num" -gt "$max_num" ]; then
                max_num=$num
            fi
        fi
    done
    echo $((max_num + 1))
}

# 创建备份目录（如果不存在）
mkdir -p /root/zvx/back

# 获取下一个备份编号
next_num=$(get_next_backup_number)

# 创建备份文件
cd /root/zvx/ieltstalk
echo "开始创建备份..."
tar -czf "/root/zvx/back/ieltstalk_backup_${next_num}.tar.gz" .

echo "备份完成：ieltstalk_backup_${next_num}.tar.gz"
