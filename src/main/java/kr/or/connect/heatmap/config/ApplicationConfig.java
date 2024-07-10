package kr.or.connect.heatmap.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@ComponentScan(basePackages= {"kr.or.connect.heatmap.dao"})
@Import({DBConfig.class})
public class ApplicationConfig {
	
}
