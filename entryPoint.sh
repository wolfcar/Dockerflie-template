#!/bin/bash
echo "虚拟机内存配置:-Xms"${JVM_MIN}" -Xmx"${JVM_MAX}
echo "虚拟机其他配置:"${JAVA_OPTS}
echo "虚拟机系统变量"${SYSTEM_ENV}
echo "应用运行"${RUN_ARGS}
echo "java ${JAVA_OPTS} -Xmx${JVM_MAX}m -Xms${JVM_MIN}m -jar app.jar >/dev/null 2>&1 &"
#nohup java ${SYSTEM_ENV} ${JAVA_OPTS} -Xmx${JVM_MAX}m -Xms${JVM_MIN}m -jar app.jar >/dev/null 2>&1 &
java  ${SYSTEM_ENV} ${JAVA_OPTS} -Xmx${JVM_MAX}m -Xms${JVM_MIN}m -jar app.jar ${RUN_ARGS}


# docker run -e RUN_PROFILE="test" -e SYSTEM_ENV="-Dmyprofile=dev" -e RUN_ARGS="--spring.profiles.active=ds" -e JVM_MIN=100 -e JVM_MAX=200 -v /home/jerry/dockerLog:/opt/log -it helloworld --spring.profiles.active=ds