package sns.board.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;
import sns.vo.BoardReplyListResult;

@RestController
@RequestMapping("board_rest")
@Log4j
public class BoardRestController {
	
	@GetMapping(value="/list/${b_seq}")
	public BoardReplyListResult replyList() {
		return new BoardReplyListResult();
	}
}
