package sns.chat.controller;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("chat")
@Controller
public class ChatController {
	@RequestMapping(value = "chatbox", method = RequestMethod.GET)
	public String board() {
		return "chatting/chat_box";
	}
}