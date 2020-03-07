package sns.board.controller;



import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.AllArgsConstructor;
import sns.board.service.BoardService;
import sns.domain.Member;
import sns.vo.BoardListResult;
import sns.vo.BoardPagingVo;

@RequestMapping("board")
@Controller
@AllArgsConstructor
public class BoardController {
	
	BoardService boardService;

	@RequestMapping(value = "list.do", method = RequestMethod.POST)
	public String board(HttpSession session, Model model, String mem_email) {
		long cp = 1;
		long ps = 3;
		BoardListResult boardListResult = boardService.getBoardListResult(cp, ps, mem_email);
		model.addAttribute("boardListResult", boardListResult);
		return "board/list";
	}
}