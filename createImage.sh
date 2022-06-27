#!/bin/bash
#脚本配置信息全局变量
#镜像私有仓库
docker_domain="localhost:1234"
project_path="ffg"
docker_user=""
docker_pwd=""
version=`date +%y%m%d%H%M%S`
#git相关配置
git_prj_url=""
code_path=""
#docker镜象打包jar路径,第3
jar_file=""

#
cp_dockerfile(){
  cp -f Dockerfile ./$code_path/Dockerfile
  cp -f entryPoint.sh ./$code_path/entryPoint.sh
}

buildAndPushImage(){
  cd $code_path
  if [ ! $jar_file ]; then
    echo "docker build -t ${code_path}:${version} ."
    docker build -t $code_path:${version} .
  else
    echo "docker build  --build-arg JAR_FILE=${jar_file} -t ${code_path}:${version} ."
    docker build --build-arg JAR_FILE=${jar_file} -t ${code_path}:${version} .

  fi
  docker tag ${code_path}:${version} ${docker_domain}/${project_path}/${code_path}:${version}

  docker login -u ${docker_user} -p{docker_pwd} ${docker_domain}
  docker push  ${docker_domain}/${project_path}/${code_path}:${version}

}

#rm -rf Dockerflie-template
echo "###################欢迎使用构建镜像容器脚本########################"
echo "1.通过git仓库获取构建镜像"
echo "2.当前代码路径"
echo "3.直接运行Dockerfile"
echo "##########################################################"
read -p "input your select,please:" exec_type

case $exec_type in
1)
  echo "己选择通过代码仓库构建镜像"
  read -p "input your prject address:" git_prj_url
  read -p "qing shu ru daimai fenzhi" branch

  code_path=`basename $git_prj_url |awk -F . {'print $1'}`
  rm -rf $code_path
  git clone $git_prj_url

  echo $code_path

  cd $code_path
  git checkout -b $branch origin/$branch

  mvn clean install -Dmaven.test.skip=true
  cd ..
  ;;
2)
  echo "代码仓库像己存在,"
  read -p "请输gongcheng mulu :" code_path
  read -p "qing shu ru daimai fenzhi" branch
  cd $code_path
  git pull
  git checkout -b $branch origin/$branch

  mvn clean install -Dmaven.test.skip=true\

  cd ..
  ;;
3)
  echo "3"
  read -p "请输gongcheng mulu :" code_path
  jar_file="./*.jar"
esac

cp_dockerfile

buildAndPushImage code_path
