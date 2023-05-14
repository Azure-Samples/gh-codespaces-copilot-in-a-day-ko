package roadshow.demo.api;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;

@Configuration
public class OpenAPIConfig {
    
    // ⬇️ copilot demo ⬇️ - Content, Info, License
    
    //Define new OpenAPI object
    @Bean
    public OpenAPI newOpenAPI(){
        //Define new contact
        // set email & name
        Contact contact = new Contact();
        contact.setEmail("azureracoon@micrsoft.com");
        contact.setName("Azure Racoon");

        //Define license
        // set name & url
        License license = new License();
        license.setName("Apache 2.0");
        license.setUrl("https://www.apache.org/licenses/LICENSE-2.0.html");

        //Define Info
        // set title, description, version, contact, license
        Info info = new Info();
        info.setTitle("askmeazure.openai API");
        info.setDescription("GH Roadshow 데모 API");
        info.setVersion("1.0.0");
        info.setContact(contact);
        info.setLicense(license);

        return new OpenAPI().info(info);
    }


    // ⬆️ copilot demo ⬆️
}
