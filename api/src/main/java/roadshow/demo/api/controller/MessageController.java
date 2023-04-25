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
// import org.springframework.web.util.UriComponentsBuilder;

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
        String preMsg = "{\"role\": \"system\", \"content\": \"You are helpful Azure expert assistant.\"},";
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        //make header with key "api-key"
        headers.set("api-key", aoaiApiToken);
        
        String body = "{\"messages\": [" + preMsg + "{\"role\": \"user\", \"content\": \"" + inputMsg + "\"}], \"max_tokens\": 100}";
        HttpEntity<String> entity = new HttpEntity<String>(body, headers);
        
        //UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(aoaiUrl);
        
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
            content = "Sorry, I am not able to answer your question. Please try again.";
        }

        //jsonify content with key "reply"
        ObjectMapper objectMapper = new ObjectMapper();
        ObjectWriter writer = objectMapper.writer(new DefaultPrettyPrinter());
        
        String json = writer.writeValueAsString(Collections.singletonMap("reply", content));
        
        return json;
    }
}

//Make a external API call with WebClient. 
//1. Get form text data from the client side(React) like public class MessageController{}. It is a POST method.
//2. The external API call method should be POST. The body of the POST should look like this: {"messages": [{"role": "", "context": ""}]}. And the backend server needs to send the String data received from client in #1 as "context" to the external API.
//3. The external API call should also have a header like this: {"Authorization": "Bearer " + token}. The token is a String data. 
//4. The external API call should return a JSON object like this: 
// {
//     "id": "chatcmpl-795vv3rwLXKcO3DRNESpsVrVBrdlp",
//     "object": "chat.completion",
//     "created": 1682402115,
//     "model": "gpt-4-32k",
//     "choices": [
//         {
//             "index": 0,
//             "finish_reason": "stop",
//             "message": {
//                 "role": "assistant",
//                 "content": "Yes, many other Azure Cognitive Services support customer managed keys for increased data security and access control. For example, Azure Search, Azure Form Recognizer, and Azure Text Analytics support customer managed keys to encrypt and protect your data. The availability of this feature may vary among different Cognitive Services, so it's always a good idea to review the specific service documentation to confirm if customer managed keys are supported by the service you are interested in using."
//             }
//         }
//     ],
//     "usage": {
//         "completion_tokens": 88,
//         "prompt_tokens": 54,
//         "total_tokens": 142
//     }
// }. 
//The backend server needs to return the String data("choices"["message"["content"]]) received from the external API to the client side(React).

