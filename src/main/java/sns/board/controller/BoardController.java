package sns.board.controller;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("board")
@Controller
public class BoardController {
	@RequestMapping(value = "list.do", method = RequestMethod.GET)
	public String board(String mem_email) {

		
		
		
		
		
		return "board/list";
	}
}