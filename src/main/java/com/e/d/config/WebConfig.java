package com.e.d.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/youtubeProject/**")
            .addResourceLocations("file:///C:/youtubeProject/");

        registry.addResourceHandler("/youtubeProject/profile-img/**")
            .addResourceLocations("file:///C:/youtubeProject/profile-img/");
        
        registry.addResourceHandler("/youtubeProject/video-img/**")
        	.addResourceLocations("file:///C:/youtubeProject/video-img/");
    }
}
