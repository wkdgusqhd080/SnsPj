package sns.board.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;
import sns.board.service.BoardRestService;
import sns.domain.Board_Reply;
import sns.domain.Member;
import sns.vo.BoardReplyListResult;
import sns.vo.BoardReplyUpdateVo;


@RestController
@RequestMapping("board_rest")
@Log4j
public class BoardRestController {
	
	@Inject
	BoardRestService boardRestService;
		
	@GetMapping(value="list/{b_seq}", params={"cp"})
	public BoardReplyListResult replyRead(@PathVariable long b_seq, @RequestParam long cp) {
		if(cp == 0) cp = 1;
		//log.info("#cp: " + cp + "#b_seq: " + b_seq);
		return boardRestService.getBoardReplyListResult(cp, b_seq);
	}
		
	
	@PostMapping(value="create/{b_seq}")
	public BoardReplyListResult replyCreate(@PathVariable long b_seq, HttpSession session, @RequestBody String brp_content) {
		//log.info("#brp_content: " + brp_content);
		Member m = (Member)session.getAttribute("loginUser");
		String mem_email = m.getMem_email();
		return boardRestService.insertBoardReplyS(b_seq, mem_email, brp_content.trim());
	}
	
	@RequestMapping(value="/update/{brp_seq}", method=RequestMethod.PATCH)//put은 해당자원의 전체를 교체 patch는 부분적인 data 업데이트경우
	public BoardReplyListResult replyUpdate(@PathVariable long brp_seq, @RequestBody BoardReplyUpdateVo boardReplyUpdateVo) {
		log.info("#cpStr: " + boardReplyUpdateVo.getCpStr() + ", content: " + boardReplyUpdateVo.getBrp_content());
		long cp = Long.parseLong(boardReplyUpdateVo.getCpStr());
		return boardRestService.updateBoardReplyS(brp_seq, boardReplyUpdateVo.getBrp_content().trim(), cp);
	}
	
	
	
}
