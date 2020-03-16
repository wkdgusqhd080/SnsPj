package sns.board.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;
import sns.board.service.BoardRestService;
import sns.domain.Board_Reply;
import sns.domain.Member;
import sns.vo.BoardReplyListResult;


@RestController
@RequestMapping("board_rest")
@Log4j
public class BoardRestController {
	
	@Inject
	BoardRestService boardRestService;
		
	@GetMapping(value="list/{b_seq}", params= {"cp"})
	public BoardReplyListResult replyRead(@PathVariable long b_seq, @RequestParam long cp) {
		if(cp == 0) cp = 1;
		//log.info("#cp: " + cp + "#b_seq: " + b_seq);
		return boardRestService.getBoardReplyListResult(cp, b_seq);
	}
	
	@PostMapping(value="create/{b_seq}")
	public BoardReplyListResult replyCreate(@PathVariable long b_seq, HttpSession session, @RequestBody String brp_content) {
		log.info("#brp_content: " + brp_content);
		Member m = (Member)session.getAttribute("loginUser");
		String mem_email = m.getMem_email();
		return boardRestService.insertBoardReplyS(b_seq, mem_email, brp_content);
	}
	
	
}
