package roadshow.demo.api.model;

// ⬇️ GH Copilot Demo ⬇️
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(name = "MessageRequest", description = "Request body schema for the message API")
public class MessageRequest {
    @Schema(description = "AOAI에게 질문할 내용", required = true, example="Azure의 장점에 대해 알려줘.")
    private String text;

    public String getText() {
        return text;
    }

    public void setText(String text){
        this.text = text;
    }
}

// ⬆️ GH Copilot Demo ⬆️