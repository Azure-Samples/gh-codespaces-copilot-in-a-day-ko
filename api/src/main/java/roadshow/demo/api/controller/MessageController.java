package roadshow.demo.api.controller;

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
import com.fasterxml.jackson.databind.ObjectMapper;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import roadshow.demo.api.model.MessageRequest;
import roadshow.demo.api.model.MessageResponse;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;

@Tag(name = "Messages", description = "질문 제출 및 답변 호출")
@RestController
@RequestMapping("/api/messages")
public class MessageController {

    //⬇️ copilot demo ⬇️
    @Value("${AOAI_API_ENDPOINT}")
    private String aoaiEndpoint;

    @Value("${AOAI_API_KEY}")
    private String aoaiApiKey;

    @Value("${AOAI_DEPLOYMENT_ID}")
    private String aoaiDeploymentId;

    @Value("${AOAI_API_VERSION}")
    private String aoaiApiVersion;

    private static final String ALLOWED_ORIGINS = "${CORS_ORIGIN}";

    private static final String errorJson = "{\n    \"reply\": \"죄송해요, 지금은 답을 드릴 수 없어요. 서버에 문제가 있는 것 같아요. 다시 시도해주세요. 😥\"  \n}";

    //OpenAPI Configuration
    @Operation(
        summary = "Azure OpenAI API 질문 제출 및 답변 호출",
        description = "AOAI API(GPT 3.5)를 호출하여 질문을 text로 전달하고 content 답변을 받아 리턴합니다.",

        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "text 키 값으로 질문을 전달합니다.",
            required = true,
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = MessageRequest.class)
            )
        ),

        responses = {
            @ApiResponse(responseCode = "200", description = "성공", content = {
                @Content(
                    mediaType = "application/json",
                    schema = @Schema(implementation = MessageResponse.class)
                )
            }),
    
            @ApiResponse(responseCode = "404", description = "AOAI 호출 throttling error", content = { 
                @Content(
                    mediaType = "application/json",
                    examples = @ExampleObject(value = errorJson),
                    schema = @Schema(implementation = MessageResponse.class)
                )
            }),

            @ApiResponse(responseCode = "500", description = "AOAI Endpoint 또는 API Key 에러", content = { 
                @Content(
                    mediaType = "application/json",
                    examples = @ExampleObject(value = errorJson),
                    schema = @Schema(implementation = MessageResponse.class)
                ) 
            }) 
        }
    )

    // ⬇️⬇️⬇️ Uncomment the line below to enable CORS ⬇️⬇️⬇️
    // @CrossOrigin(origins = ALLOWED_ORIGINS)
    // ⬆️⬆️⬆️ Uncomment the line above to enable CORS ⬆️⬆️⬆️

    // ⬇️ GH Copilot Demo ⬇️
    //Make PostMapping with 

    @PostMapping
    public MessageResponse sendMessage(@RequestBody MessageRequest request) throws JsonMappingException, JsonProcessingException {
        // System.out.println("aoaiEndpoint: " + aoaiEndpoint);
        // System.out.println("aoaiApiKey: " + aoaiApiKey);

        String requestUrl = aoaiEndpoint + "openai/deployments/" + aoaiDeploymentId + "/chat/completions?api-version=" + aoaiApiVersion;

        // ⬇️ copilot demo ⬇️
        String inputMsg = request.getText();
        String preMsg = "{\"role\": \"system\", \"content\": \"너는 Azure 전문가 Azure Bot이야. 한국어로 대답해줘. 그리고 전체 답변이 300 토큰을 넘지 않도록 잘 요약해줘.\"},";
        // ⬆️ copilot demo ⬆️
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        //make header with key "api-key"
        headers.set("api-key", aoaiApiKey);
        
        String body = "{\"messages\": [" + preMsg + "{\"role\": \"user\", \"content\": \"" + inputMsg + "\"}], \"max_tokens\": 300}";
        HttpEntity<String> entity = new HttpEntity<String>(body, headers);
        
        // ⬇️ copilot demo ⬇️
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response;
        String reply;

        //Make try catch exception for ResponseEntity<String> response = restTemplate.postForEntity(requestUrl, entity, String.class);
        try {
            response = restTemplate.postForEntity(requestUrl, entity, String.class);
            String jsonResponse = response.getBody();
            // Parse the JSON string using Jackson
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(jsonResponse);
            reply = rootNode.get("choices").get(0).get("message").get("content").asText();

        } catch(Exception e) {
            System.out.println("Exception: " + e);
            reply = "죄송해요, 지금은 답을 드릴 수 없어요. 서버에 문제가 있는 것 같아요. 다시 시도해주세요. 😥";;
        }
        
        MessageResponse messageResponse = new MessageResponse();
        messageResponse.setReply(reply);
        return messageResponse;
        // ⬆️ copilot demo ⬆️

    }
}