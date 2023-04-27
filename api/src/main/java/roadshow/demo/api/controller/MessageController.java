package roadshow.demo.api.controller;

import java.util.Collections;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.core.util.DefaultPrettyPrinter;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/messages")
public class MessageController {

    //aoai-url from application.properties
    @Value("${aoaiurl}")
    private String aoaiUrl;

    @Value("${aoaikey}")
    private String aoaiApiToken;

    @PostMapping
    public String sendMessage(@RequestBody Map<String, String> requestBody) throws JsonMappingException, JsonProcessingException {
        System.out.println("aoaiUrl: " + aoaiUrl);
        System.out.println("aoaiApiToken: " + aoaiApiToken);

        String inputMsg = requestBody.get("text");
        String preMsg = "{\"role\": \"system\", \"content\": \"너는 Azure 전문가 Azure Bot이야. 한국어로 대답해줘. 그리고 전체 답변이 300 토큰을 넘지 않도록 잘 요약해줘.\"},";
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        //make header with key "api-key"
        headers.set("api-key", aoaiApiToken);
        
        String body = "{\"messages\": [" + preMsg + "{\"role\": \"user\", \"content\": \"" + inputMsg + "\"}], \"max_tokens\": 300}";
        HttpEntity<String> entity = new HttpEntity<String>(body, headers);
        
        
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response;
        String content;

        //Make try catch exception for ResponseEntity<String> response = restTemplate.postForEntity(aoaiUrl, entity, String.class);
        try {
            response = restTemplate.postForEntity(aoaiUrl, entity, String.class);
            String jsonResponse = response.getBody();
            // Parse the JSON string using Jackson
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(jsonResponse);
            content = rootNode.get("choices").get(0).get("message").get("content").asText();

        } catch(Exception e) {
            System.out.println("Exception: " + e);
            content = "죄송해요, 지금은 답을 드릴 수 없어요. 서버에 문제가 있는 것 같아요. 다시 시도해주세요. 😥";
        }

        //jsonify content with key "reply"
        ObjectMapper objectMapper = new ObjectMapper();
        ObjectWriter writer = objectMapper.writer(new DefaultPrettyPrinter());
        
        String json = writer.writeValueAsString(Collections.singletonMap("reply", content));
        
        return json;
    }
}