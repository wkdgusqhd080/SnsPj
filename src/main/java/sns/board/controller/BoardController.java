package sns.board.controller;



import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import sns.board.service.BoardService;
import sns.domain.Member;
import sns.vo.BoardLikeVo;
import sns.vo.BoardListResult;
import sns.vo.BoardPagingVo;

@Log4j
@RequestMapping("board")
@Controller
@AllArgsConstructor
public class BoardController {
	
	BoardService boardService;

	@RequestMapping(value = "list.do", method = RequestMethod.POST)
	public String boardList(HttpSession session, Model model, String mem_email) {
		long cp = 1;
		long ps = 3;
		BoardListResult boardListResult = boardService.getBoardListResult(cp, ps, mem_email);
		model.addAttribute("boardListResult", boardListResult);
		return "board/list";
	}
	
	@GetMapping("infinityList.do")
	@ResponseBody
	public BoardListResult infinityList(long cp, HttpSession session) {
		Member m = (Member)session.getAttribute("loginUser");
		String mem_email = m.getMem_email();
		long ps = 3;
		return boardService.getBoardListResult(cp, ps, mem_email);
	}
	
	
	@PostMapping("likeAjax.do")
	@ResponseBody
	public BoardLikeVo likeAjax(String str) {
		String[] strs = str.split(",");
		String cmd = strs[0];
		String b_seqStr = strs[1]; long b_seq = Integer.parseInt(b_seqStr);
		String mem_email = strs[2]; //log.info("#cmd: " + cmd);
		BoardLikeVo boardLikeVo = boardService.likePlusMinus(b_seq, mem_email, cmd);
		return boardLikeVo;
	}
	
	@RequestMapping(value ="searchList.do", method=RequestMethod.GET)
	public ModelAndView boardSearch(String keyword, HttpSession session) {
		Member m = (Member)session.getAttribute("loginUser");
		String mem_email = m.getMem_email();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("board/search_list");
		mv.addObject("userSearchListResult", boardService.getUserSearchListResult(keyword, mem_email));
		return mv;
	}
	
	
	
}