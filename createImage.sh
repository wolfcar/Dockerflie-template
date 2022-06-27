#!/bin/bash
echo "###################欢迎使用构建镜像容器脚本########################"
echo "1.通过git仓库获取构建镜像"
echo "2.当前代码路径"
echo "3.直接运行Dockerfile"
echo "###############################################################"
read -p "input your select,please:" exec_type
case $exec_type in
1)
echo "己选择通过代码仓库构建镜像"
read -p "input your prject address:" prj_url
git clone $prj_url
  ;;
esac
echo $exec_type

