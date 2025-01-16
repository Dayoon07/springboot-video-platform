package com.e.d.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${file.upload-dir}")
    private String basePath;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String resolvedBasePath = "file:///" + basePath.replace("\\", "/");

        registry.addResourceHandler("/youtubeProject/**")
            .addResourceLocations(resolvedBasePath);

        registry.addResourceHandler("/youtubeProject/profile-img/**")
            .addResourceLocations(resolvedBasePath + "profile-img/");

        registry.addResourceHandler("/youtubeProject/video-img/**")
            .addResourceLocations(resolvedBasePath + "video-img/");
    }
}