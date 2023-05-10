package roadshow.demo.api;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;

@Configuration
public class OpenAPIConfig {
    
    // ⬇️ copilot demo ⬇️
    @Bean
    public OpenAPI myOpenAPI() {
        Contact contact = new Contact();
        contact.setEmail("nayeonkim@microsoft.com");
        contact.setName("Nayeon Kim");
        
        License license = new License().name("MIT License").url("https://choosealicense.com/licenses/mit/");

        Info info = new Info()
            .title("Ask Me Azure.OpenAI API")
            .version("1.0.0")
            .contact(contact)
            .description("Azure OpenAI를 이용한 Azure 봇 서비스 API")
            .license(license);
        
        return new OpenAPI().info(info);
    }
    // ⬆️ copilot demo ⬆️
}
