package com.astrolab.configserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.config.server.EnableConfigServer;

@SpringBootApplication
@EnableConfigServer
public class AstrolabConfigServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(AstrolabConfigServerApplication.class, args);
	}

}

