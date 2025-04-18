package com.fastcampus.gearshift.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // ✅ 뉴스 업로드용 썸네일 경로 매핑 추가
        registry.addResourceHandler("/upload/**")  // <-- URL
                .addResourceLocations("file:///C:/upload/"); // <-- 실제 경로

        // 기존 설정 유지
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:///C:/upload/")
                .addResourceLocations("file:///C:/Dev/reviews/");
        registry.addResourceHandler("/chatbot/**")
                .addResourceLocations("/chatbot/");
    }
}

