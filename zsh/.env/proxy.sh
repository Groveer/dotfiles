# proxy set 设置代理
# proxy unset 取消代理
# proxy test 查看代理情况
# 因本人使用 WSL2，使用此脚本可方便设置主机代理，非 WSL2 用户可删除文件：rm -f proxy*
alias proxy="source $(dirname $(readlink -f $0))/proxy-script"
#proxy set
