package com.jerry.helloworld;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.EnvironmentAware;
import org.springframework.core.env.Environment;
@Slf4j
@SpringBootApplication
public class HelloworldApplication implements CommandLineRunner, EnvironmentAware {

	Environment environment;
	public static void main(String[] args) {
		SpringApplication.run(HelloworldApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		log.info("配置参数：{}",environment.getProperty("myprofile"));
	}

	@Override
	public void setEnvironment(Environment environment) {

		this.environment=environment;
	}
}
