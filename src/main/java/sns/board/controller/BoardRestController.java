package sns.board.controller;

import javax.inject.Inject;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;
import sns.board.service.BoardRestService;
import sns.vo.BoardReplyListResult;


@RestController
@RequestMapping("board_rest")
@Log4j
public class BoardRestController {
	
	@Inject
	BoardRestService boardRestService;
		
	@GetMapping(value="list/{b_seq}", params= {"cp"})
	public BoardReplyListResult replyList(@PathVariable long b_seq, @RequestParam long cp) {
		if(cp == 0) cp = 1;
		log.info("#나오나요");
		//log.info("#cp: " + cp + "#b_seq: " + b_seq);
		return boardRestService.getBoardReplyListResult(cp, b_seq);
	}
	
	
}
