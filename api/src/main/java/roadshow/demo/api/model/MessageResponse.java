package roadshow.demo.api.model;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(name = "MessageResponse", description = "Response body schema for the message API")
public class MessageResponse {
    @Schema(description = "AOAI 답변", required = true, example = "Azure의 장점은 말입니다...")
    private String reply;

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }
}
