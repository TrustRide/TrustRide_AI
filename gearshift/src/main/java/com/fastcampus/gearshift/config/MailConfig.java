package com.fastcampus.gearshift.config;

import org.springframework.core.env.Environment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;
import javax.annotation.Resource;

@Configuration
@ComponentScan(basePackages = "com.fastcampus.gearshift")
@PropertySource("classpath:mail.properties")
public class MailConfig {

    @Resource
    private Environment env;

    @Bean
    public JavaMailSenderImpl mailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost(env.getProperty("mail.host"));
        mailSender.setPort(Integer.parseInt(env.getProperty("mail.port")));
        mailSender.setUsername(env.getProperty("mail.username")); //발신 이메일 주소
        mailSender.setPassword(env.getProperty("mail.password"));

        Properties props = new Properties();
        props.put("mail.smtp.auth", env.getProperty("mail.smtp.auth"));
        props.put("mail.smtp.ssl.enable", env.getProperty("mail.smtp.ssl.enable"));
        props.put("mail.smtp.ssl.trust", env.getProperty("mail.smtp.ssl.trust"));
        mailSender.setJavaMailProperties(props);
        mailSender.setDefaultEncoding(env.getProperty("mail.default.encoding"));

        return mailSender;
    }
}

