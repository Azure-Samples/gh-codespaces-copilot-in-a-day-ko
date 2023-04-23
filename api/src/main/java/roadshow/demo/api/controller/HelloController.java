package roadshow.demo.api.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

	@GetMapping("/")
	public String index() {
		return "Greetings from Spring Boot!";
	}

    @GetMapping("/hello")
	public List<String> Hello(){
        return Arrays.asList("Github Codespace 테스트", "Github Copilot 테스트");
    }

}
