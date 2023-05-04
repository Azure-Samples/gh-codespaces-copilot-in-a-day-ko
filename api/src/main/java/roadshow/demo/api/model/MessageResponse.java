package roadshow.demo.api.model;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(name = "MessageResponse", description = "Response body schema for the message API")
public class MessageResponse {
    @Schema(description = "AOAI 답변", required = true, example = "Azure의 장점은 말입니다...")
    private String content;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
