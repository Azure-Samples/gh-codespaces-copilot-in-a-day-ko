package roadshow.demo.api.cors;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@Profile("dev")
public class CorsConfigDev implements WebMvcConfigurer  {

    @Value("${CORS_ORIGIN}")
    private String cors_origin;

    //private static final String ALLOWED_ORIGINS = "${CORS_ORIGIN}";

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/messages")
                .allowedOrigins(cors_origin)
                .allowedMethods("POST")
                .allowedHeaders("*");
    }
}
