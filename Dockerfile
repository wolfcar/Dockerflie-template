FROM adoptopenjdk/openjdk8:latest

MAINTAINER jerrykk chedejun@126.com

#定义时区参数
ENV TZ=Asia/Shanghai
#设置时区
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


VOLUME /tmp
VOLUME /var/log/

# 设置构建参数
ARG USER_NAME=jerry
ARG JAR_FILE=target/*.jar

# 设置环境变量
ENV JVM_MIN 4096
ENV JVM_MAX 4096

COPY --from=hengyunabc/arthas:latest /opt/arthas /opt/arthas
RUN adduser  $USER_NAME
USER $USER_NAME
WORKDIR /$USER_NAME
COPY $JAR_FILE app.jar
COPY entryPoint.sh .


ENTRYPOINT ["sh","./entryPoint.sh"]


docker run -e RUN_PROFILE="test" -e SYSTEM_ENV="-Dmyprofile=dev" -e RUN_ARGS="--spring.profiles.active=ds" -e JVM_MIN=100 -e JVM_MAX=200 -v /home/jerry/dockerLog:/opt/log -it helloworld --spring.profiles.active=ds



