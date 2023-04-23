package roadshow.demo.api.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/messages")
public class MessageController {
    @PostMapping
    public Map<String, String> sendMessage(@RequestBody Map<String, String> requestBody) {
        String text = requestBody.get("text");

        // Process the message and generate a response
        String result = "Hello, " + text + "!";

        // Return the response as a JSON object
        Map<String, String> responseBody = new HashMap<>();
        responseBody.put("result", result);
        return responseBody;
    }
}
